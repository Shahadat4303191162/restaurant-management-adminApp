import 'dart:async';

import 'package:cafe_admin/models/product_model.dart';
import 'package:cafe_admin/models/purchase_model.dart';
import 'package:cafe_admin/models/divers_selection_model.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:cafe_admin/utils/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/date_model.dart';
import '../utils/constants.dart';
import '../widgets/responsive.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/new_product';
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final from_key = GlobalKey<FormState>();
  final _namController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _longDescriptionController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _salesPriceController = TextEditingController();
  final _sizeController = TextEditingController();
  final _discountController = TextEditingController();
  final _quantityController = TextEditingController();
  late StreamSubscription<ConnectivityResult> subscription;
  bool _isConnected = true,isUploading = false, isSaving = false;
  String? _category;
  String? _thumbnailImageUrl;
  DateTime? _purchaseDate;
  ImageSource _imageSource = ImageSource.gallery;
  Uint8List webImage = Uint8List(8);

  @override
  void initState() {
    isConnectedToInternet().then((value) {
      setState(() {
        _isConnected = value;
      });
    });
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _namController.dispose();
    _shortDescriptionController.dispose();
    _longDescriptionController.dispose();
    _purchasePriceController.dispose();
    _salesPriceController.dispose();
    _discountController.dispose();
    _quantityController.dispose();
    _sizeController.dispose();
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New Product'),

      ),
      body: Form(
        key: from_key,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if(!_isConnected)
              const ListTile(
                tileColor: Colors.red,
                title: Text('NO internet connectivity',
                  style: TextStyle(color: Colors.white),),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(appPadding),
                              decoration: const BoxDecoration(
                                color: skyBlue,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _namController,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      labelText: 'Product Name',
                                      prefixIcon: Icon(Icons.drive_file_rename_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide( width: 1,color: Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    validator: (value){
                                      if(value == null || value.isEmpty){
                                        return 'This field must not be empty';
                                      }else{
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    maxLines: 2,
                                    controller: _shortDescriptionController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter short Description(optional)',
                                      prefixIcon: Icon(Icons.short_text,
                                          color: Theme.of(context).primaryColor),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide( width: 1,color: Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),

                                    ),
                                    validator: (value){
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    maxLines: 3,
                                    controller: _longDescriptionController,
                                    decoration: InputDecoration(
                                        labelText: 'Enter Long Description (optional)',
                                        prefixIcon: Icon(Icons.description,
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
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // TextFormField(
                                  //   controller: _sizeController,
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       labelText: 'Size (optional)',
                                  //       prefixIcon: Icon(
                                  //         Icons.next_week_outlined,
                                  //         color: Theme.of(context).primaryColor,
                                  //       ),
                                  //       enabledBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1, color: Theme.of(context).primaryColor),
                                  //           borderRadius: BorderRadius.circular(20.0))),
                                  //   validator: (value) {
                                  //     return null;
                                  //   },
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _purchasePriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Purchase Price (Default)',
                                        prefixIcon: Icon(
                                          Icons.monetization_on_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Theme.of(context).primaryColor),
                                            borderRadius: BorderRadius.circular(20.0))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field must not be empty';
                                      }
                                      if (num.parse(value) <= 0) {
                                        return 'Purchase Price should be greater than 0';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _salesPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Sale Price (Default)',
                                        prefixIcon: Icon(
                                          Icons.monetization_on,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Theme.of(context).primaryColor),
                                            borderRadius: BorderRadius.circular(20.0))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field must not be empty';
                                      }
                                      if (num.parse(value) <= 0) {
                                        return 'Sale Price should be greater than 0';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Quantity',
                                        prefixIcon: Icon(Icons.numbers,
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
                                        return 'Quantity should be greater than 0';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _discountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Discount',
                                        prefixIcon: Icon(Icons.discount,
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
                                      if(num.parse(value) < 0){
                                        return 'Discount should not be a negative value';
                                      }
                                      if(num.parse(value) > 80){
                                        return 'Discount amounts of up to 80%';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Consumer<ProductProvider>(
                                      builder: (context, provider, _) =>
                                          DropdownButtonFormField<String>(
                                            onChanged: (value){
                                              setState(() {
                                                _category = value;
                                              });
                                            },
                                            hint: const Text('select category'),
                                            value: _category,
                                            items: provider.categoryList.map((model) => DropdownMenuItem<String>(
                                              value: model.name,
                                              child: Text(model.name!),
                                            )).toList(),
                                          )
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: _selectDate,
                                          child: const Text('Select Purchase Date'),),
                                        Text(_purchaseDate == null ? 'No Date Chosen' : getFormattedTime(_purchaseDate!, 'dd/MM/yyyy'))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if(Responsive.isMobile(context))
                              SizedBox(height: appPadding,),
                            if(Responsive.isMobile(context))
                              Container(
                                padding: const EdgeInsets.all(appPadding),
                                decoration: const BoxDecoration(
                                  color: skyBlue,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Card(
                                        elevation: 5,
                                        child: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: _thumbnailImageUrl == null ?
                                            isUploading ?
                                            const Center(child: CircularProgressIndicator() ,) :
                                            Image.asset(
                                              'images/placeholder.jpg',
                                              width: 300,
                                              height: 300,
                                              fit: BoxFit.cover,
                                            )
                                                : FadeInImage.assetNetwork(
                                              placeholder: 'images/loading.gif',
                                              image: _thumbnailImageUrl!,
                                              fadeInDuration: const Duration(seconds: 1),
                                              fadeInCurve: Curves.bounceInOut,
                                              width: 300,
                                              height: 300,
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: (){
                                            _imageSource = ImageSource.camera;
                                            _getImage();
                                          },
                                          child: const Text('Camera'),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: (){
                                            _imageSource = ImageSource.gallery;
                                            _getImage();
                                          },
                                          child: const Text('Gallery'),)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: isUploading ? null : _saveProduct,
                                        child: const Text('SAVE'))
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 0,
                          horizontal: screenWidth > 1100 ? 30
                              : screenWidth > 600 ? 10:10),),
                      if(!Responsive.isMobile(context))
                        SizedBox(width: appPadding),
                      if(!Responsive.isMobile(context))
                        Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                const Card(
                                  color: Colors.amberAccent,
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 12),
                                    child: Text(
                                      'Add Product Image :',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: dark,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(appPadding)),
                                Container(
                                  padding: const EdgeInsets.all(appPadding),
                                  decoration: const BoxDecoration(
                                    color: skyBlue,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Card(
                                          elevation: 5,
                                          child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: _thumbnailImageUrl == null ?
                                              isUploading ?
                                              const Center(child: CircularProgressIndicator() ,) :
                                              Image.asset(
                                                'images/placeholder.jpg',
                                                width: 300,
                                                height: 300,
                                                fit: BoxFit.cover,
                                              )
                                                  : FadeInImage.assetNetwork(
                                                placeholder: 'images/loading.gif',
                                                image: _thumbnailImageUrl!,
                                                fadeInDuration: const Duration(seconds: 1),
                                                fadeInCurve: Curves.bounceInOut,
                                                width: 300,
                                                height: 300,
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // ElevatedButton(
                                          //   onPressed: (){
                                          //     _imageSource = ImageSource.camera;
                                          //     _getImage();
                                          //   },
                                          //   child: const Text('Camera'),
                                          // ),
                                          // const SizedBox(
                                          //   width: 20,
                                          // ),
                                          ElevatedButton(
                                            onPressed: (){
                                              _imageSource = ImageSource.gallery;
                                              _getImage();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: dark
                                            ),
                                            child: const Text('Add Image',style: TextStyle(color: secondaryColor),),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        )
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.all(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: isUploading ? null : _saveProduct,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: dark,
                              padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 25)
                          ),
                          child: const Text('SAVE',style: TextStyle(color: secondaryColor),))
                    ],
                  )
                ],
              ),
            ),

            // const SizedBox(
            //   height: 10,
            // ),

          ],
        ),
      ),
    );
  }

  void _selectDate() async{
    final selectDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    if(selectDate != null){
      setState(() {
        _purchaseDate = selectDate;
      });
    }
  }

  void _getImage() async{
    if(!kIsWeb){
      // final selectedImage = await ImagePicker().pickImage(source: _imageSource);
      // if(selectedImage != null){
      //   setState(() {
      //     isUploading = true;
      //   });
      //   try{
      //     final url = await context.read<ProductProvider>().updateProductImage(selectedImage);
      //     setState(() {
      //       _thumbnailImageUrl = url;
      //       isUploading = false;
      //     });
      //   }catch(e){
      //     print(e);
      //   }
      // }
    }
    else if(kIsWeb){
      final selectedImage = await ImagePicker().pickImage(source: _imageSource,imageQuality: 75);
      if(selectedImage != null){
        var f = await selectedImage.readAsBytes();
        setState(() {
          webImage = f;
          isUploading = true;
        });
        try{
          final url = await context.read<ProductProvider>().updateProductImage(webImage);
          setState(() {
            _thumbnailImageUrl = url;
            isUploading = false;
          });
        }catch(e){
          print(e);
        }
      }
    }


  }

  void _saveProduct() {
    if(_thumbnailImageUrl== null){
      showMsg(context, 'Image required for product');
      return;
    }
    if(_purchaseDate == null){
      showMsg(context, 'purchase date is required');
      return;
    }
    if(from_key.currentState!.validate()){
      EasyLoading.show(status: 'Please Wait....',dismissOnTap: false);
      final productModel = ProductModel(
          name: _namController.text,
          shortDescription: _shortDescriptionController.text.isEmpty? null : _shortDescriptionController.text,
          longDescription: _longDescriptionController.text.isEmpty? null: _longDescriptionController.text,
          category: _category,
          salesPrice: num.parse(_salesPriceController.text),
          productDiscount: num.parse(_discountController.text),
          stock: num.parse(_quantityController.text),
          thumbnailImageUrl: _thumbnailImageUrl,
      );
      final purchaseModel = PurchaseModel(
          dateModel: DateModel(
            timestamp: Timestamp.fromDate(_purchaseDate!),
            day: _purchaseDate!.day,
            month: _purchaseDate!.month,
            year:_purchaseDate!.year,
          ),
          quantity: num.parse(_quantityController.text),
          price: num.parse(_purchasePriceController.text),
      );
      final diverseSelectionModel = DiverseSelectionModel(
          size: _sizeController.text.isEmpty? null :_sizeController.text,
          salePrice: num.parse(_salesPriceController.text),
          purPrice: num.parse(_purchasePriceController.text)
      );
      final catModel = context.read<ProductProvider>().getCategoryByName(_category!);
      context.read<ProductProvider>().
      addProduct(
          productModel,
          purchaseModel,
          diverseSelectionModel ,
          catModel).then((value) {
        EasyLoading.dismiss();
        setState(() {
          _namController.clear();
          _shortDescriptionController.clear();
          _longDescriptionController.clear();
          _discountController.clear();
          _salesPriceController.clear();
          _purchasePriceController.clear();
          _quantityController.clear();
          _purchaseDate = null;
          _thumbnailImageUrl = null;
          _category = null;
        });
      });
    }
  }
}
