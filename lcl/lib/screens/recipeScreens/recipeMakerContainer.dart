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

                                        // FormBuilderTextField(
                                        //   attribute: "recipeName",
                                        //   //    decoration:InputDecoration(labelText: "Recipe Name",helperStyle: TextStyles.recipe),
                                        //   keyboardType: TextInputType.text,
                                        //   validators: [
                                        //     // FormBuilderValidators.
                                        //     FormBuilderValidators.max(25),
                                        //   ],
                                        //   onChanged: (value) {
                                        //     setState(() {
                                        //       recipeName = value;
                                        //     });
                                        //   },
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 100),
                                FormBuilderDateTimePicker(
                                  attribute: "date",
                                  inputType: InputType.date,
                                  format: DateFormat("yyyy-MM-dd"),
                                  decoration: InputDecoration(
                                      labelText: "Appointment Time"),
                                ),
                                FormBuilderSlider(
                                  attribute: "slider",
                                  validators: [FormBuilderValidators.min(6)],
                                  min: 0.0,
                                  max: 10.0,
                                  initialValue: 1.0,
                                  divisions: 20,
                                  decoration: InputDecoration(
                                      labelText: "Number of things"),
                                ),
                                FormBuilderCheckbox(
                                  attribute: 'accept_terms',
                                  label: Text(
                                      "I have read and agree to the terms and conditions"),
                                  validators: [
                                    FormBuilderValidators.requiredTrue(
                                      errorText:
                                          "You must accept terms and conditions to continue",
                                    ),
                                  ],
                                ),
                                FormBuilderDropdown(
                                  attribute: "gender",
                                  decoration:
                                      InputDecoration(labelText: "Gender"),
                                  // initialValue: 'Male',
                                  hint: Text('Select Gender'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: ['Male', 'Female', 'Other']
                                      .map((gender) => DropdownMenuItem(
                                          value: gender,
                                          child: Text("$gender")))
                                      .toList(),
                                ),
                                FormBuilderTextField(
                                  attribute: "age",
                                  decoration: InputDecoration(labelText: "Age"),
                                  validators: [
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.max(70),
                                  ],
                                ),
                                FormBuilderSegmentedControl(
                                  decoration: InputDecoration(
                                      labelText: "Movie Rating (Archer)"),
                                  attribute: "movie_rating",
                                  options: List.generate(5, (i) => i + 1)
                                      .map((number) =>
                                          FormBuilderFieldOption(value: number))
                                      .toList(),
                                ),
                                FormBuilderSwitch(
                                  label:
                                      Text('I Accept the tems and conditions'),
                                  attribute: "accept_terms_switch",
                                  initialValue: true,
                                ),
                                FormBuilderTouchSpin(
                                  decoration:
                                      InputDecoration(labelText: "Stepper"),
                                  attribute: "stepper",
                                  initialValue: 10,
                                  step: 1,
                                ),
                                FormBuilderRate(
                                  decoration: InputDecoration(
                                      labelText: "Rate this form"),
                                  attribute: "rate",
                                  iconSize: 32.0,
                                  initialValue: 1.0,
                                  max: 5,
                                ),
                                FormBuilderCheckboxList(
                                  decoration: InputDecoration(
                                      labelText: "The language of my people"),
                                  attribute: "languages",
                                  initialValue: ["Dart"],
                                  options: [
                                    FormBuilderFieldOption(value: "Dart"),
                                    FormBuilderFieldOption(value: "Kotlin"),
                                    FormBuilderFieldOption(value: "Java"),
                                    FormBuilderFieldOption(value: "Swift"),
                                    FormBuilderFieldOption(
                                        value: "Objective-C"),
                                  ],
                                ),
                                FormBuilderChoiceChip(
                                  attribute: "favorite_ice_cream",
                                  options: [
                                    FormBuilderFieldOption(
                                        child: Text("Vanilla"),
                                        value: "vanilla"),
                                    FormBuilderFieldOption(
                                        child: Text("Chocolate"),
                                        value: "chocolate"),
                                    FormBuilderFieldOption(
                                        child: Text("Strawberry"),
                                        value: "strawberry"),
                                    FormBuilderFieldOption(
                                        child: Text("Peach"), value: "peach"),
                                  ],
                                ),
                                FormBuilderFilterChip(
                                  attribute: "pets",
                                  options: [
                                    FormBuilderFieldOption(
                                        child: Text("Cats"), value: "cats"),
                                    FormBuilderFieldOption(
                                        child: Text("Dogs"), value: "dogs"),
                                    FormBuilderFieldOption(
                                        child: Text("Rodents"),
                                        value: "rodents"),
                                    FormBuilderFieldOption(
                                        child: Text("Birds"), value: "birds"),
                                  ],
                                ),
                                FormBuilderSignaturePad(
                                  decoration:
                                      InputDecoration(labelText: "Signature"),
                                  attribute: "signature",
                                  height: 100,
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
                                    print(_fbKey.currentState.value);
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
