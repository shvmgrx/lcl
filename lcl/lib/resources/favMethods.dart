import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/models/favs.dart';

class FavMethods {
  static final Firestore _firestore = Firestore.instance;
  static final Firestore firestore = Firestore.instance;

  final CollectionReference _favCollection =
      _firestore.collection(FAV_COLLECTION);

  Future<void> addFavsToDb(Favs favs) async {
    var map = favs.toMap(favs);
    _firestore.collection(FAV_COLLECTION).document(favs.favId).setData(map);
  }

  Future<void> updateFavsToDb(Favs favs) async {
    var map = favs.toMap(favs);
    _firestore.collection(FAV_COLLECTION).document(favs.favId).updateData(map);
  }

  Future<DocumentSnapshot> getFavRecipesFromDb(String userId) async {
    DocumentSnapshot documentSnapshot =
        await _favCollection.document(userId).get();

    print(documentSnapshot.data['favRecipes']);

    return documentSnapshot;
  }

    Future<List> getFavRecipesListFromDb(String userId) async {
    List<String> recipeNameList = List<String>();

    DocumentSnapshot documentSnapshot =
        await _favCollection.document(userId).get();

    for (var i = 0; i < documentSnapshot.data['favRecipes'].length; i++) {
      recipeNameList.add(documentSnapshot.data['favRecipes'][i]);
    }

    return recipeNameList;
  }

}
