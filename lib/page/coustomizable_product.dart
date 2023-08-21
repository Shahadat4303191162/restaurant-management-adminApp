import 'package:cafe_admin/widgets/settings_drawer.dart';
import 'package:flutter/material.dart';

class CustomizeProduct extends StatelessWidget {
  static const String routeName='/customizeProduct';
  const CustomizeProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsDrawer(),
      appBar: AppBar(
        title: Text('Coustomiz'),
      ),
    );
  }
}
