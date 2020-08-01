import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lcl/models/recipe.dart';

import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/resources/recipeMethods.dart';
import 'package:lcl/screens/recipeScreens/recipeDetails.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lcl/widgets/CustomTile.dart';

import 'package:provider/provider.dart';

class DetailedSearchScreen extends StatefulWidget {
  @override
  _DetailedSearchScreenState createState() => _DetailedSearchScreenState();
}

class _DetailedSearchScreenState extends State<DetailedSearchScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _searchKey = GlobalKey<FormBuilderState>();

  List<Recipe> allRecipeList;
  List<Recipe> magicFilterList;

  @override
  void initState() {
    // TODO: implement initState
    _repository.fetchRecipeBatch().then((List<Recipe> recipes) {
      setState(() {
        allRecipeList = recipes;
        magicFilterList = allRecipeList;
      });
    });
    super.initState();
  }

  FirebaseRepository _repository = FirebaseRepository();

  final RecipeMethods _recipeMethods = RecipeMethods();

  String filterRecipeDiet = "";
  String filterRecipeDifficulty = "";
  String filterRecipeType = "";
  String filterRecipeCuisine = "";

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    StorageReference _storageReference;


    buildFilterSuggestions(
        String diet, String difficulty, String type, String cuisine) {
      final List<Recipe> suggestionList =
          (diet == "" && difficulty == "" && type == "" && cuisine == "")
              ? allRecipeList
              : allRecipeList.where((Recipe recipe) {
                  bool matchesDiet = recipe.recipeDiet == diet;
                  bool matchesDifficulty =
                      recipe.recipeDifficulty == difficulty;
                  bool matchesType = recipe.recipeType == type;
                  bool matchesCuisine = recipe.recipeCuisine == cuisine;

                  return (matchesDiet ||
                      matchesDifficulty ||
                      matchesType ||
                      matchesCuisine);
                }).toList();
                for(int i=0;i<suggestionList.length;i++){
                  print(suggestionList[i].recipeName);
                }

      setState(() {
        magicFilterList = suggestionList;
      });
    }

    return SafeArea(
      child: Container(
        color: Colors.white,
        height: screenHeight * 0.92,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                color: uniColors.lcRed,
                //  height:screenHeight*3,
                width: screenWidth,
                height: screenHeight * 0.08,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.close,
                          color: uniColors.white1,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 7,
                      child: Center(
                          child: Text(
                        Strings.SEARCH,
                        style: TextStyles.recipeMaker,
                      )),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Icon(
                    //     Icons.done,
                    //     color: uniColors.white1,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              color: uniColors.transparent,
              height: screenHeight * 0.15,
              width: screenWidth,
              child: Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: FormBuilder(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                Strings.DIET,
                                style: TextStyles.filterNames,
                              ),
                              Container(
                                width: screenWidth * 0.2,
                                child: FormBuilderDropdown(
                                  attribute: "diet",
                                  decoration: InputDecoration(labelText: ""),
                                  items: [
                                    '',
                                    'Vegan',
                                    'Vegatarian',
                                    'Low-Carb/Keto',
                                    'Lactose-free',
                                    'Gluten-free',
                                    'Healthy',
                                    'Low Calorie'
                                  ]
                                      .map((diet) => DropdownMenuItem(
                                          value: diet,
                                          child: Text(
                                            "$diet",
                                            style: TextStyles.recipeSubFilters,
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterRecipeDiet = value;
                                      buildFilterSuggestions(filterRecipeDiet,filterRecipeDifficulty,filterRecipeType,filterRecipeCuisine);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                Strings.DIFFICULTY,
                                style: TextStyles.filterNames,
                              ),
                              Container(
                                width: screenWidth * 0.2,
                                child: FormBuilderDropdown(
                                  attribute: "difficulty",
                                  decoration: InputDecoration(labelText: ""),
                                  items: [
                                    '',
                                    'Fool proof',
                                    'Average',
                                    'Pro',
                                  ]
                                      .map((difficulty) => DropdownMenuItem(
                                          value: difficulty,
                                          child: Text(
                                            "$difficulty",
                                            style: TextStyles.recipeSubFilters,
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterRecipeDifficulty = value;
                                      buildFilterSuggestions(filterRecipeDiet,filterRecipeDifficulty,filterRecipeType,filterRecipeCuisine);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                Strings.TYPE,
                                style: TextStyles.filterNames,
                              ),
                              Container(
                                width: screenWidth * 0.2,
                                child: FormBuilderDropdown(
                                  attribute: "type",
                                  decoration: InputDecoration(labelText: ""),
                                  items: [
                                    '',
                                    'Breakfast',
                                    'Lunch/Dinner',
                                    'Snack',
                                    'Main course',
                                    'Dessert',
                                    'Baking',
                                    'Drink',
                                  ]
                                      .map((type) => DropdownMenuItem(
                                          value: type,
                                          child: Text(
                                            "$type",
                                            style: TextStyles.recipeSubFilters,
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterRecipeType = value;
                                      buildFilterSuggestions(filterRecipeDiet,filterRecipeDifficulty,filterRecipeType,filterRecipeCuisine);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                Strings.CUISINE,
                                style: TextStyles.filterNames,
                              ),
                              Container(
                                width: screenWidth * 0.2,
                                child: FormBuilderDropdown(
                                  attribute: "type",
                                  decoration: InputDecoration(labelText: ""),
                                  items: [
                                    '',
                                    'African',
                                    'American',
                                    'Asian',
                                    'Eastern European',
                                    'French',
                                    'Fusion',
                                    'Indian',
                                    'Mediterranean',
                                    'Middle Eastern',
                                    'Scandinavian',
                                    'South American',
                                    'Spanish',
                                    'Turkish',
                                    'Other',
                                  ]
                                      .map((cuisine) => DropdownMenuItem(
                                          value: cuisine,
                                          child: Text(
                                            "$cuisine",
                                            style: TextStyles.recipeSubFilters,
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterRecipeCuisine = value;
                                      buildFilterSuggestions(filterRecipeDiet,filterRecipeDifficulty,filterRecipeType,filterRecipeCuisine);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))),
              ),
            ),
            Container(
              height: screenHeight * 0.68,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                   
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                              Visibility(
                                visible: magicFilterList[0]!=null,
                                                              child: Container(
                                height: screenWidth * 0.45,
                                width: screenWidth * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  ),
                                  image: DecorationImage(
                                      image: (magicFilterList[0].recipePicture ==
                                                  "dummyNoImage" ||
                                              magicFilterList[0].recipePicture ==
                                                  null)
                                          ? AssetImage("assets/plate.jpg")
                                          : NetworkImage(
                                              "${magicFilterList[0].recipePicture}"),
                                      fit: BoxFit.cover),
                                ),
                            ),
                              ),
                           Visibility(
                             visible: magicFilterList[1]!=null,
                                                        child: Container(
                                height: screenWidth * 0.45,
                                width: screenWidth * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  ),
                                  image: DecorationImage(
                                      image: (magicFilterList[1].recipePicture ==
                                                  "dummyNoImage" ||
                                              magicFilterList[1].recipePicture ==
                                                  null)
                                          ? AssetImage("assets/plate.jpg")
                                          : NetworkImage(
                                              "${magicFilterList[1].recipePicture}"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                           ),
                          ],
                        ),
                      ),
                      // Visibility(
                      //   visible: magicFilterList[2]!=null,
                      //                         child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: <Widget>[
                      //       magicFilterList[2] ==null? Container():   Container(
                      //           height: screenWidth * 0.45,
                      //           width: screenWidth * 0.45,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(15.0),
                      //               topRight: Radius.circular(15.0),
                      //               bottomLeft: Radius.circular(15.0),
                      //               bottomRight: Radius.circular(15.0),
                      //             ),
                      //             image: DecorationImage(
                      //                 image: (magicFilterList[2].recipePicture ==
                      //                             "dummyNoImage" ||
                      //                         magicFilterList[2].recipePicture ==
                      //                             null)
                      //                     ? AssetImage("assets/plate.jpg")
                      //                     : NetworkImage(
                      //                         "${magicFilterList[2].recipePicture}"),
                      //                 fit: BoxFit.cover),
                      //           ),
                      //         ),
                      //         Visibility(
                      //           visible: magicFilterList[3]!=null,
                      //                                         child: Container(
                      //             height: screenWidth * 0.45,
                      //             width: screenWidth * 0.45,
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.only(
                      //                 topLeft: Radius.circular(15.0),
                      //                 topRight: Radius.circular(15.0),
                      //                 bottomLeft: Radius.circular(15.0),
                      //                 bottomRight: Radius.circular(15.0),
                      //               ),
                      //               image: DecorationImage(
                      //                   image: (magicFilterList[3].recipePicture ==
                      //                               "dummyNoImage" ||
                      //                           magicFilterList[3].recipePicture ==
                      //                               null)
                      //                       ? AssetImage("assets/plate.jpg")
                      //                       : NetworkImage(
                      //                           "${magicFilterList[3].recipePicture}"),
                      //                   fit: BoxFit.cover),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Visibility(
                      //   visible: magicFilterList[4]!=null,
                      //                         child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: <Widget>[
                      //        Container(
                      //           height: screenWidth * 0.45,
                      //           width: screenWidth * 0.45,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(15.0),
                      //               topRight: Radius.circular(15.0),
                      //               bottomLeft: Radius.circular(15.0),
                      //               bottomRight: Radius.circular(15.0),
                      //             ),
                      //             image: DecorationImage(
                      //                 image: (magicFilterList[4].recipePicture ==
                      //                             "dummyNoImage" ||
                      //                         magicFilterList[4].recipePicture ==
                      //                             null)
                      //                     ? AssetImage("assets/plate.jpg")
                      //                     : NetworkImage(
                      //                         "${magicFilterList[4].recipePicture}"),
                      //                 fit: BoxFit.cover),
                      //           ),
                      //         ),
                      //        Visibility(
                      //          visible: magicFilterList[5]!=null,
                      //                                       child: Container(
                      //             height: screenWidth * 0.45,
                      //             width: screenWidth * 0.45,
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.only(
                      //                 topLeft: Radius.circular(15.0),
                      //                 topRight: Radius.circular(15.0),
                      //                 bottomLeft: Radius.circular(15.0),
                      //                 bottomRight: Radius.circular(15.0),
                      //               ),
                      //               image: DecorationImage(
                      //                   image: (magicFilterList[5].recipePicture ==
                      //                               "dummyNoImage" ||
                      //                           magicFilterList[5].recipePicture ==
                      //                               null)
                      //                       ? AssetImage("assets/plate.jpg")
                      //                       : NetworkImage(
                      //                           "${magicFilterList[5].recipePicture}"),
                      //                   fit: BoxFit.cover),
                      //             ),
                      //           ),
                      //        ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                       Text(
                                "Under construction",
                                style: TextStyles.filterNames,
                              ),
                    ],
                  )

                  
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
