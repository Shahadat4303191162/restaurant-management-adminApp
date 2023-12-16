import 'package:cafe_admin/db/dbhelper.dart';
import 'package:cafe_admin/models/order_constants_model.dart';
import 'package:cafe_admin/models/order_payment_model.dart';
import 'package:cafe_admin/models/order_request_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier{
  List<OrderRequestModel> orderRequestList = [];
  List<OrderPaymentModel> orderPaymentList = [];
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

  getOrderConstants(){
    DbHelper.getOrderConstants().listen((event) {
      if(event.exists){
        orderConstantsModel = OrderConstantsModel.fromMap(event.data()!);
      }
    });
  }

  getAllOrders(){
    DbHelper.getAllOrder().listen((snapshot) {
      orderPaymentList = List.generate(snapshot.docs.length, (index) =>
          OrderPaymentModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllOrderRequest(){

  }

  Future<void> getOrderConstants2() async{
    final snapshot = await DbHelper.getOrderConstants2();
    orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
    notifyListeners();
  }


  Future<void> addOrderConstants(OrderConstantsModel orderConstantsModel) =>
    DbHelper.addOrderConstants(orderConstantsModel);

}