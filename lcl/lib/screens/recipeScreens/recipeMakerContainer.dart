import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lcl/provider/image_upload_provider.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:lcl/utils/utilities.dart';

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
  List recipeCategory;
  int recipePortion;

  //List ingridients;

  static List ingridients = new List()..length = 1;

  Map ing1;
  String igUnit1;
  String igAmt1;
  String igName1;

  Map ing2;
  bool showIg2 = false;
  String igUnit2;
  String igAmt2;
  String igName2;

  Map ing3;
  bool showIg3 = false;
  String igUnit3;
  String igAmt3;
  String igName3;

  Map ing4;
  bool showIg4 = false;
  String igUnit4;
  String igAmt4;
  String igName4;

  Map ing5;
  bool showIg5 = false;
  String igUnit5;
  String igAmt5;
  String igName5;

  Map ing6;
  bool showIg6 = false;
  String igUnit6;
  String igAmt6;
  String igName6;

  Map ing7;
  bool showIg7 = false;
  String igUnit7;
  String igAmt7;
  String igName7;

  Map ing8;
  bool showIg8 = false;
  String igUnit8;
  String igAmt8;
  String igName8;

  Map ing9;
  bool showIg9 = false;
  String igUnit9;
  String igAmt9;
  String igName9;

  Map ing10;
  bool showIg10 = false;
  String igUnit10;
  String igAmt10;
  String igName10;

  Map ing11;
  bool showIg11 = false;
  String igUnit11;
  String igAmt11;
  String igName11;

  Map ing12;
  bool showIg12 = false;
  String igUnit12;
  String igAmt12;
  String igName12;

  Map ing13;
  bool showIg13 = false;
  String igUnit13;
  String igAmt13;
  String igName13;

  Map ing14;
  bool showIg14 = false;
  String igUnit14;
  String igAmt14;
  String igName14;

  Map ing15;
  bool showIg15 = false;
  String igUnit15;
  String igAmt15;
  String igName15;

  Map ing16;
  bool showIg16 = false;
  String igUnit16;
  String igAmt16;
  String igName16;

  Map ing17;
  bool showIg17 = false;
  String igUnit17;
  String igAmt17;
  String igName17;

  Map ing18;
  bool showIg18 = false;
  String igUnit18;
  String igAmt18;
  String igName18;

  Map ing19;
  bool showIg19 = false;
  String igUnit19;
  String igAmt19;
  String igName19;

  Map ing20;
  bool showIg20 = false;
  String igUnit20;
  String igAmt20;
  String igName20;

  Map ing21;
  bool showIg21 = false;
  String igUnit21;
  String igAmt21;
  String igName21;

  Map ing22;
  bool showIg22 = false;
  String igUnit22;
  String igAmt22;
  String igName22;

  Map ing23;
  bool showIg23 = false;
  String igUnit23;
  String igAmt23;
  String igName23;

  Map ing24;
  bool showIg24 = false;
  String igUnit24;
  String igAmt24;
  String igName24;

  Map ing25;
  bool showIg25 = false;
  String igUnit25;
  String igAmt25;
  String igName25;

  Map ing26;
  bool showIg26 = false;
  String igUnit26;
  String igAmt26;
  String igName26;

  Map ing27;
  bool showIg27 = false;
  String igUnit27;
  String igAmt27;
  String igName27;

  Map ing28;
  bool showIg28 = false;
  String igUnit28;
  String igAmt28;
  String igName28;

  Map ing29;
  bool showIg29 = false;
  String igUnit29;
  String igAmt29;
  String igName29;

  Map ing30;
  bool showIg30 = false;
  String igUnit30;
  String igAmt30;
  String igName30;

  bool showIg31 = false;

  int recipePreparationTime;
  int recipeCookingTime;
  int recipeRestTime;
  String recipeDifficulty;
  String recipeType;
  String recipeCuisine;
  double recipeCalories;

  String recipeInstructions;

  //   void pickRecipePhoto({@required ImageSource source}) async {
  //   File selectedImage = await Utils.pickImage(source: source);

  //   _repository.getCurrentUser().then((user) {
  //     _repository.changeProfilePhoto(
  //         image: selectedImage,
  //         imageUploadProvider: _imageUploadProvider,
  //         currentUser: user);
  //   });
  // }

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
              ing1 = {"igName1": igName1, "igAmt1": igAmt1, "igUnit1": igUnit1};
              showIg2 = true;
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
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
            Icons.done,
            color: uniColors.lcRed,
          ),
        ),
      ],
    );

    return ig30;
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

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _fbKey.currentState.reset();
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: uniColors.lcRed,
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
                                                  child: Text("RESET",
                                                      style: TextStyles
                                                          .submitBubble),
                                                ),
                                                Icon(
                                                  Icons.close,
                                                  color: uniColors.white2,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_fbKey.currentState
                                          .saveAndValidate()) {
                                        ing1 != null
                                            ? ingridients.insert(0, ing1)
                                            : {};
                                        ing2 != null
                                            ? ingridients.insert(1, ing2)
                                            : {};
                                        ing3 != null
                                            ? ingridients.insert(2, ing3)
                                            : {};
                                        ing4 != null
                                            ? ingridients.insert(3, ing4)
                                            : {};
                                        ing5 != null
                                            ? ingridients.insert(4, ing5)
                                            : {};
                                        ing6 != null
                                            ? ingridients.insert(5, ing6)
                                            : {};
                                        ing7 != null
                                            ? ingridients.insert(6, ing7)
                                            : {};
                                        ing8 != null
                                            ? ingridients.insert(7, ing8)
                                            : {};
                                        ing9 != null
                                            ? ingridients.insert(8, ing9)
                                            : {};
                                        ing10 != null
                                            ? ingridients.insert(9, ing10)
                                            : {};
                                        ing11 != null
                                            ? ingridients.insert(10, ing11)
                                            : {};
                                        ing12 != null
                                            ? ingridients.insert(11, ing12)
                                            : {};
                                        ing13 != null
                                            ? ingridients.insert(12, ing13)
                                            : {};
                                        ing14 != null
                                            ? ingridients.insert(13, ing14)
                                            : {};
                                        ing15 != null
                                            ? ingridients.insert(14, ing15)
                                            : {};
                                        ing16 != null
                                            ? ingridients.insert(15, ing16)
                                            : {};
                                        ing17 != null
                                            ? ingridients.insert(16, ing17)
                                            : {};
                                        ing18 != null
                                            ? ingridients.insert(17, ing18)
                                            : {};
                                        ing19 != null
                                            ? ingridients.insert(18, ing19)
                                            : {};
                                        ing20 != null
                                            ? ingridients.insert(19, ing20)
                                            : {};
                                        ing21 != null
                                            ? ingridients.insert(20, ing21)
                                            : {};
                                        ing22 != null
                                            ? ingridients.insert(21, ing22)
                                            : {};
                                        ing23 != null
                                            ? ingridients.insert(22, ing23)
                                            : {};
                                        ing24 != null
                                            ? ingridients.insert(23, ing24)
                                            : {};
                                        ing25 != null
                                            ? ingridients.insert(24, ing25)
                                            : {};
                                        ing26 != null
                                            ? ingridients.insert(25, ing26)
                                            : {};
                                        ing27 != null
                                            ? ingridients.insert(26, ing27)
                                            : {};
                                        ing28 != null
                                            ? ingridients.insert(27, ing28)
                                            : {};
                                        ing29 != null
                                            ? ingridients.insert(28, ing29)
                                            : {};
                                        ing30 != null
                                            ? ingridients.insert(29, ing30)
                                            : {};

                                        print(_fbKey
                                            .currentState.value.runtimeType);
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
