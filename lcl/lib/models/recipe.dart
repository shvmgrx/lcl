class Recipe {
  String recipeId;
  String userId;
  String name;
  double portion;
  List categories;
  Map ingridients;
  List instructions;
  double prepTime;
  double cookTime;
  bool needsRestTime;
  double restTime;
  List level;
  List diet;
  List cuisine;
  bool calorieKnown;
  String foodPic;
  int yum;


  Recipe({
    this.recipeId,
    this.userId,
    this.name,
    this.portion,
    this.categories,
    this.ingridients,
    this.instructions,
    this.prepTime,
    this.cookTime,
    this.needsRestTime,
    this.restTime,
    this.level,
    this.diet,
    this.cuisine,
    this.calorieKnown,
    this.foodPic,
    this.yum

  });

  // to map
  Map<String, dynamic> toMap(Recipe recipe) {
    Map<String, dynamic> recipeMap = Map();
    recipeMap["recipeId"] = recipe.recipeId;
    recipeMap["userId"] = recipe.userId;
    recipeMap["name"] = recipe.name;
    recipeMap["portion"] = recipe.portion;
    recipeMap["categories"] = recipe.categories;
    recipeMap["ingridients"] = recipe.ingridients;
    recipeMap["instructions"] = recipe.instructions;
    recipeMap["prepTime"] = recipe.prepTime;
    recipeMap["cookTime"] = recipe.cookTime;
    recipeMap["needsRestTime"] = recipe.needsRestTime;
    recipeMap["restTime"] = recipe.restTime;
    recipeMap["level"] = recipe.level;
    recipeMap["diet"] = recipe.diet;
    recipeMap["cuisine"] = recipe.cuisine;
    recipeMap["calorieKnown"] = recipe.calorieKnown;
    recipeMap["foodPic"] = recipe.foodPic;
    recipeMap["yum"] = recipe.yum;
    return recipeMap;
  }

  Recipe.fromMap(Map recipeMap) {
    this.name = recipeMap["name"];
    this.portion = recipeMap["portion"];
    this.categories = recipeMap["categories"];
    this.ingridients = recipeMap["ingridients"];
    this.instructions = recipeMap["instructions"];
    this.prepTime = recipeMap["prepTime"];
    this.cookTime = recipeMap["cookTime"];
    this.needsRestTime = recipeMap["needsRestTime"];
    this.restTime = recipeMap["restTime"];
    this.level = recipeMap["level"];
    this.calorieKnown = recipeMap["calorieKnown"];
    this.foodPic = recipeMap["foodPic"];
    this.yum = recipeMap["yum"];
  }
}