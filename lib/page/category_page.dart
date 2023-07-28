import 'package:cafe_admin/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
    );
  }
}
