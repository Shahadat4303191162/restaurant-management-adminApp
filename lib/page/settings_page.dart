import 'package:cafe_admin/widgets/settings_drawer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsDrawer(),
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
