import 'package:flutter/material.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class RecipeMakerContainer extends StatefulWidget {
  @override
  _RecipeMakerContainerState createState() => _RecipeMakerContainerState();
}

class _RecipeMakerContainerState extends State<RecipeMakerContainer> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String recipeName;
  List recipeCategory;
  int recipePortion;

  List ingridients;

  Map ing1;
  String igUnit1;
  String igAmt1;
  String igName1;

  Map ing2;
  int igUnit2;
  int igAmt2;
  String igName2;

  int recipePreparationTime;
  int recipeCookingTime;
  int recipeRestTime;
  String recipeDifficulty;
  double recipeCalories;

  Widget makeIg1(screenWidth) {
    Widget ig1 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Container(
            width: screenWidth * 0.20,
            child: FormBuilderDropdown(
              attribute: "unit",
              decoration: InputDecoration(labelText: ""),
              items: [
                'mg',
                'gm',
                'kg',
                'ml',
                'teaspoon',
                'tablespoon',
                'cup',
                'mm',
                'cm',
                'inch'
              ]
                  .map((unit) =>
                      DropdownMenuItem(value: unit, child: Text("$unit")))
                  .toList(),

              onChanged: (value) {
                setState(() {
                  igUnit1 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child:  Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            width: screenWidth * 0.30,
            child: FormBuilderTextField(
              attribute: "amount",
              decoration: InputDecoration(
                  labelText: "amt", helperStyle: TextStyles.recipe),
              keyboardType: TextInputType.text,
            //  textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                setState(() {
                  igAmt1 = value;
                });
              },
            ),
          ),
        ),
          
          
          // Padding(
          //   padding: const EdgeInsets.only(top: 14.0),
          //   child: FormBuilderTextField(
          //     attribute: "amount",
          //     decoration: InputDecoration(
          //         labelText: "amt", helperStyle: TextStyles.recipe),
          //     keyboardType: TextInputType.text,
          //     textCapitalization: TextCapitalization.characters,
          //     onChanged: (amount) {
          //       setState(() {
          //         igAmt1 = amount;
          //       });
          //     },
          //   ),
          // ),
        ),
        SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Container(
            width: screenWidth * 0.30,
            child: FormBuilderTextField(
              attribute: "ingridient",
              decoration: InputDecoration(
                  labelText: "ingridient name", helperStyle: TextStyles.recipe),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                setState(() {
                  igName1 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              print(igUnit1);
              ing1 = {"igName1": igName1, "igAmt1": igAmt1, "igUnit1": igUnit1};
            });
          },
          child: Icon(
            Icons.done,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig1;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: screenHeight * 0.92,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                color: uniColors.lcRed,
                //  height:screenHeight*3,
                width: screenWidth,
                height: screenHeight * 0.08,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.close,
                        color: uniColors.white1,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                          child: Text(
                        Strings.RECIPE_MAKER,
                        style: TextStyles.recipeMaker,
                      )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.done,
                        color: uniColors.white1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.8,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Expanded(
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FormBuilder(
                            key: _fbKey,
                            initialValue: {
                              'date': DateTime.now(),
                              'accept_terms': false,
                            },
                            autovalidate: true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                //RecipeName
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_NAME,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 15),
                                      Container(
                                        width: screenWidth * 0.45,
                                        child: FormBuilderTextField(
                                          attribute: "recipeName",
                                          //    decoration:InputDecoration(labelText: "Recipe Name",helperStyle: TextStyles.recipe),
                                          keyboardType: TextInputType.text,
                                          validators: [
                                            // FormBuilderValidators.
                                            FormBuilderValidators.max(25),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              recipeName = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //RecipeCategory
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        //   mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            child: Text(Strings.RECIPE_CATEGORY,
                                                style: TextStyles.recipe),
                                          ),
                                          SizedBox(width: 35),
                                          Expanded(
                                            child: Container(
                                              width: screenWidth,
                                              child: FormBuilderFilterChip(
                                                attribute: "categories",
                                                onChanged: (value) {
                                                  setState(() {
                                                    recipeCategory = value;
                                                    print(recipeCategory);
                                                  });
                                                },
                                                options: [
                                                  FormBuilderFieldOption(
                                                      child: Text("Vegan"),
                                                      value: "Vegan"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Vegetarian"),
                                                      value: "Vegetarian"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Low-carb"),
                                                      value: "Low-carb"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Keto"),
                                                      value: "Keto"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Organic"),
                                                      value: "Organic"),
                                                  FormBuilderFieldOption(
                                                      child:
                                                          Text("Clean Eating"),
                                                      value: "Clean Eating"),
                                                  FormBuilderFieldOption(
                                                      child:
                                                          Text("Lactose-free"),
                                                      value: "Lactose-free"),
                                                  FormBuilderFieldOption(
                                                      child:
                                                          Text("Gluten-free"),
                                                      value: "Gluten-free"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Chef cook"),
                                                      value: "Chef cook"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Gourmet"),
                                                      value: "Gourmet"),
                                                  FormBuilderFieldOption(
                                                      child:
                                                          Text("Sweet Tooth"),
                                                      value: "Sweet Tooth"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Healthy"),
                                                      value: "Healthy"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Raw"),
                                                      value: "Raw"),
                                                  FormBuilderFieldOption(
                                                      child: Text("Paleo"),
                                                      value: "Paleo"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                //RecipePortion
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_PORTION,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 50),
                                      Container(
                                        width: screenWidth * 0.45,
                                        child: FormBuilderTouchSpin(
                                          decoration:
                                              InputDecoration(labelText: ""),
                                          attribute: "portion",
                                          initialValue: 1,
                                          step: 1,
                                          onChanged: (value) {
                                            setState(() {
                                              recipePortion = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //RecipeIngridients
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 25.0),
                                        child: Container(
                                          child: Text(
                                              Strings.RECIPE_INGRIDIENTS,
                                              style: TextStyles.recipe),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        children: <Widget>[
                                          makeIg1(screenWidth),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                //PreparationTime
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                            Strings.RECIPE_PREPARATION_TIME,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: screenWidth * 0.20,
                                        child: FormBuilderTextField(
                                          attribute: "preparationTime",
                                          decoration: InputDecoration(
                                              labelText: "Mins",
                                              helperStyle: TextStyles.recipe),
                                          //keyboardType: TextInputType.,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          validators: [
                                            // FormBuilderValidators.
                                            FormBuilderValidators.max(25),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              recipePreparationTime = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //CookingTime
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_COOKING_TIME,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: screenWidth * 0.20,
                                        child: FormBuilderTextField(
                                          attribute: "cookingTime",
                                          decoration: InputDecoration(
                                              labelText: "Mins",
                                              helperStyle: TextStyles.recipe),
                                          //keyboardType: TextInputType.,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          validators: [
                                            // FormBuilderValidators.
                                            FormBuilderValidators.max(25),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              recipeCookingTime = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //RestTime
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_REST_TIME,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: screenWidth * 0.20,
                                        child: FormBuilderTextField(
                                          attribute: "restTime",
                                          decoration: InputDecoration(
                                              labelText: "Mins",
                                              helperStyle: TextStyles.recipe),
                                          //keyboardType: TextInputType.,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          validators: [
                                            // FormBuilderValidators.
                                            FormBuilderValidators.max(25),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              recipeRestTime = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //RecipeDifficulty
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_DIFFICULTY,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: screenWidth * 0.40,
                                        child: FormBuilderDropdown(
                                          attribute: "difficulty",
                                          decoration:
                                              InputDecoration(labelText: ""),
                                          items: [
                                            'Fool proof',
                                            'Quick & Easy',
                                            'Fastfood',
                                            'Pro',
                                            'Fine Dining',
                                            'Festive',
                                          ]
                                              .map((difficulty) =>
                                                  DropdownMenuItem(
                                                      value: difficulty,
                                                      child:
                                                          Text("$difficulty")))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              recipeDifficulty = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //RecipeCalories
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_CALORIES,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        width: screenWidth * 0.65,
                                        child: FormBuilderSlider(
                                          attribute: "calories",
                                          // validators: [FormBuilderValidators.min(6)],
                                          min: 0.0,
                                          max: 1500.0,
                                          initialValue: 100.0,
                                          divisions: 10,
                                          decoration:
                                              InputDecoration(labelText: ""),
                                          onChanged: (value) {
                                            setState(() {
                                              recipeCalories = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              MaterialButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  if (_fbKey.currentState.saveAndValidate()) {
                                    print(
                                        _fbKey.currentState.value.runtimeType);
                                          print(igUnit1);
                                    print(ing1);
                                  }
                                },
                              ),
                              MaterialButton(
                                child: Text("Reset"),
                                onPressed: () {
                                  _fbKey.currentState.reset();
                                },
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
