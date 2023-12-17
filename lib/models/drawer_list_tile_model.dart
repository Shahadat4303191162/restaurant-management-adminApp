import 'package:flutter/material.dart';

class DrawerListTileModel{
  IconData icon;
  String title;
  final List<DrawerListTileModel>? subItems;

  DrawerListTileModel({
    required this.icon,
    required this.title,
    this.subItems,
  });

  static const String menu = 'Menu Management';
  static const String product_list = 'Product List';
  static const String addMenu = 'Add Menu';
  static const String notification = 'Notification Center';
  static const String choiceGroup = 'Choice Group';
  static const String dashBoard = 'Dashboard';
  static const String category = 'Category';
  static const String order = 'Order Request';
  static const String sales = 'Sales';
  static const String setting = 'Setting';
  static const String vatDiscount = 'Vat_Discount';
  static const String tableNumber = 'Table_Number';
  static const String report = 'Report';

 }

 final List<DrawerListTileModel> drawerItem =[
   DrawerListTileModel(icon: Icons.dashboard, title: DrawerListTileModel.dashBoard),
   DrawerListTileModel(icon: Icons.monetization_on, title: DrawerListTileModel.order),
   DrawerListTileModel(icon: Icons.menu_book, title: DrawerListTileModel.menu,
     subItems: [
        DrawerListTileModel(
            icon: Icons.public,
            title: DrawerListTileModel.product_list),
       DrawerListTileModel(
           icon: Icons.category,
           title: DrawerListTileModel.category),
       DrawerListTileModel(
           icon: Icons.cable,
           title: DrawerListTileModel.choiceGroup),
       DrawerListTileModel(
           icon: Icons.add,
           title: DrawerListTileModel.addMenu),
     ]
   ),

   DrawerListTileModel(icon: Icons.notifications, title: DrawerListTileModel.notification),
   DrawerListTileModel(icon: Icons.shopify, title: DrawerListTileModel.sales),
   DrawerListTileModel(icon: Icons.settings, title: DrawerListTileModel.setting,
    subItems: [
      DrawerListTileModel(
          icon: Icons.discount,
          title: DrawerListTileModel.vatDiscount),
      DrawerListTileModel(
          icon: Icons.table_bar,
          title: DrawerListTileModel.tableNumber),
    ]
   ),
   DrawerListTileModel(icon: Icons.area_chart, title: DrawerListTileModel.report),
 ];