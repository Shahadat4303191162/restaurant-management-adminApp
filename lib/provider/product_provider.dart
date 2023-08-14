import 'dart:io';

import 'package:cafe_admin/db/dbhelper.dart';
import 'package:cafe_admin/models/purchase_model.dart';
import 'package:cafe_admin/models/divers_selection_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier{

  List<ProductModel> productList = []; //collection
  List<CategoryModel> categoryList = [];
  List<DiverseSelectionModel> priceVariationList = [];


  //category section start
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

  //category section end

  CategoryModel getCategoryByName (String name){
    final model = categoryList.firstWhere((element) => element.name == name);
    return model;
  }
  
  Future<void> addProduct(
      ProductModel productModel,
      PurchaseModel purchaseModel,
      CategoryModel categoryModel,
      DiverseSelectionModel diverseSelectionModel){
    final count = categoryModel.productCount + purchaseModel.quantity;
    return DbHelper.addProduct(
        productModel,
        purchaseModel,
        diverseSelectionModel ,
        categoryModel.id!, count);
  }

  Future<String> updateProductImage(XFile xFile) async{
    final imageName = 'productImage_${DateTime.now().microsecondsSinceEpoch}';
    final photoRaf = FirebaseStorage.instance.ref().child('ProductPicture/$imageName');
    final task = photoRaf.putFile(File(xFile.path));
    final snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
  
  getAllProducts(){
    DbHelper.getAllProducts().listen((snapshot) {
      productList = List.generate(snapshot.docs.length, (index) =>
          ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getProductByPriceVariation(String id){
    DbHelper.getProductByPriceVariation(id).listen((snapshot) {
      priceVariationList = List.generate(snapshot.docs.length, (index) =>
          DiverseSelectionModel.fromMap(snapshot.docs[index].data())
      );
      notifyListeners();
    });
  }

  Stream<DocumentSnapshot<Map<String,dynamic>>> getProductById(String id) =>
  DbHelper.getProductById(id);

  Future<void> updateProductField(String productId,String field, dynamic value){
    return DbHelper.updateProduct(productId, {field : value});
  }

 }