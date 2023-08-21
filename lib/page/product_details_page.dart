import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_admin/models/product_model.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../models/divers_selection_model.dart';
import '../utils/constants.dart';
import '../utils/helper_function.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/details_page';

  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final from_key = GlobalKey<FormState>();
    final editingController = TextEditingController();
    final priceEditingController = TextEditingController();
    final sizeController = TextEditingController();
    final purchasePriceController = TextEditingController();
    final salePriceController = TextEditingController();
    final pid = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<ProductProvider>(context, listen: false);
    Provider.of<ProductProvider>(context,listen: false).getProductByPriceVariation(pid);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: provider.getProductById(pid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = ProductModel.fromMap(snapshot.data!.data()!);
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 0,
                  horizontal: screenWidth > 1000 ? screenWidth * 0.3
                      : screenWidth > 600 ? screenWidth * 0.1 : 20),
              children: [
                CachedNetworkImage(
                  width: 75,
                  imageUrl: product.thumbnailImageUrl!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {}, child: const Text('Re-Purchase')),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Purchase History'),
                    ),
                  ],
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      product.name!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Edit Product Name'),
                                content: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: editingController,
                                  decoration: InputDecoration(
                                    hintText: product.name,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      provider.updateProductField(pid,
                                          productName, editingController.text);
                                      Navigator.of(context).pop();
                                      editingController.clear();
                                    },
                                    child: const Text('Save'),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    title: const Text('Sales Price',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      '$currencysymbol ${product.salesPrice}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Edit Sales Price'),
                                content: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: editingController,
                                  decoration: InputDecoration(
                                    hintText: '$currencysymbol ${product.salesPrice}',
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      provider.updateProductField(
                                          pid,
                                          productShortDescription,
                                         num.parse(editingController.text));
                                      Navigator.of(context).pop();
                                      editingController.clear();
                                    },
                                    child: const Text('Save'),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ),
                ExpansionTile(title: const Text('Price Variations'), children: [
                  Column(
                    children: [
          //             ListView.builder(
          // shrinkWrap: true,
          // itemCount: provider.priceVariationList.length,
          // itemBuilder: (context, index) {
          // final priceList = provider.priceVariationList[index];
          // return Column(
          // children: [
          // ListTile(
          // title: Text('Size : ${priceList.size}'),
          // subtitle: Text(
          // 'Sale Price : $currencysymbol ${priceList.salePrice}',
          // style: const TextStyle(color: Colors.green),
          // ),
          // trailing: IconButton(
          // icon: const Icon(Icons.edit),
          // onPressed: () {
          // showDialog(
          // context: context,
          // builder: (BuildContext context) {
          // return AlertDialog(
          // title:
          // const Text('Edit Sales Price'),
          // content: Column(
          // mainAxisSize: MainAxisSize.min,
          // children: [
          // TextField(
          // keyboardType:
          // TextInputType.text,
          // controller: editingController,
          // decoration: InputDecoration(
          // hintText: priceList.size == null? 'Size' : priceList.size,
          // //hintText: priceList.size,
          // ),
          // ),
          // TextField(
          // keyboardType:
          // TextInputType.number,
          // controller:
          // priceEditingController,
          // decoration: InputDecoration(
          // hintText:
          // '$currencysymbol ${priceList.salePrice}',
          //
          // ),
          // )
          // ],
          // ),
          // actions: [
          // ElevatedButton(
          // onPressed: () {
          // Navigator.of(context).pop();
          // },
          // child: const Text('Cancel'),
          // ),
          // ElevatedButton(
          // onPressed: () {
          // provider.updateVariationPriceField(
          // pid,
          // priceList.id as String,
          // diverseSelectionSize,
          // editingController.text);
          // provider.updateVariationPriceField(
          // pid,
          // priceList.id as String,
          // diverseSelectionSalePrice,
          // num.parse(
          // priceEditingController
          //     .text));
          // provider.notifyListeners();
          // Navigator.of(context).pop();
          // editingController.clear();
          // priceEditingController
          //     .clear();
          // },
          // child: const Text('Save'),
          // )
          // ],
          // );
          // });
          // },
          // ),
          // ),
          // ],
          // );
          // },
          // ),
                      Consumer<ProductProvider>(
                        builder: (context, provider,_) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.priceVariationList.length,
                            itemBuilder: (context, index) {
                              final priceList = provider.priceVariationList[index];
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text('Size : ${priceList.size}'),
                                    subtitle: Text(
                                      'Sale Price : $currencysymbol ${priceList.salePrice}',
                                      style: const TextStyle(color: Colors.green),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Edit Sales Price'),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller: editingController,
                                                      decoration: InputDecoration(
                                                        hintText: priceList.size == null? 'Size' : priceList.size,
                                                        //hintText: priceList.size,
                                                      ),
                                                    ),
                                                    TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          priceEditingController,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                            '$currencysymbol ${priceList.salePrice}',

                                                      ),
                                                    )
                                                  ],
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      provider.updateVariationPriceField(
                                                          pid,
                                                          priceList.id as String,
                                                          diverseSelectionSize,
                                                          editingController.text);
                                                      provider.updateVariationPriceField(
                                                          pid,
                                                          priceList.id as String,
                                                          diverseSelectionSalePrice,
                                                          num.parse(
                                                              priceEditingController
                                                                  .text));
                                                      provider.notifyListeners();
                                                      Navigator.of(context).pop();
                                                      editingController.clear();
                                                      priceEditingController
                                                          .clear();
                                                    },
                                                    child: const Text('Save'),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Set Price & Size'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Form(
                                          key: from_key,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: sizeController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: 'Size (optional)',
                                                  prefixIcon: Icon(
                                                    Icons.next_week_outlined,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller:
                                                    purchasePriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Purchase Price',
                                                  prefixIcon: Icon(
                                                    Icons
                                                        .monetization_on_outlined,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'This field must not be empty';
                                                  }
                                                  if (num.parse(value) <= 0) {
                                                    return 'Purchase Price should be greater than 0';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: salePriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Sale Price',
                                                  prefixIcon: Icon(
                                                    Icons.monetization_on,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'This field must not be empty';
                                                  }
                                                  if (num.parse(value) <= 0) {
                                                    return 'Sale Price should be greater than 0';
                                                  }
                                                  return null;
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('cancel')),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (from_key.currentState!
                                              .validate()) {
                                            final diverseSelectionModel =
                                                DiverseSelectionModel(
                                                    size: sizeController
                                                            .text.isEmpty
                                                        ? null
                                                        : sizeController.text,
                                                    salePrice: num.parse(
                                                        salePriceController
                                                            .text),
                                                    purPrice: num.parse(
                                                        purchasePriceController
                                                            .text));
                                            context
                                                .read<ProductProvider>()
                                                .addMultiPriceSection(
                                                    diverseSelectionModel, pid)
                                                .then((value) {
                                              sizeController.clear();
                                              salePriceController.clear();
                                              purchasePriceController.clear();
                                              Navigator.of(context).pop();
                                            });
                                          }
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text('ADD MORE')),
                    ],
                  ),
                ]),
                Card(
                  elevation: 5,
                  child: ListTile(
                    title: const Text(
                      'Short Description',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(product.shortDescription ?? 'Not Available'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Edit Short Description'),
                                content: TextField(
                                  maxLines: 2,
                                  keyboardType: TextInputType.text,
                                  controller: editingController,
                                  decoration: InputDecoration(
                                    hintText: product.shortDescription,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      provider.updateProductField(
                                          pid,
                                          productShortDescription,
                                          editingController.text);
                                      Navigator.of(context).pop();
                                      editingController.clear();
                                    },
                                    child: const Text('Save'),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    title: const Text(
                      'Long Description',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(product.longDescription ?? 'Not Available'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Edit Long Description'),
                                content: TextField(
                                  maxLines: 3,
                                  keyboardType: TextInputType.text,
                                  controller: editingController,
                                  decoration: InputDecoration(
                                    hintText: product.longDescription,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      provider.updateProductField(
                                          pid,
                                          productLongDescription,
                                          editingController.text);
                                      Navigator.of(context).pop();
                                      editingController.clear();
                                    },
                                    child: const Text('Save'),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    title: const Text(
                      'Discount',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${product.productDiscount}%'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Edit Discount'),
                                content: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: editingController,
                                  decoration: InputDecoration(
                                    hintText: '${product.productDiscount}%',
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      provider.updateProductField(
                                          pid,
                                          productPriceDiscount,
                                          num.parse(editingController.text));
                                      Navigator.of(context).pop();
                                      editingController.clear();
                                    },
                                    child: const Text('Save'),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ),
                SwitchListTile(
                    title: const Text('Available'),
                    value: product.available,
                    onChanged: (value) {
                      provider.updateProductField(pid, productAvailable, value);
                    }),
                SwitchListTile(
                    title: const Text('Featured'),
                    value: product.featured,
                    onChanged: (value) {
                      provider.updateProductField(pid, productFeatured, value);
                    }),
              ],
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to get data'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
