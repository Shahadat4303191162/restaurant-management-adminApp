import 'package:cafe_admin/models/add_user_model.dart';
import 'package:cafe_admin/models/category_model.dart';
import 'package:cafe_admin/models/divers_selection_model.dart';
import 'package:cafe_admin/models/order_constants_model.dart';
import 'package:cafe_admin/models/product_model.dart';
import 'package:cafe_admin/models/purchase_model.dart';
import 'package:cafe_admin/models/table_number_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper{
  static const String collectionAdmin = 'Admins';
  static const String collectionCategory = 'Categories';
  static const String collectionProduct = 'Products';
  static const String collectionPurchase = 'Purchases';
  static const String collectionSettings = 'Settings';
  static const String collectionTable = 'Table';
  static const String collectionUsers = 'Users';
  static const String documentOrderConstant = 'orderConstant';
  static const String collectionDiversSelection = 'Size Variation';
  static const String collectionCart = 'Cart';
  static const String collectionOrder = 'Order';
  static const String collectionOrderRequest = 'OrderRequest';
  static const String collectionOrderDetails = 'OrderDetails';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async{
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel categoryModel){
    final doc = _db.collection(collectionCategory).doc();
    categoryModel.id = doc.id;
    return doc.set(categoryModel.toMap());
  }

  static Future<void> addTable(TableModel tableModel){
    final doc = _db.collection(collectionTable).doc();
    tableModel.id = doc.id;
    return doc.set(tableModel.toMap());
  }

  static Future<void> addUser(UserModel userModel){
    final doc = _db.collection(collectionUsers).doc();
    userModel.id = doc.id;
    return doc.set(userModel.toMap());
  }

  static Future<void> addProduct(
      ProductModel productModel,
      PurchaseModel purchaseModel,
      DiverseSelectionModel diverseSelectionModel,
      String catId, num count ){
    final wb = _db.batch();
    final proDoc = _db.collection(collectionProduct).doc();
    final purDoc = _db.collection(collectionPurchase).doc();
    final catDoc = _db.collection(collectionCategory).doc(catId);
    final diversDoc = proDoc.collection(collectionDiversSelection).doc();
    productModel.id = proDoc.id;
    purchaseModel.id = purDoc.id;
    purchaseModel.productId = proDoc.id;
    diverseSelectionModel.id = diversDoc.id;
    diverseSelectionModel.productId = proDoc.id;
    wb.set(proDoc, productModel.toMap());
    wb.set(purDoc, purchaseModel.toMap());
    wb.set(diversDoc, diverseSelectionModel.toMap());
    wb.update(catDoc, {'productCount' : count});
    return wb.commit();
  }

  static Future<void> addMultiPriceSection(DiverseSelectionModel diverseSelectionModel,String id){
    final multiPriceDoc = _db.collection(collectionProduct).doc(id).collection(collectionDiversSelection).doc();
    diverseSelectionModel.id = multiPriceDoc.id;
    diverseSelectionModel.productId = id;
    return multiPriceDoc.set(diverseSelectionModel.toMap());
  }

  static Future<void> addOrderConstants(OrderConstantsModel orderConstantsModel){
    return _db.collection(collectionSettings)
        .doc(documentOrderConstant).set(orderConstantsModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllCategories()=>
      _db.collection(collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllTableValue()=>
    _db.collection(collectionTable).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllProducts()=>
      _db.collection(collectionProduct).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllOrder()=>
      _db.collection(collectionOrder).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllOrderRequest(String uid)=>
      _db.collection(collectionUsers)
          .doc(uid)
          .collection(collectionOrderRequest)
          .snapshots();

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getOrderConstants()=>
      _db.collection(collectionSettings).doc(documentOrderConstant).snapshots();

  static Future<DocumentSnapshot<Map<String,dynamic>>> getOrderConstants2()=>
      _db.collection(collectionSettings).doc(documentOrderConstant).get();

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getProductById(String id)=>
      _db.collection(collectionProduct).doc(id).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getProductByPriceVariation(String id)=>
      _db.collection(collectionProduct).doc(id).collection(collectionDiversSelection).snapshots();

  static Future<void> updateProduct(String id, Map<String,dynamic>map){
    return _db.collection(collectionProduct).doc(id).update(map);
  }

  static Future<void> updateVariationPrice(String id,String variationPriceId , Map<String,dynamic>map){
    return _db.collection(collectionProduct).doc(id).collection(collectionDiversSelection).doc(variationPriceId).update(map);
  }
}