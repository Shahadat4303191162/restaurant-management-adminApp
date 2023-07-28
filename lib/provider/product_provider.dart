import 'package:cafe_admin/db/dbhelper.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier{

  List<ProductModel> productList = []; //collection
  List<CategoryModel> categoryList = [];

  getAllCategories(){
    DbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length, (index) =>
      CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
 }