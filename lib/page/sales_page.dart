import 'package:flutter/material.dart';

class SalesPage extends StatelessWidget {
  static const String routeName = '/salesPage';
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
    );
  }
}
