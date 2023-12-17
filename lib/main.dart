
import 'package:cafe_admin/notification_services.dart';
import 'package:cafe_admin/page/Vat_discount_page.dart';
import 'package:cafe_admin/page/category_page.dart';
import 'package:cafe_admin/page/coustomizable_product.dart';
import 'package:cafe_admin/page/dashbord_page.dart';
import 'package:cafe_admin/page/launcher_page.dart';
import 'package:cafe_admin/page/order_details_page.dart';
import 'package:cafe_admin/page/order_page.dart';
import 'package:cafe_admin/page/table_number_page.dart';
import 'package:cafe_admin/src/features/login/presentation/page/login_page.dart';
import 'package:cafe_admin/page/new_product_page.dart';
import 'package:cafe_admin/page/order_list_page.dart';
import 'package:cafe_admin/page/product_details_page.dart';
import 'package:cafe_admin/page/product_page.dart';
import 'package:cafe_admin/page/Order_Request_page.dart';
import 'package:cafe_admin/page/settings_page.dart';
import 'package:cafe_admin/provider/order_provider.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:cafe_admin/utils/controller.dart';
import 'package:cafe_admin/widgets/dashbord_component/dashboard_content.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC2Tc-qt6o8AaFHfVvmCOhzcbtCL9XMAyY",
          projectId: "restsurant-management",
          storageBucket: "restsurant-management.appspot.com",
          messagingSenderId: "468236031580",
          appId: "1:468236031580:web:bfd3e60664a6e402adf899",
          measurementId: "G-8Y1VZV2GDF"
          )
  );
  runApp(MultiProvider(providers:[
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
    ChangeNotifierProvider(create: (create) => Controller()),
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => LauncherPage(),
        LoginPage.routeName: (_) => LoginPage(),
        DashboardPage.routeName:(_) => DashboardPage(),
        DashboardContent.routeName:(_) => DashboardContent(),
        ProductPage.routeName: (_) => ProductPage(),
        ProductDetailsPage.routeName: (_) => const ProductDetailsPage(),
        CategoryPage.routeName: (_) => CategoryPage(),
        SettingsPage.routeName: (_) => SettingsPage(),
        OrderListPage.routeName: (_) => OrderListPage(),
        OrderDetailsPage.routeName: (_) => OrderDetailsPage(),
        OrderPage.routeName:(_) => OrderPage(),
        OrderRequestPage.routeName: (_) => OrderRequestPage(),
        NewProductPage.routeName: (_) => NewProductPage(),
        Vat_DiscountPage.routeName: (_) => Vat_DiscountPage(),
        TableNumberPage.routeName: (_) => TableNumberPage(),
        CustomizeProduct.routeName: (_) => CustomizeProduct(),
      },
    );
  }
}


// New create directory [src]
