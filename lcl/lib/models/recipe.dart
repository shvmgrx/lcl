class Recipe {
  String recipeId;
  String userId;
  String recipeName;
  String recipeDiet;
  int recipePortion;
  List recipeIngridients;
  String recipeInstructions;
  int recipePreparationTime;
  int recipeCookingTime;
  int recipeRestTime;
  String recipeDifficulty;
  String recipeType;
  String recipeCuisine;
  int recipeCalories;
  String recipePicture;
  int recipeYums;

  Recipe(
      {this.recipeId,
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
      this.recipeYums});

  // to map
  Map<String, dynamic> toMap(Recipe recipe) {
    Map<String, dynamic> recipeMap = Map();
    recipeMap["recipeId"] = recipe.recipeId;
    recipeMap["userId"] = recipe.userId;
    recipeMap["recipeName"] = recipe.recipeName;
    recipeMap["recipeDiet"] = recipe.recipeDiet;
    recipeMap["recipePortion"] = recipe.recipePortion;
    recipeMap["recipeIngridients"] = recipe.recipeIngridients;
    recipeMap["recipeInstructions"] = recipe.recipeInstructions;
    recipeMap["recipePreparationTime"] = recipe.recipePreparationTime;
    recipeMap["recipeCookingTime"] = recipe.recipeCookingTime;
    recipeMap["recipeRestTime"] = recipe.recipeRestTime;
    recipeMap["recipeDifficulty"] = recipe.recipeDifficulty;
    recipeMap["recipeType"] = recipe.recipeType;
    recipeMap["recipeCuisine"] = recipe.recipeCuisine;
    recipeMap["recipeCalories"] = recipe.recipeCalories;
    recipeMap["recipePicture"] = recipe.recipePicture;
    recipeMap["recipeYums"] = recipe.recipeYums;
    return recipeMap;
  }

  Recipe.fromMap(Map recipeMap) {
    this.recipeId = recipeMap["recipeId"];
    this.userId = recipeMap["userId"];
    this.recipeName = recipeMap["recipeName"];
    this.recipeDiet = recipeMap["recipeDiet"];
    this.recipePortion = recipeMap["recipePortion"];
    this.recipeIngridients = recipeMap["recipeIngridients"];
    this.recipeInstructions = recipeMap["recipeInstructions"];
    this.recipePreparationTime = recipeMap["recipePreparationTime"];
    this.recipeCookingTime = recipeMap["recipeCookingTime"];
    this.recipeRestTime = recipeMap["recipeRestTime"];
    this.recipeDifficulty = recipeMap["recipeDifficulty"];
    this.recipeType = recipeMap["recipeType"];
    this.recipeCuisine = recipeMap["recipeCuisine"];
    this.recipeCalories = recipeMap["recipeCalories"];
    this.recipePicture = recipeMap["recipePicture"];
    this.recipeYums = recipeMap["recipeYums"];
    
  }
}
