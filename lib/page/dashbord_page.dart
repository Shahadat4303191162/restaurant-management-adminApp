import 'package:cafe_admin/models/drawer_list_tile_model.dart';
import 'package:cafe_admin/notification_services.dart';
import 'package:cafe_admin/page/category_page.dart';
import 'package:cafe_admin/page/order_list_page.dart';
import 'package:cafe_admin/page/product_page.dart';
import 'package:cafe_admin/page/report_page.dart';
import 'package:cafe_admin/page/Order_Request_page.dart';
import 'package:cafe_admin/page/settings_page.dart';
import 'package:cafe_admin/page/table_number_page.dart';
import 'package:cafe_admin/provider/order_provider.dart';
import 'package:cafe_admin/utils/constants.dart';
import 'package:cafe_admin/utils/controller.dart';
import 'package:cafe_admin/widgets/dashbord_component/dashboard_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/dashbord_component/dashbord_content/drawer_list_tile_view.dart';
import '../widgets/dashbord_component/dashbord_content/header.dart';
import '../provider/product_provider.dart';
import '../widgets/responsive.dart';
import 'Vat_discount_page.dart';
import 'new_product_page.dart';
import 'order_page.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedValue = DrawerListTileModel.dashBoard;


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
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final int crossAxisCount = screenWidth > 800 ? 3 : 2;
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context,listen: false).getAllTableValue();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<OrderProvider>(context,listen: false).getAllOrders();
    Provider.of<OrderProvider>(context,listen: false).getAllOrderRequest();
    return Scaffold(

      backgroundColor: bgColor,
      drawer: Drawer(
        child: ListView.builder(
          itemCount: drawerItem.length,
          itemBuilder: (context, index) =>
              DrawerListTileView(
                  item: drawerItem[index],
                  onPressed: (value) {
                    final route = navigate(value);
                    Navigator.pushNamed(context, route);
                  }
              ),),
      ),
      key: context
          .read<Controller>()
          .scaffoldKey,
      body: SafeArea(
        child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!Responsive.isDesktop(context))
                  IconButton(
                    onPressed: context.read<Controller>().controlMenu,
                    icon: Icon(
                      Icons.menu,
                      color: textColor.withOpacity(0.5),
                    ),
                  ),
                if (Responsive.isDesktop(context))
                  Expanded(
                    child:
                    Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: ListView.builder(
                        itemCount: drawerItem.length,
                        itemBuilder: (context, index) => DrawerListTileView(
                            item: drawerItem[index],
                            onPressed: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            }),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 5,
                  child:Column(
                    children: [
                      Header(),
                      Expanded(
                      child: Container(
                        color: secondaryColor,
                        child: getContentBasedOnValue(selectedValue),
                      ),
                    )
                  ],
                  )
                )
              ],
            ),

      ),
    );
  }

  Widget getContentBasedOnValue(String value) {
    switch (value) {
      case DrawerListTileModel.dashBoard:
        return DashboardContent(); // Replace with your DashboardPage widget
      case DrawerListTileModel.order:
        return OrderRequestPage(); // Replace with your OrderPage widget
      case DrawerListTileModel.product_list:
        return ProductPage(); // Replace with your ProductPage widget
      case DrawerListTileModel.category:
        return CategoryPage();
      case DrawerListTileModel.addMenu:
        return NewProductPage();// Replace with your CategoryPage widget
      case DrawerListTileModel.sales:
        return OrderPage(); // Replace with your SalesPage widget
      case DrawerListTileModel.setting:
        return SettingsPage();
      case DrawerListTileModel.vatDiscount:
        return Vat_DiscountPage();// Replace with your SettingsPage widget
      case DrawerListTileModel.tableNumber:
        return TableNumberPage();
      case DrawerListTileModel.report:
        return ReportPage(); // Replace with your ReportPage widget
      default:
        return Center(child: Text('Unknown page'));
    }
  }


  navigate(String value) {
    String route = '';
    switch (value) {
      case DrawerListTileModel.dashBoard :
        route = DashboardPage.routeName;
        break;
      case DrawerListTileModel.order :
        route = OrderRequestPage.routeName;
        break;
      case DrawerListTileModel.product_list :
        route = ProductPage.routeName;
        break;
      case DrawerListTileModel.category :
        route = CategoryPage.routeName;
        break;
      case DrawerListTileModel.addMenu :
        route = NewProductPage.routeName;
        break;
      case DrawerListTileModel.sales :
        route = OrderPage.routeName;
        break;
      case DrawerListTileModel.setting :
        route = SettingsPage.routeName;
        break;
      case DrawerListTileModel.report :
        route = ReportPage.routeName;
        break;
    }
    return route;
  }
}



