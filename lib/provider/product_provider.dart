import 'dart:io';

import 'package:cafe_admin/db/dbhelper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<String> updateCatImage(XFile file) async{
    final imageName = 'Image_${DateTime.now().microsecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref().child('CategoryPictures/$imageName');
    final task = photoRef.putFile(File(file.path));
    final snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  Future<void> addCategory(CategoryModel categoryModel) {
    return DbHelper.addCategory(categoryModel);
  }
 }