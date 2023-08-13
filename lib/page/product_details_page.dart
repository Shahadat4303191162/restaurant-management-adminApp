import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_admin/models/product_model.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../utils/helper_function.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/details_page';
  const ProductDetailsPage({super.key});


  @override
  Widget build(BuildContext context) {
    final editingController =TextEditingController();
    final sizeController = TextEditingController();
    final purchasePriceController = TextEditingController();
    final salePriceController = TextEditingController();

    final pid = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<ProductProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
            stream: provider.getProductById(pid),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                final product = ProductModel.fromMap(snapshot.data!.data()!);
                return ListView(
                  children: [
                    CachedNetworkImage(
                      width: 75,
                      imageUrl: product.thumbnailImageUrl!,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: (){

                            },
                            child: const Text('Re-Purchase')),
                        TextButton(
                          onPressed: () {

                          },
                          child: const Text('Purchase History'),
                        ),
                      ],
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(product.name!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
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
                                        child: const Text('Cancel'),),
                                      ElevatedButton(
                                        onPressed: () {
                                          provider.updateProductField(pid, productName, editingController.text);
                                          Navigator.of(context).pop();
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
                    // Card(
                    //   elevation: 5,
                    //   child: ListTile(
                    //     title: const Text('Sales Price',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    //     subtitle: Text(
                    //       '$currencysymbol ${product.salesPrice}',
                    //       style: const TextStyle(color: Colors.green),
                    //     ),
                    //     trailing: IconButton(
                    //       icon: const Icon(Icons.edit),
                    //       onPressed: () {
                    //         showDialog(
                    //             context: context,
                    //             builder: (BuildContext context){
                    //               return AlertDialog(
                    //                 title: const Text('Edit Sales Price'),
                    //                 content: TextField(
                    //                   keyboardType: TextInputType.number,
                    //                   controller: editingController,
                    //                   decoration: InputDecoration(
                    //                     hintText: '$currencysymbol ${product.salesPrice}',
                    //                   ),
                    //                 ),
                    //                 actions: [
                    //                   ElevatedButton(
                    //                     onPressed: () {
                    //                       Navigator.of(context).pop();
                    //                     },
                    //                     child: const Text('Cancel'),),
                    //                   ElevatedButton(
                    //                     onPressed: () {
                    //                       provider.updateProductField(pid, productSalesPrice, num.parse(editingController.text));
                    //                       Navigator.of(context).pop();
                    //                     },
                    //                     child: const Text('Save'),
                    //                   )
                    //                 ],
                    //               );
                    //             });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: const Text('Short Description',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(product.shortDescription ?? 'Not Available'),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
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
                                        child: const Text('Cancel'),),
                                      ElevatedButton(
                                        onPressed: () {
                                          provider.updateProductField(pid, productShortDescription, editingController.text);
                                          Navigator.of(context).pop();
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
                        title: const Text('Long Description',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(product.longDescription ?? 'Not Available'),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
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
                                        child: const Text('Cancel'),),
                                      ElevatedButton(
                                        onPressed: () {
                                          provider.updateProductField(pid, productLongDescription, editingController.text);
                                          Navigator.of(context).pop();
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
                        title: const Text('Discount',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text('${product.productDiscount}%'),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
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
                                        child: const Text('Cancel'),),
                                      ElevatedButton(
                                        onPressed: () {
                                          provider.updateProductField(pid, productPriceDiscount, num.parse(editingController.text));
                                          Navigator.of(context).pop();
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: const Text('Set Price & Size'),
                                    content: ListView(
                                      children: [
                                        TextFormField(
                                          controller: sizeController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              labelText: 'Size (optional)',
                                              prefixIcon: Icon(Icons.next_week_outlined,
                                                color: Theme.of(context).primaryColor,),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 1,color: Theme.of(context).primaryColor),
                                                  borderRadius: BorderRadius.circular(20.0)
                                              )
                                          ),
                                          validator: (value){
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: purchasePriceController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              labelText: 'Purchase Price',
                                              prefixIcon: Icon(Icons.next_week_outlined,
                                                color: Theme.of(context).primaryColor,),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 1,color: Theme.of(context).primaryColor),
                                                  borderRadius: BorderRadius.circular(20.0)
                                              )
                                          ),
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              return 'This field must not be empty';
                                            }
                                            if(num.parse(value)<= 0){
                                              return 'Purchase Price should be greater than 0';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: salePriceController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              labelText: 'Sale Price',
                                              prefixIcon: Icon(Icons.next_week_outlined,
                                                color: Theme.of(context).primaryColor,),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 1,color: Theme.of(context).primaryColor),
                                                  borderRadius: BorderRadius.circular(20.0)
                                              )
                                          ),
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              return 'This field must not be empty';
                                            }
                                            if(num.parse(value)<= 0){
                                              return 'Sale Price should be greater than 0';
                                            }
                                            return null;
                                          },
                                        )
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('cancel')),
                                      ElevatedButton(
                                          onPressed: (){

                                          },
                                          child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text('Set Product Price ',
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                      ),
                    )
                  ],
                );
              }
              if(snapshot.hasError){
                return const Center(child: Text('Failed to get data'),);
              }
              return const Center(child: CircularProgressIndicator(),);
            },),

      ),
    );
  }
}
