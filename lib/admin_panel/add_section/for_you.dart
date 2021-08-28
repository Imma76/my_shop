import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/USER/AndroidStudioProjects/my_shop/lib/models/product_models/items.dart';
import 'package:my_shop/models/product_models/for_you_list.dart';
import 'package:random_string/random_string.dart';
import 'package:my_shop/crud_services/crud.dart';

class ForYouAddSection extends StatefulWidget {
  @override
  _ForYouAddSectionState createState() => _ForYouAddSectionState();
}

class _ForYouAddSectionState extends State<ForYouAddSection> {
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  File selectedImage;
  bool load = false;
  FirebaseServices _firebaseServices = new FirebaseServices();
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        load = true;
      });
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('for_you_image')
          .child('${randomAlphaNumeric(9)}.jpg');
      final UploadTask task = firebaseStorageRef.putFile(selectedImage);
      var downloadUrl = await (await task.whenComplete(() => print('done')))
          .ref
          .getDownloadURL();
      print('downloadUrl is :$downloadUrl');
      Map<String, dynamic> productData = {
        'imgUrl': downloadUrl,
        'productName': productName.text,
        'productPrice': productPrice.text,
        'desc': productDesc.text,
      };

      _firebaseServices.addProductsToForYou(productData).then((result) {
        setState(() {
          load = false;
        });
      });
      Navigator.of(context).pop();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                      TextFormField(
                        controller: productDesc,
                        decoration: InputDecoration(hintText: 'product desc'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        onPressed: () {
                          // var addItems = Items(
                          //     productName: productName.text,
                          //     productPrice: productPrice.text,
                          //     productImage: selectedImage,
                          // productDesc: productDesc.text,
                          // );
                          // Provider.of<ForYouList>(context, listen: false)
                          //     .addItemsToForYouList(addItems);
                          uploadBlog();
                        },
                        color: Colors.lightBlueAccent,
                        child: Text('Add product to for you list'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
