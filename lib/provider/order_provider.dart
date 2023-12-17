import 'package:cafe_admin/db/dbhelper.dart';
import 'package:cafe_admin/models/cart_moder.dart';
import 'package:cafe_admin/models/order_constants_model.dart';
import 'package:cafe_admin/models/order_payment_model.dart';
import 'package:cafe_admin/models/order_request_model.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderRequestModel> orderRequestList = [];
  List<OrderPaymentModel> orderPaymentList = [];
  String uid = 'i7eDs9YfBPgJff33lbEJOzNGaUm2';
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

  getOrderConstants() {
    DbHelper.getOrderConstants().listen((event) {
      if (event.exists) {
        orderConstantsModel = OrderConstantsModel.fromMap(event.data()!);
      }
    });
  }

  getAllOrders() {
    DbHelper.getAllOrder().listen((snapshot) {
      orderPaymentList = List.generate(snapshot.docs.length, (index) =>
          OrderPaymentModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllOrderRequest() {
    DbHelper.getAllOrderRequest(uid).listen((snapshot) {
      orderRequestList = [OrderRequestModel.fromMap(snapshot.docs[0].data())];
      notifyListeners();
    });
  }

  Future<void> getOrderConstants2() async {
    final snapshot = await DbHelper.getOrderConstants2();
    orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
    notifyListeners();
  }

  List<OrderPaymentModel> getFilteredListBySingleDay(DateTime dateTime) {
    return orderPaymentList.where((orderM) =>
    orderM.paymentDate.timestamp
        .toDate()
        .day == dateTime.day &&
        orderM.paymentDate.timestamp
            .toDate()
            .month == dateTime.month &&
        orderM.paymentDate.timestamp
            .toDate()
            .year == dateTime.year
    ).toList();
  }

  List<OrderPaymentModel> getFilteredListByWeek(DateTime dateTime) {
    return orderPaymentList.where((orderM) =>
        orderM.paymentDate.timestamp.toDate().isAfter(dateTime)
    ).toList();
  }

  List<OrderPaymentModel> getFilteredListByMonth(DateTime dt) {
    return orderPaymentList.where((orderM) =>
    orderM.paymentDate.timestamp
        .toDate()
        .month == dt.month &&
        orderM.paymentDate.timestamp
            .toDate()
            .year == dt.year
    ).toList();
  }

  List<OrderPaymentModel> getFilteredListByYear(DateTime dt) {
    return orderPaymentList.where((orderM) =>
    orderM.paymentDate.timestamp
        .toDate()
        .year == dt.year
    ).toList();
  }

  num getTotalSaleBySingleDate(DateTime dt) {
    num total = 0;
    final list = getFilteredListBySingleDay(dt);
    for (var order in list) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalSaleByWeek(DateTime dt) {
    num total = 0;
    final list = getFilteredListByWeek(dt);
    for (var order in list) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalSaleByMonth(DateTime dt) {
    num total = 0;
    final list = getFilteredListByMonth(dt);
    for (var order in list) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalSaleByYear(DateTime dt) {
    num total = 0;
    final list = getFilteredListByYear(dt);
    for (var order in list) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalSale() {
    num total = 0;
    for (var order in orderPaymentList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  Future<void> addOrderConstants(OrderConstantsModel orderConstantsModel) =>
      DbHelper.addOrderConstants(orderConstantsModel);

  List<OrderPaymentModel> getFilteredList(OrderFilter filter) {
    var list = <OrderPaymentModel>[];
    switch (filter) {
      case OrderFilter.TODAY:
        list = getFilteredListBySingleDay(DateTime.now());
        break;

      case OrderFilter.YESTERDAY:
        list = getFilteredListBySingleDay(
            DateTime.now().subtract(const Duration(days: 1)));
        break;

      case OrderFilter.SEVER_DAYS:
        list = getFilteredListByWeek(
            DateTime.now().subtract(const Duration(days: 7)));
        break;

      case OrderFilter.THIS_MONTH:
        list = getFilteredListByMonth(DateTime.now());
        break;
      case OrderFilter.THREE_MONTH:
        list = getFilteredListByWeek(
            DateTime.now().subtract(const Duration(days: 90)));
        break;
      case OrderFilter.THIS_YEAR:
        list = getFilteredListByYear(DateTime.now());
        break;
      case OrderFilter.ALL_TIME:
        list = orderPaymentList;
        break;
    }
    return list;
  }

  List<OrderPaymentModel> getFilteredListForDashbord() =>
      orderPaymentList;
}