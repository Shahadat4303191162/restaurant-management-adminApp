import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_admin/page/new_product_page.dart';
import 'package:cafe_admin/page/product_details_page.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

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
          builder: (context, provider, _) => provider.productList.isEmpty
              ? const Center(
                  child: Text(
                    'NO Item found',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) {
                    final product = provider.productList[index];
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () => Navigator.pushNamed(
                            context, ProductDetailsPage.routeName,
                            arguments: product.id),
                        leading: CachedNetworkImage(
                          width: 100,
                          imageUrl: product.thumbnailImageUrl!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(product.name!),
                        subtitle: Text('stock : ${product.stock}'),
                        trailing: Text(
                          '$currencysymbol ${product.salesPrice}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    );
                  },
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewProductPage.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
