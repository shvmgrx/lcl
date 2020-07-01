class Recipe {
  String recipeId;
  String userId;
  String recipeName;
  String recipeDiet;
  int recipePortion;
  List recipeIngridients;
  String recipeInstructions;
  String recipePreparationTime;
  String recipeCookingTime;
  String recipeRestTime;
  String recipeDifficulty;
  String recipeType;
  String recipeCuisine;
  String recipeCalories;
  String recipePicture;
  int recipeYums;
  String recipeCreatorPic;
  String recipeCreatorName;

  Recipe({
    this.recipeId,
      this.userId,
      this.recipeName,
      this.recipeDiet,
      this.recipePortion,
      this.recipeIngridients,
      this.recipeInstructions,
      this.recipePreparationTime,
      this.recipeCookingTime,
      this.recipeRestTime,
      this.recipeDifficulty,
      this.recipeType,
      this.recipeCuisine,
      this.recipeCalories,
      this.recipePicture,
      this.recipeYums,
      this.recipeCreatorPic,
      this.recipeCreatorName

      });

  Map toMap() {
    
    var recipeMap = Map<String, dynamic>();


    recipeMap["recipeId"] = this.recipeId;
    recipeMap["userId"] = this.userId;
    recipeMap["recipeName"] = this.recipeName;
    recipeMap["recipeDiet"] = this.recipeDiet;
    recipeMap["recipePortion"] = this.recipePortion;
    recipeMap["recipeIngridients"] = this.recipeIngridients;
    recipeMap["recipeInstructions"] = this.recipeInstructions;
    recipeMap["recipePreparationTime"] = this.recipePreparationTime;
    recipeMap["recipeCookingTime"] = this.recipeCookingTime;
    recipeMap["recipeRestTime"] = this.recipeRestTime;
    recipeMap["recipeDifficulty"] = this.recipeDifficulty;
    recipeMap["recipeType"] = this.recipeType;
    recipeMap["recipeCuisine"] = this.recipeCuisine;
    recipeMap["recipeCalories"] = this.recipeCalories;
    recipeMap["recipePicture"] = this.recipePicture;
    recipeMap["recipeYums"] = this.recipeYums;
    recipeMap["recipeCreatorPic"] = this.recipeCreatorPic;
    recipeMap["recipeCreatorName"] = this.recipeCreatorName;
    return recipeMap;
  }

   Recipe.fromMap(Map<String, dynamic> mapData) {

    this.recipeId = mapData["recipeId"];
    this.userId = mapData["userId"];
    this.recipeName = mapData["recipeName"];
    this.recipeDiet = mapData["recipeDiet"];
    this.recipePortion = mapData["recipePortion"];
    this.recipeIngridients = mapData["recipeIngridients"];
    this.recipeInstructions = mapData["recipeInstructions"];
    this.recipePreparationTime = mapData["recipePreparationTime"];
    this.recipeCookingTime = mapData["recipeCookingTime"];
    this.recipeRestTime = mapData["recipeRestTime"];
    this.recipeDifficulty = mapData["recipeDifficulty"];
    this.recipeType = mapData["recipeType"];
    this.recipeCuisine = mapData["recipeCuisine"];
    this.recipeCalories = mapData["recipeCalories"];
    this.recipePicture = mapData["recipePicture"];
    this.recipeYums = mapData["recipeYums"];
    this.recipeCreatorPic = mapData["recipeCreatorPic"];
    this.recipeCreatorName = mapData["recipeCreatorName"];
    
  }
}
