import 'package:cafe_admin/models/category_model.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:cafe_admin/utils/helper_function.dart';
import 'package:flutter/foundation.dart';

//import 'package:cafe_admin/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = '/category';

  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final namController = TextEditingController();
  bool isUploading = false;
  String? _imageUrl;
  ImageSource _imageSource = ImageSource.gallery;
  Uint8List webImage = Uint8List(8);

  @override
  void dispose() {
    namController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Consumer<ProductProvider>(
                builder: (context, provider, _) => provider.categoryList.isEmpty
                    ? const Center(
                        child: Text(
                          'NO item found',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: provider.categoryList.length,
                        itemBuilder: (context, index) {
                          final category = provider.categoryList[index];
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(category.imageUrl!),
                              ),
                              title: Text(
                                '${category.name} (${category.productCount})',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: screenWidth > 1100
                      ? 30
                      : screenWidth > 600
                          ? 10
                          : 10),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.amberAccent,
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                          child: Text(
                            'ADD CATEGORY',
                            style: TextStyle(
                              fontSize: 30,
                              color: dark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Card(
                      color: skyBlue,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: _imageUrl == null
                                      ? isUploading
                                          ? const Center(
                                              child: CircularProgressIndicator(),
                                            )
                                          : Image.asset(
                                              'images/placeholder.jpg',
                                              height: 300,
                                              width: 300,
                                              fit: BoxFit.cover,
                                            )
                                      : FadeInImage.assetNetwork(
                                          placeholder: 'images/loading.gif',
                                          image: _imageUrl!,
                                          fadeInDuration:
                                              const Duration(seconds: 1),
                                          fadeInCurve: Curves.bounceInOut,
                                          height: 300,
                                          width: 300,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: dark
                                ),
                                child: const Text('Cancel',style: TextStyle(color: secondaryColor),),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _imageSource = ImageSource.gallery;
                                    _getImage();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: dark
                                  ),
                                  child: const Text('Gallery',style: TextStyle(color: secondaryColor),)),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Category Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: namController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    hintText: 'Enter new Category',
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: isUploading ? null : _onSave,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: dark,
                                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5)
                              ),
                              child: const Text('ADD',style: TextStyle(color: secondaryColor),)
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getImage() async {
    if(kIsWeb){
      final selectedImage =
      await ImagePicker().pickImage(source: _imageSource, imageQuality: 75);
      if (selectedImage != null) {
        var f = await selectedImage.readAsBytes();
        setState(() {
          webImage = f;
          isUploading = true;
        });
        try {
          final url =
          await context.read<ProductProvider>().updateCatImage(webImage);
          setState(() {
            _imageUrl = url;
            isUploading = false;
          });
        } catch (e) {}
      }
    }
  }

  void _onSave() async {
    if (_imageUrl == null || namController.text.isEmpty) {
      return;
    } else {
      final categoryModel = CategoryModel(
        name: namController.text.capitalize(),
        imageUrl: _imageUrl,
      );
      final provider = Provider.of<ProductProvider>(context, listen: false);
      List<CategoryModel> existingCategories = provider.categoryList;

      bool isNameRepeated = existingCategories.any(
          (category) => category.name! == categoryModel.name!.capitalize());
      if (isNameRepeated) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Name Repeated'),
              content: const Text('Category name already exists.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        EasyLoading.show(status: 'please Wait....', dismissOnTap: false);
        provider.addCategory(categoryModel).then((value) {
          EasyLoading.dismiss();
          setState(() {
            namController.clear();
            _imageUrl = null;
          });
        });
      }
    }
  }
}
