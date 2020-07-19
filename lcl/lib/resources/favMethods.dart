import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/models/favs.dart';


class FavMethods {
  static final Firestore _firestore = Firestore.instance;
  static final Firestore firestore = Firestore.instance;

  final CollectionReference _favCollection =_firestore.collection(FAV_COLLECTION);

  Future<void> addFavsToDb(Favs favs) async {
    var map = favs.toMap(favs);
    _firestore
        .collection(FAV_COLLECTION)
        .document(favs.favId)
        .setData(map);
  }

  Future<void> updateFavsToDb(Favs favs) async {
    var map = favs.toMap(favs);
    _firestore
        .collection(FAV_COLLECTION)
        .document(favs.favId)
        .updateData(map);
  }


}
