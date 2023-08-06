
import 'package:cafe_admin/models/category_model.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:cafe_admin/utils/helper_function.dart';
//import 'package:cafe_admin/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  @override
  void dispose() {
    namController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) =>
         provider.categoryList.isEmpty ?
        const Center(
          child: Text('NO item found',
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
                  backgroundImage: NetworkImage(category.imageUrl!),
                ),
                title: Text('${category.name} (${category.productCount})',style: TextStyle(color: Colors.blue),),
              ),
            );

          },

        ),
      ),

      bottomSheet: DraggableScrollableSheet(
        initialChildSize: 0.05,
        minChildSize: 0.05,
        maxChildSize: 0.5,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Card(
            color: Colors.purple.shade100,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              controller: scrollController,
              children: [
                const Center(
                  child: Icon(Icons.drag_handle),
                ),
                const ListTile(
                  title: Text('ADD CATEGORY'),
                ),
                TextField(
                  controller: namController,
                  decoration: const InputDecoration(
                    hintText: 'Enter new Category',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: _imageUrl == null
                      ? isUploading ?
                      const Center(child: CircularProgressIndicator(),) :
                      Image.asset(
                        'images/placeholder.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                          :FadeInImage.assetNetwork(
                          placeholder: 'images/loading.gif',
                          image: _imageUrl!,
                          fadeInDuration: const Duration(seconds: 1),
                          fadeInCurve: Curves.bounceInOut,
                          height: 100,
                          width: 100,
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
                        onPressed: () {
                          _imageSource = ImageSource.camera;
                          _getImage();
                        }, child: const Text('Camera'),),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          _imageSource = ImageSource.gallery;
                          _getImage();
                        }, child: const Text('Gallery')),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async{
                      if(_imageUrl == null || namController.text.isEmpty){
                        return;
                      }
                      else{
                        final categoryModel = CategoryModel(
                          name: namController.text.capitalize(),
                          imageUrl: _imageUrl,
                        );
                        Provider
                            .of<ProductProvider>(context,listen: false)
                            .addCategory(categoryModel).then((value) {
                              setState(() {
                                namController.clear();
                                _imageUrl = null;
                              });
                        });
                      }
                    },
                    child: const Text('ADD'))
              ],
            ),
          );

        },
      ),
    );
  }

  void _getImage() async{
    final selectedImage = await ImagePicker().pickImage(source: _imageSource,imageQuality: 75);
    if(selectedImage != null){
      setState(() {
        isUploading = true;
      });
      try{
        final url =
        await context.read<ProductProvider>().updateCatImage(selectedImage);
        setState(() {
          _imageUrl = url;
          isUploading = false;
        });
      }catch(e){
      }
    }
  }
}
