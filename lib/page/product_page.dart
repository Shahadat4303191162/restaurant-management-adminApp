import 'package:cafe_admin/page/new_product_page.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  static const String routeName = '/product';
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => 
        provider.productList.isEmpty 
            ? const Center(
          child: Text('NO Item found',style: TextStyle(fontSize: 18),),
        ): ListView.builder(
          itemBuilder: (BuildContext context, int index) { 
            
          },)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewProductPage.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
