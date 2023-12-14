import 'package:cafe_admin/models/add_user_model.dart';
import 'package:cafe_admin/models/table_number_model.dart';
import 'package:cafe_admin/provider/product_provider.dart';
import 'package:cafe_admin/utils/constants.dart';
import 'package:cafe_admin/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class TableNumberPage extends StatefulWidget {
  static const String routeName = 'tableNumber';
  const TableNumberPage({super.key});

  @override
  State<TableNumberPage> createState() => _TableNumberPageState();
}

class _TableNumberPageState extends State<TableNumberPage> {

  final tableNameController = TextEditingController();
  final tableNumberController = TextEditingController();


  @override
  void dispose() {
    tableNameController.dispose();
    tableNumberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProductProvider>(context, listen: false);
    //Provider.of<ProductProvider>(context,listen: false).getAllTableValue();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Restaurant Tables'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) =>  ListView.builder(
          itemCount: provider.tableList.length,
          itemBuilder: (context, index) {
            final table = provider.tableList[index];
            print(provider.tableList.length);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0,
                horizontal: screenWidth > 1000 ? screenWidth * 0.15
                    : screenWidth > 600 ? screenWidth * 0.1 : 20),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Table Name',style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                    trailing: Text('Table Number',style: TextStyle(fontSize: 16,color: Colors.green),),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text('${table.tableName}'),
                      trailing: Text('${table.tableNumber}'),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: grey,
        onPressed: (){
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return
                AlertDialog(
                title: Text('Add Restaurant Table'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: tableNameController,
                      decoration: const InputDecoration(
                        hintText:'enter table name',
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: tableNumberController,
                      decoration: const InputDecoration(
                          hintText:'enter table number'
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(tableNumberController.text.isEmpty || tableNameController.text.isEmpty){
                        return;
                      }else{
                        final tableModel = TableModel(
                            tableName: tableNameController.text.capitalize(),
                            tableNumber: num.parse(tableNumberController.text)
                        );
                        final provider = Provider.of<ProductProvider>(context, listen: false);
                        List<TableModel> existingTable = provider.tableList;

                        bool isNameRepeated = existingTable.any(
                                (table) => table.tableNumber == tableModel.tableNumber);
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
                          provider.addTable(tableModel).then((value) {
                            EasyLoading.dismiss();
                            setState(() {
                              tableNumberController.clear();
                              tableNameController.clear();
                            });
                          });
                        }

                      }
                    },
                    child: const Text('save'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
