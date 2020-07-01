import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lcl/models/recipe.dart';
import 'package:lcl/provider/image_upload_provider.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/resources/recipeMethods.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:lcl/utils/utilities.dart';
import 'package:provider/provider.dart';

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

  FirebaseRepository _repository = FirebaseRepository();

  ImageUploadProvider _imageUploadProvider;

  String recipeName;
  String recipeDiet;
  int recipePortion;
  String recipeInstructions;

  String recipePreparationTime;
  String recipeCookingTime;
  String recipeRestTime;
  String recipeDifficulty;
  String recipeType;
  String recipeCuisine;
  String recipeCalories;

  int recipeYums;
  String recipePicture = "dd";

  static List recipeIngridients = new List()..length = 1;

  static String igUnit1;
  static String igAmt1;
  static String igName1;
  Map ing1 = {"igName1": igName1, "igAmt1": igAmt1, "igUnit1": igUnit1};


  bool showIg2 = false;
  static String igUnit2;
  static String igAmt2;
  static String igName2;
  Map ing2 = {"igName2": igName2, "igAmt2": igAmt2, "igUnit2": igUnit2};

  bool showIg3 = false;
  static String igUnit3;
  static String igAmt3;
  static String igName3;
  Map ing3 = {"igName3": igName3, "igAmt3": igAmt3, "igUnit2": igUnit3};

  bool showIg4 = false;
  static String igUnit4;
  static String igAmt4;
  static String igName4;
  Map ing4 = {"igName4": igName4, "igAmt4": igAmt4, "igUnit4": igUnit4};

  bool showIg5 = false;
  static String igUnit5;
  static String igAmt5;
  static String igName5;
  Map ing5 = {"igName5": igName5, "igAmt5": igAmt5, "igUnit5": igUnit3};

  bool showIg6 = false;
  static String igUnit6;
  static String igAmt6;
  static String igName6;
  Map ing6 = {"igName6": igName6, "igAmt6": igAmt6, "igUnit6": igUnit6};

   bool showIg7 = false;
 static String igUnit7;
 static String igAmt7;
 static String igName7;
 Map ing7 = {"igName7": igName7, "igAmt7": igAmt7, "igUnit7": igUnit7};
 
 bool showIg8 = false;
 static String igUnit8;
 static String igAmt8;
 static String igName8;
 Map ing8 = {"igName8": igName8, "igAmt8": igAmt8, "igUnit8": igUnit8};


 bool showIg9 = false;
 static String igUnit9;
 static String igAmt9;
 static String igName9;
 Map ing9 = {"igName9": igName9, "igAmt9": igAmt9, "igUnit9": igUnit9};
 
 bool showIg10 = false;
 static String igUnit10;
 static String igAmt10;
 static String igName10;
 Map ing10 = {"igName10": igName10, "igAmt10": igAmt10, "igUnit10": igUnit10};
 
 bool showIg11 = false;
 static String igUnit11;
 static String igAmt11;
 static String igName11;
 Map ing11 = {"igName11": igName11, "igAmt11": igAmt11, "igUnit11": igUnit11};
 
 bool showIg12 = false;
 static String igUnit12;
 static String igAmt12;
 static String igName12;
 Map ing12 = {"igName12": igName12, "igAmt12": igAmt12, "igUnit12": igUnit12};
 
 bool showIg13 = false;
 static String igUnit13;
 static String igAmt13;
 static String igName13;
 Map ing13 = {"igName13": igName13, "igAmt13": igAmt13, "igUnit13": igUnit13};
 
 bool showIg14 = false;
 static String igUnit14;
 static String igAmt14;
 static String igName14;
 Map ing14 = {"igName14": igName14, "igAmt14": igAmt14, "igUnit14": igUnit14};
 
 bool showIg15 = false;
 static String igUnit15;
 static String igAmt15;
 static String igName15;
 Map ing15 = {"igName15": igName15, "igAmt15": igAmt15, "igUnit15": igUnit15};
 
 bool showIg16 = false;
 static String igUnit16;
 static String igAmt16;
 static String igName16;
 Map ing16 = {"igName16": igName16, "igAmt16": igAmt16, "igUnit16": igUnit16};
 
 bool showIg17 = false;
 static String igUnit17;
 static String igAmt17;
 static String igName17;
 Map ing17 = {"igName17": igName17, "igAmt17": igAmt17, "igUnit17": igUnit17};
 
 bool showIg18 = false;
 static String igUnit18;
 static String igAmt18;
 static String igName18;
 Map ing18 = {"igName18": igName18, "igAmt18": igAmt18, "igUnit18": igUnit18};
 
 bool showIg19 = false;
 static String igUnit19;
 static String igAmt19;
 static String igName19;
 Map ing19 = {"igName19": igName19, "igAmt19": igAmt19, "igUnit19": igUnit19};
 
 bool showIg20 = false;
 static String igUnit20;
 static String igAmt20;
 static String igName20;
 Map ing20 = {"igName20": igName20, "igAmt20": igAmt20, "igUnit20": igUnit20};
 
 bool showIg21 = false;
 static String igUnit21;
 static String igAmt21;
 static String igName21;
 Map ing21 = {"igName21": igName21, "igAmt21": igAmt21, "igUnit21": igUnit21};
 
 bool showIg22 = false;
 static String igUnit22;
 static String igAmt22;
 static String igName22;
 Map ing22 = {"igName22": igName22, "igAmt22": igAmt22, "igUnit22": igUnit22};
 
 bool showIg23 = false;
 static String igUnit23;
 static String igAmt23;
 static String igName23;
 Map ing23 = {"igName23": igName23, "igAmt23": igAmt23, "igUnit23": igUnit23};
 
 bool showIg24 = false;
 static String igUnit24;
 static String igAmt24;
 static String igName24;
 Map ing24 = {"igName24": igName24, "igAmt24": igAmt24, "igUnit24": igUnit24};
 
 bool showIg25 = false;
 static String igUnit25;
 static String igAmt25;
 static String igName25;
 Map ing25 = {"igName25": igName25, "igAmt25": igAmt25, "igUnit25": igUnit25};
 
 bool showIg26 = false;
 static String igUnit26;
 static String igAmt26;
 static String igName26;
 Map ing26 = {"igName26": igName26, "igAmt26": igAmt26, "igUnit26": igUnit26};
 
 bool showIg27 = false;
 static String igUnit27;
 static String igAmt27;
 static String igName27;
 Map ing27 = {"igName27": igName27, "igAmt27": igAmt27, "igUnit27": igUnit27};
 
 bool showIg28 = false;
 static String igUnit28;
 static String igAmt28;
 static String igName28;
 Map ing28 = {"igName28": igName28, "igAmt28": igAmt28, "igUnit28": igUnit28};
 
 bool showIg29 = false;
 static String igUnit29;
 static String igAmt29;
 static String igName29;
 Map ing29 = {"igName29": igName29, "igAmt29": igAmt29, "igUnit29": igUnit29};
 
 bool showIg30 = false;
 static String igUnit30;
 static String igAmt30;
 static String igName30;
 Map ing30 = {"igName30": igName30, "igAmt30": igAmt30, "igUnit30": igUnit30};

 bool showIg31 = false;

  Widget makeIg1(screenWidth) {
    Widget ig1 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
          child: Padding(
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
              ing1 = {'igName1': igName1, "igAmt1": igAmt1, "igUnit1": igUnit1};
              showIg2 = true;
            });
          },
          child: Icon(
            ing1['igName1'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig1;
  }

  Widget makeIg2(screenWidth) {
    Widget ig2 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit2 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt2 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName2 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing2 = {"igName2": igName2, "igAmt2": igAmt2, "igUnit2": igUnit2};
              showIg3 = true;
            });
          },
          child: Icon(
            ing2['igName2'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig2;
  }

  Widget makeIg3(screenWidth) {
    Widget ig3 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit3 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt3 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName3 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing3 = {"igName3": igName3, "igAmt3": igAmt3, "igUnit3": igUnit3};
              showIg4 = true;
            });
          },
          child: Icon(
            ing3 == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig3;
  }

  Widget makeIg4(screenWidth) {
    Widget ig4 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit4 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt4 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName4 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing4 = {"igName4": igName4, "igAmt4": igAmt4, "igUnit4": igUnit4};
              showIg5 = true;
            });
          },
          child: Icon(
            ing4['igName4'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig4;
  }

  Widget makeIg5(screenWidth) {
    Widget ig5 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit5 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt5 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName5 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing5 = {"igName5": igName5, "igAmt5": igAmt5, "igUnit5": igUnit5};
              showIg6 = true;
            });
          },
          child: Icon(
            ing5['igName5'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig5;
  }

  Widget makeIg6(screenWidth) {
    Widget ig6 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit6 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt6 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName6 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing6 = {"igName6": igName6, "igAmt6": igAmt6, "igUnit6": igUnit6};
              showIg7 = true;
            });
          },
          child: Icon(
            ing6['igName6'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig6;
  }

  Widget makeIg7(screenWidth) {
    Widget ig7 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit7 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt7 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName7 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing7 = {"igName7": igName7, "igAmt7": igAmt7, "igUnit7": igUnit7};
              showIg8 = true;
            });
          },
          child: Icon(
            ing7['igName7'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig7;
  }

  Widget makeIg8(screenWidth) {
    Widget ig8 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit8 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt8 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName8 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing8 = {"igName8": igName8, "igAmt8": igAmt8, "igUnit8": igUnit8};
              showIg9 = true;
            });
          },
          child: Icon(
            ing8['igName8'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig8;
  }

  Widget makeIg9(screenWidth) {
    Widget ig9 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit9 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt9 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName9 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing9 = {"igName9": igName9, "igAmt9": igAmt9, "igUnit9": igUnit9};
              showIg10 = true;
            });
          },
          child: Icon(
            ing9['igName9'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig9;
  }

  Widget makeIg10(screenWidth) {
    Widget ig10 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit10 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt10 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName10 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing10 = {
                "igName10": igName10,
                "igAmt10": igAmt10,
                "igUnit10": igUnit10
              };
              showIg11 = true;
            });
          },
          child: Icon(
            ing10['igName10'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig10;
  }

  Widget makeIg11(screenWidth) {
    Widget ig11 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit11 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt11 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName11 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing11 = {
                "igName11": igName11,
                "igAmt11": igAmt11,
                "igUnit11": igUnit11
              };
              showIg12 = true;
            });
          },
          child: Icon(
            ing11['igName11'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig11;
  }

  Widget makeIg12(screenWidth) {
    Widget ig12 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit12 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt12 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName12 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing12 = {
                "igName12": igName12,
                "igAmt12": igAmt12,
                "igUnit12": igUnit12
              };
              showIg13 = true;
            });
          },
          child: Icon(
            ing12['igName12'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig12;
  }

  Widget makeIg13(screenWidth) {
    Widget ig13 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit13 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt13 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName13 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing13 = {
                "igName13": igName13,
                "igAmt13": igAmt13,
                "igUnit13": igUnit13
              };
              showIg14 = true;
            });
          },
          child: Icon(
            ing13['igName13'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig13;
  }

  Widget makeIg14(screenWidth) {
    Widget ig14 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit14 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt14 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName14 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing14 = {
                "igName14": igName14,
                "igAmt14": igAmt14,
                "igUnit14": igUnit14
              };
              showIg15 = true;
            });
          },
          child: Icon(
            ing14['igName14'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig14;
  }

  Widget makeIg15(screenWidth) {
    Widget ig15 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit15 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt15 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName15 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing15 = {
                "igName15": igName15,
                "igAmt15": igAmt15,
                "igUnit15": igUnit15
              };
              showIg16 = true;
            });
          },
          child: Icon(
            ing15['igName15'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig15;
  }

  Widget makeIg16(screenWidth) {
    Widget ig16 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit16 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt16 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName16 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing16 = {
                "igName16": igName16,
                "igAmt16": igAmt16,
                "igUnit16": igUnit16
              };
              showIg17 = true;
            });
          },
          child: Icon(
            ing16['igName16'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig16;
  }

  Widget makeIg17(screenWidth) {
    Widget ig17 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit17 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt17 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName17 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing17 = {
                "igName17": igName17,
                "igAmt17": igAmt17,
                "igUnit17": igUnit17
              };
              showIg18 = true;
            });
          },
          child: Icon(
            ing17['igName17'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig17;
  }

  Widget makeIg18(screenWidth) {
    Widget ig18 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit18 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt18 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName18 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing18 = {
                "igName18": igName18,
                "igAmt18": igAmt18,
                "igUnit18": igUnit18
              };
              showIg19 = true;
            });
          },
          child: Icon(
            ing18['igName18'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig18;
  }

  Widget makeIg19(screenWidth) {
    Widget ig19 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit19 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt19 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName19 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing19 = {
                "igName19": igName19,
                "igAmt19": igAmt19,
                "igUnit19": igUnit19
              };
              showIg20 = true;
            });
          },
          child: Icon(
            ing19['igName19'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig19;
  }

  Widget makeIg20(screenWidth) {
    Widget ig20 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit20 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt20 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName20 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing20 = {
                "igName20": igName20,
                "igAmt20": igAmt20,
                "igUnit20": igUnit20
              };
              showIg21 = true;
            });
          },
          child: Icon(
            ing20['igName20'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig20;
  }

  Widget makeIg21(screenWidth) {
    Widget ig21 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit21 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt21 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName21 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing21 = {
                "igName21": igName21,
                "igAmt21": igAmt21,
                "igUnit21": igUnit21
              };
              showIg22 = true;
            });
          },
          child: Icon(
            ing21['igName21'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig21;
  }

  Widget makeIg22(screenWidth) {
    Widget ig22 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit22 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt22 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName22 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing22 = {
                "igName22": igName22,
                "igAmt22": igAmt22,
                "igUnit22": igUnit22
              };
              showIg23 = true;
            });
          },
          child: Icon(
            ing22['igName22'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig22;
  }

  Widget makeIg23(screenWidth) {
    Widget ig23 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit23 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt23 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName23 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing23 = {
                "igName23": igName23,
                "igAmt23": igAmt23,
                "igUnit23": igUnit23
              };
              showIg24 = true;
            });
          },
          child: Icon(
            ing23['igName23'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig23;
  }

  Widget makeIg24(screenWidth) {
    Widget ig24 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit24 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt24 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName24 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing24 = {
                "igName24": igName24,
                "igAmt24": igAmt24,
                "igUnit24": igUnit24
              };
              showIg25 = true;
            });
          },
          child: Icon(
            ing24['igName24'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig24;
  }

  Widget makeIg25(screenWidth) {
    Widget ig25 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit25 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt25 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName25 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing25 = {
                "igName25": igName25,
                "igAmt25": igAmt25,
                "igUnit25": igUnit25
              };
              showIg26 = true;
            });
          },
          child: Icon(
            ing25['igName25'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig25;
  }

  Widget makeIg26(screenWidth) {
    Widget ig26 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit26 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt26 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName26 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing26 = {
                "igName26": igName26,
                "igAmt26": igAmt26,
                "igUnit26": igUnit26
              };
              showIg27 = true;
            });
          },
          child: Icon(
            ing26['igName26'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig26;
  }

  Widget makeIg27(screenWidth) {
    Widget ig27 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit27 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt27 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName27 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing27 = {
                "igName27": igName27,
                "igAmt27": igAmt27,
                "igUnit27": igUnit27
              };
              showIg28 = true;
            });
          },
          child: Icon(
            ing27['igName27'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig27;
  }

  Widget makeIg28(screenWidth) {
    Widget ig28 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit28 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt28 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName28 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing28 = {
                "igName28": igName28,
                "igAmt28": igAmt28,
                "igUnit28": igUnit28
              };
              showIg29 = true;
            });
          },
          child: Icon(
            ing28['igName28'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig28;
  }

  Widget makeIg29(screenWidth) {
    Widget ig29 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit29 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt29 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName29 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing29 = {
                "igName29": igName29,
                "igAmt29": igAmt29,
                "igUnit29": igUnit29
              };
              showIg30 = true;
            });
          },
          child: Icon(
            ing29['igName29'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig29;
  }

  Widget makeIg30(screenWidth) {
    Widget ig30 = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                  igUnit30 = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: screenWidth * 0.1,
          child: Padding(
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
                    igAmt30 = value;
                  });
                },
              ),
            ),
          ),
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
                  igName30 = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              ing30 = {
                "igName30": igName30,
                "igAmt30": igAmt30,
                "igUnit30": igUnit30
              };
              showIg31 = true;
            });
          },
          child: Icon(
            ing30['igName30'] == null
                ? CupertinoIcons.add_circled
                : CupertinoIcons.add_circled_solid,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig30;
  }

  final RecipeMethods _recipeMethods = RecipeMethods();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    sendRecipe() {
      Recipe _recipe = Recipe(
        recipeId: Utils.randomString(),
        userId: userProvider.getUser.uid,
        recipeName: recipeName,
        recipeDiet: recipeDiet,
        recipePortion: recipePortion,
        recipeIngridients: recipeIngridients,
        recipeInstructions: recipeInstructions,
        recipePreparationTime: recipePreparationTime,
        recipeCookingTime: recipeCookingTime,
        recipeRestTime: recipeRestTime,
        recipeDifficulty: recipeDifficulty,
        recipeType: recipeType,
        recipeCuisine: recipeCuisine,
        recipeCalories: recipeCalories,
        recipePicture: recipePicture,
        recipeYums: recipeYums,
        recipeCreatorPic: userProvider.getUser.profilePhoto,
        recipeCreatorName: userProvider.getUser.name,
      );

      _recipeMethods.addRecipeToDb(_recipe);
    }

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
                              //  'accept_terms': false,
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
                                //RecipeDiet
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_DIET,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: screenWidth * 0.40,
                                        child: FormBuilderDropdown(
                                          attribute: "diet",
                                          decoration:
                                              InputDecoration(labelText: ""),
                                          items: [
                                            'Vegan',
                                            'Vegatarian',
                                            'Non-Vegatarian',
                                            'Low-Carb/Keto',
                                            'Lactose-free',
                                            'Gluten-free',
                                            'Healthy',
                                            'Low Calorie'
                                          ]
                                              .map((diet) => DropdownMenuItem(
                                                  value: diet,
                                                  child: Text("$diet")))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              recipeDiet = value;
                                            });
                                          },
                                        ),
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
                                          Visibility(
                                            visible: showIg2,
                                            child: makeIg2(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg3,
                                            child: makeIg3(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg4,
                                            child: makeIg4(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg5,
                                            child: makeIg5(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg6,
                                            child: makeIg6(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg7,
                                            child: makeIg7(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg8,
                                            child: makeIg8(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg9,
                                            child: makeIg9(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg10,
                                            child: makeIg10(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg11,
                                            child: makeIg11(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg12,
                                            child: makeIg12(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg13,
                                            child: makeIg13(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg14,
                                            child: makeIg14(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg15,
                                            child: makeIg15(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg16,
                                            child: makeIg16(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg17,
                                            child: makeIg17(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg18,
                                            child: makeIg18(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg19,
                                            child: makeIg19(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg20,
                                            child: makeIg20(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg21,
                                            child: makeIg21(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg22,
                                            child: makeIg22(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg23,
                                            child: makeIg23(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg24,
                                            child: makeIg24(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg25,
                                            child: makeIg25(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg26,
                                            child: makeIg26(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg27,
                                            child: makeIg27(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg28,
                                            child: makeIg28(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg29,
                                            child: makeIg29(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg30,
                                            child: makeIg30(screenWidth),
                                          ),
                                          Visibility(
                                            visible: showIg31,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Text("MAX LIMIT REACHED",
                                                    style: TextStyles.error),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                //Instructions
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_INSTRUCTIONS,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: screenWidth * 0.60,
                                        child: FormBuilderTextField(
                                          attribute: "instructions",
                                          decoration: InputDecoration(
                                              labelText: "",
                                              helperStyle: TextStyles.recipe),
                                          keyboardType: TextInputType.multiline,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          // validators: [
                                          //   // FormBuilderValidators.
                                          //   FormBuilderValidators.max(25),
                                          // ],
                                          onChanged: (value) {
                                            setState(() {
                                              recipeInstructions = value;
                                            });
                                          },
                                        ),
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
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.characters,

                                          // validators: [
                                          //   // FormBuilderValidators.
                                          //   FormBuilderValidators.max(4),
                                          // ],
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
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          // validators: [
                                          //   // FormBuilderValidators.
                                          //   FormBuilderValidators.max(25),
                                          // ],
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
                                          keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          // validators: [
                                          //   // FormBuilderValidators.
                                          //   FormBuilderValidators.max(25),
                                          // ],
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

                                //RecipeType
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_TYPE,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: screenWidth * 0.40,
                                        child: FormBuilderDropdown(
                                          attribute: "type",
                                          decoration:
                                              InputDecoration(labelText: ""),
                                          items: [
                                            'Breakfast',
                                            'Lunch',
                                            'Dinner',
                                            'Snack',
                                            'Main course',
                                            'Dessert',
                                            'Baking',
                                            'Drink',
                                          ]
                                              .map((type) => DropdownMenuItem(
                                                  value: type,
                                                  child: Text("$type")))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              recipeType = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //RecipeCuisine
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(Strings.RECIPE_CUISINE,
                                            style: TextStyles.recipe),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: screenWidth * 0.40,
                                        child: FormBuilderDropdown(
                                          attribute: "type",
                                          decoration:
                                              InputDecoration(labelText: ""),
                                          items: [
                                            'Indian',
                                            'Turkish',
                                            'Mediterranean',
                                            'Spanish',
                                            'Asian',
                                            'French',
                                            'American',
                                            'African',
                                            'Mexican',
                                            'Scandinavian',
                                            'Middle Eastern',
                                            'Eastern European',
                                            'Other',
                                          ]
                                              .map((cuisine) =>
                                                  DropdownMenuItem(
                                                      value: cuisine,
                                                      child: Text("$cuisine")))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              recipeCuisine = value;
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
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       _fbKey.currentState.reset();
                                //     },
                                //     child: Container(
                                //       height: 40,
                                //       decoration: BoxDecoration(
                                //         color: uniColors.lcRed,
                                //         borderRadius: BorderRadius.only(
                                //           topLeft: Radius.circular(25.0),
                                //           topRight: Radius.circular(25.0),
                                //           bottomLeft: Radius.circular(25.0),
                                //           bottomRight: Radius.circular(25.0),
                                //         ),
                                //       ),
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: <Widget>[
                                //             Row(
                                //               children: <Widget>[
                                //                 Padding(
                                //                   padding: const EdgeInsets
                                //                           .symmetric(
                                //                       horizontal: 8.0),
                                //                   child: Text("RESET",
                                //                       style: TextStyles
                                //                           .submitBubble),
                                //                 ),
                                //                 Icon(
                                //                   Icons.close,
                                //                   color: uniColors.white2,
                                //                 ),
                                //               ],
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_fbKey.currentState
                                          .saveAndValidate()) {
                                        ing1 != null
                                            ? recipeIngridients.insert(0, ing1)
                                            : {};
                                        ing2 != null
                                            ? recipeIngridients.insert(1, ing2)
                                            : {};
                                        ing3 != null
                                            ? recipeIngridients.insert(2, ing3)
                                            : {};
                                        ing4 != null
                                            ? recipeIngridients.insert(3, ing4)
                                            : {};
                                        ing5 != null
                                            ? recipeIngridients.insert(4, ing5)
                                            : {};
                                        ing6 != null
                                            ? recipeIngridients.insert(5, ing6)
                                            : {};
                                        ing7 != null
                                            ? recipeIngridients.insert(6, ing7)
                                            : {};
                                        ing8 != null
                                            ? recipeIngridients.insert(7, ing8)
                                            : {};
                                        ing9 != null
                                            ? recipeIngridients.insert(8, ing9)
                                            : {};
                                        ing10 != null
                                            ? recipeIngridients.insert(9, ing10)
                                            : {};
                                        ing11 != null
                                            ? recipeIngridients.insert(
                                                10, ing11)
                                            : {};
                                        ing12 != null
                                            ? recipeIngridients.insert(
                                                11, ing12)
                                            : {};
                                        ing13 != null
                                            ? recipeIngridients.insert(
                                                12, ing13)
                                            : {};
                                        ing14 != null
                                            ? recipeIngridients.insert(
                                                13, ing14)
                                            : {};
                                        ing15 != null
                                            ? recipeIngridients.insert(
                                                14, ing15)
                                            : {};
                                        ing16 != null
                                            ? recipeIngridients.insert(
                                                15, ing16)
                                            : {};
                                        ing17 != null
                                            ? recipeIngridients.insert(
                                                16, ing17)
                                            : {};
                                        ing18 != null
                                            ? recipeIngridients.insert(
                                                17, ing18)
                                            : {};
                                        ing19 != null
                                            ? recipeIngridients.insert(
                                                18, ing19)
                                            : {};
                                        ing20 != null
                                            ? recipeIngridients.insert(
                                                19, ing20)
                                            : {};
                                        ing21 != null
                                            ? recipeIngridients.insert(
                                                20, ing21)
                                            : {};
                                        ing22 != null
                                            ? recipeIngridients.insert(
                                                21, ing22)
                                            : {};
                                        ing23 != null
                                            ? recipeIngridients.insert(
                                                22, ing23)
                                            : {};
                                        ing24 != null
                                            ? recipeIngridients.insert(
                                                23, ing24)
                                            : {};
                                        ing25 != null
                                            ? recipeIngridients.insert(
                                                24, ing25)
                                            : {};
                                        ing26 != null
                                            ? recipeIngridients.insert(
                                                25, ing26)
                                            : {};
                                        ing27 != null
                                            ? recipeIngridients.insert(
                                                26, ing27)
                                            : {};
                                        ing28 != null
                                            ? recipeIngridients.insert(
                                                27, ing28)
                                            : {};
                                        ing29 != null
                                            ? recipeIngridients.insert(
                                                28, ing29)
                                            : {};
                                        ing30 != null
                                            ? recipeIngridients.insert(
                                                29, ing30)
                                            : {};

                                        print(_fbKey.currentState.value);
                                        sendRecipe();
                                        _fbKey.currentState.reset();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: uniColors.online,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0),
                                          bottomLeft: Radius.circular(25.0),
                                          bottomRight: Radius.circular(25.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text("SUBMIT",
                                                      style: TextStyles
                                                          .submitBubble),
                                                ),
                                                Icon(
                                                  Icons.send,
                                                  color: uniColors.white2,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
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
