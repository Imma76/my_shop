import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'models/product_models/items.dart';
import 'package:provider/provider.dart';
import 'models/product_models/hot_list.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  File selectedImage;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => getImage(),
                    child: selectedImage != null
                        ? Container(
                            child: Image.file(
                              selectedImage,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () => getImage(),
                            ),
                            height: 150.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey,
                              //image: DecorationImage(image: AssetImage('$selectedImage'))),
                            ),
                          ),
                  ),
                  TextFormField(
                    controller: productName,
                    decoration: InputDecoration(hintText: 'product name'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'product price'),
                    controller: productPrice,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      var addItems = Items(
                          productName: productName.text,
                          productPrice: productPrice.text,
                          productImage: selectedImage);
                      Provider.of<HotList>(context, listen: false)
                          .addItemToHotList(addItems);
                      Navigator.pop(context);
                      //context.watch<ProductItems>().addItem(addItems);
                    },
                    color: Colors.lightBlueAccent,
                    child: Text('Add Product'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
