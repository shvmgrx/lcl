class Favs {
  String favId;
  List favRecipes;
  List favPeople;

  Favs({
    this.favId,
    this.favRecipes,
    this.favPeople,

  });

  // to map
  Map<String, dynamic> toMap(Favs favs) {
    Map<String, dynamic> favsMap = Map();
    favsMap["favId"] = favs.favId;
    favsMap["favRecipes"] = favs.favRecipes;
    favsMap["favPeople"] = favs.favPeople;
    return favsMap;
  }

  Favs.fromMap(Map favsMap) {
    this.favId = favsMap["favId"];
    this.favRecipes = favsMap["favRecipes"];
    this.favPeople = favsMap["favPeople"];
  }
}