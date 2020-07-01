import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/models/recipe.dart';
import 'package:lcl/models/user.dart';

    //sender = buyer
    //receiver = seller

class RecipeMethods {
  static final Firestore _firestore = Firestore.instance;
   static final Firestore firestore = Firestore.instance;

  final CollectionReference _recipeCollection = _firestore.collection(RECIPE_COLLECTION);


    Future<void> addRecipeToDb(Recipe recipe) async {
    var map = recipe.toMap();
    _firestore.collection(RECIPE_COLLECTION).document(recipe.recipeId).setData(map);
  }


}
