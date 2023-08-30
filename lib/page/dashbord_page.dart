import 'package:cafe_admin/models/dashboard_item_model.dart';
import 'package:cafe_admin/notification_services.dart';
import 'package:cafe_admin/page/category_page.dart';
import 'package:cafe_admin/page/order_list_page.dart';
import 'package:cafe_admin/page/product_page.dart';
import 'package:cafe_admin/page/report_page.dart';
import 'package:cafe_admin/page/sales_page.dart';
import 'package:cafe_admin/page/settings_page.dart';
import 'package:cafe_admin/widgets/dashboard_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    //NotificationServices notificationServices = NotificationServices();
    // notificationServices.firebaseInit(context);
    // notificationServices.requestNotificationPermission();
    //
    // //notificationServices.isTokenRefresh();
    // notificationServices.getDeviceToken().then((value) {
    //   print('Device token');
    //   print(value);
    // });
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth >800 ? 3 : 2;
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dash board'),
      ),
      body:
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20,
            horizontal: screenWidth > 1000
                ? screenWidth * 0.3
                : screenWidth > 600 ? screenWidth*0.1 : 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4),
          itemCount: dashboardItem.length,
          itemBuilder: (context, index) => DashboardItemView(
              item: dashboardItem[index],
              onPressed: (value) {
                final route = navigate(value);
                Navigator.pushNamed(context, route);
              }),
        ),
      ),
    );
  }

  navigate(String value) {
   String route = '';
   switch(value){
     case DashboardItem.product : route = ProductPage.routeName;
     break;
     case DashboardItem.category : route = CategoryPage.routeName;
     break;
     case DashboardItem.order : route = OrderPage.routeName;
     break;
     case DashboardItem.sales : route = SalesPage.routeName;
     break;
     case DashboardItem.setting : route = SettingsPage.routeName;
     break;
     case DashboardItem.report : route = ReportPage.routeName;
     break;
   }
   return route;
  }
}
