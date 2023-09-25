import 'package:cafe_admin/auth/auth_services.dart';
import 'package:cafe_admin/page/dashbord_page.dart';
import 'package:cafe_admin/src/features/login/presentation/page/login_page.dart';
import 'package:flutter/material.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      if(AuthService.user != null){
        print(' next page show');
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      }else{
        print('user null paici');
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
