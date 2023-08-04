import 'package:flutter/material.dart';

class DashboardItem{
  IconData icon;
  String title;

  DashboardItem({
    required this.icon,
    required this.title
  });

  static const String product = 'Product';
  static const String category = 'Category';
  static const String order = 'Order';
  static const String sales = 'Sales';
  static const String setting = 'Setting';
  static const String report = 'Report';

 }

 final List<DashboardItem> dashboardItem =[
   DashboardItem(icon: Icons.card_giftcard, title: DashboardItem.product),
   DashboardItem(icon: Icons.category, title: DashboardItem.category),
   DashboardItem(icon: Icons.monetization_on, title: DashboardItem.order),
   DashboardItem(icon: Icons.shopify, title: DashboardItem.sales),
   DashboardItem(icon: Icons.settings, title: DashboardItem.setting),
   DashboardItem(icon: Icons.area_chart, title: DashboardItem.report),
 ];