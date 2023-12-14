import 'dart:io';
import 'dart:typed_data';

import 'package:cafe_admin/db/dbhelper.dart';
import 'package:cafe_admin/models/add_user_model.dart';
import 'package:cafe_admin/models/purchase_model.dart';
import 'package:cafe_admin/models/divers_selection_model.dart';
import 'package:cafe_admin/models/table_number_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier{

  List<ProductModel> productList = []; //collection
  List<CategoryModel> categoryList = [];
  List<TableModel> tableList = [];
  List<DiverseSelectionModel> priceVariationList = [];


  //category section start
  getAllCategories(){
    DbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length, (index) =>
      CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllTableValue(){
    DbHelper.getAllTableValue().listen((snapshot) {
      tableList = List.generate(snapshot.docs.length, (index) =>
      TableModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<String> updateCatImage(Uint8List uint8list) async{
    final imageName = 'Image_${DateTime.now().microsecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref().child('CategoryPictures/$imageName');
    final task = photoRef.putData(uint8list);
    final snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  Future<void> addCategory(CategoryModel categoryModel) {
    return DbHelper.addCategory(categoryModel);
  }

  //category section end


  Future<void> addTable(TableModel tableModel) {
    return DbHelper.addTable(tableModel);
  }

  Future<void> addUser(UserModel userModel) {
    return DbHelper.addUser(userModel);
  }

  CategoryModel getCategoryByName (String name){
    final model = categoryList.firstWhere((element) => element.name == name);
    return model;
  }
  
  Future<void> addProduct(
      ProductModel productModel,
      PurchaseModel purchaseModel,
      DiverseSelectionModel diverseSelectionModel,
      CategoryModel categoryModel,){
    final count = categoryModel.productCount + purchaseModel.quantity;
    return DbHelper.addProduct(
        productModel,
        purchaseModel,
        diverseSelectionModel,
        categoryModel.id!, count);
  }
  Future<void> addMultiPriceSection(DiverseSelectionModel diverseSelectionModel,String id){
    return DbHelper.addMultiPriceSection(diverseSelectionModel, id);
  }

  Future<String?> updateProductImage(Uint8List uint8list) async{
    final imageName = 'productImage_${DateTime.now().microsecondsSinceEpoch}';
    final photoRaf = FirebaseStorage.instance.ref().child('ProductPicture/$imageName');
    final uploadTask = photoRaf.putData(uint8list);
    // final task = photoRaf.putFile(File(xFile.path));
    // final snapshot = await task.whenComplete(() => null);
    // final snapshot = await uploadTask.whenComplete(() => null);
    // return snapshot.ref.getDownloadURL();
    try {
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null; // Handle the error as needed in your UI
    }
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

  Future<void> updateVariationPriceField(String productId,String priceVariationId,String field, dynamic value){
    return DbHelper.updateVariationPrice(productId, priceVariationId, {field : value});
  }

 }
