import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/crud_services/crud.dart';
import 'package:my_shop/models/cart_model/cart_item.dart';
import 'package:my_shop/models/cart_model/cart_model.dart';
import 'file:///C:/Users/USER/AndroidStudioProjects/my_shop/lib/admin_panel/add_section/hot_list.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/models/product_models/for_you_list.dart';
import 'package:my_shop/models/product_models/hot_list.dart';
import 'file:///C:/Users/USER/AndroidStudioProjects/my_shop/lib/admin_panel/add_section/for_you.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Stream firebaseHlData;
  Stream firebaseFyData;
  FirebaseServices _firebaseServices = new FirebaseServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseServices.getForYouData().then((result) {
      firebaseFyData = result;
      setState(() {});
    });

    _firebaseServices.getHotListData().then((result) {
      firebaseHlData = result;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlatButton(
                minWidth: double.infinity,
                child: Text('Upload Items to the FOR YOU section'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ForYouAddSection();
                  }));
                },
                color: Colors.lightBlueAccent,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                    //color: Colors.red,
                    height: 364.0,
                    child: StreamBuilder(
                        stream: firebaseFyData,
                        builder: (context, snapshot) {
                          var mainAxisHeight =
                              MediaQuery.of(context).size.height / 25;
                          var mainAxisSpacing =
                              MediaQuery.of(context).size.height / 3.2;
                          var mainAxisSpacing1 =
                              MediaQuery.of(context).size.height / 2.2;
                          var mainAxiswidth =
                              MediaQuery.of(context).size.width / 13;
                          if (snapshot.hasData)
                            return GridView.builder(
                                itemCount: snapshot.data.docs.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 2.0,
                                  mainAxisSpacing: 5.0,
                                  mainAxisExtent: 178.0,
                                ),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onLongPress: () async {
                                          var id = snapshot.data.docs[index].id;
                                          await FirebaseFirestore.instance
                                              .collection('for_you_products')
                                              .doc(id)
                                              .delete();
                                        },
                                        child: Container(
                                          height: 200.0,
                                          width: 154.0,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          //color: Colors.lightBlueAccent,
                                          child: Column(
                                            //crossAxisAlignment:
                                            //  CrossAxisAlignment.center,
                                            //mainAxisAlignment:
                                            //  MainAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  snapshot.data.docs[index]
                                                      .get('imgUrl'),
                                                  height: 110.0,
                                                  width: 200.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        .get('productName'),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .shopping_cart_rounded),
                                                    onPressed: () {
                                                      var cartItems = CartItem(
                                                        productPrice: snapshot
                                                            .data.docs[index]
                                                            .get(
                                                                'productPrice'),
                                                        productName: snapshot
                                                            .data.docs[index]
                                                            .get('productName'),
                                                        productImage: snapshot
                                                            .data.docs[index]
                                                            .get('imgUrl'),
                                                      );
                                                      Provider.of<Cart>(context,
                                                              listen: false)
                                                          .addItemToCart(
                                                              cartItems);
                                                    },
                                                  )
                                                ],
                                              ),
                                              Text(
                                                snapshot.data.docs[index]
                                                    .get('productPrice'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                    ],
                                  );
                                });
                          return Container();
                        })),
              ),
              FlatButton(
                minWidth: double.infinity,
                child: Text('Upload to the HOT LIST section'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HotListAddSection();
                  }));
                },
                color: Colors.lightBlueAccent,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: StreamBuilder(
                    stream: firebaseHlData,
                    builder: (context, snapshot) {
                      return Container(
                        //color: Colors.red,
                        height: 210.0,
                        child: snapshot.data.docs.reversed.length != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.reversed.length,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final rev =
                                      snapshot.data.docs.reversed.toList();
                                  //MediaQuery.of(context).size.height * 0.30 - 20;
                                  return Row(
                                    children: [
                                      Container(
                                        color: Colors.grey,
                                        height: 200.0,
                                        width: 120.0,
                                        //color: Colors.lightBlueAccent,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          // crossAxisAlignment:
                                          //   CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                rev[index].get('imgUrl'),
                                                height: 100.0,
                                              ),
                                            ),
                                            Text(
                                              rev[index].get('productName'),
                                            ),
                                            Text(
                                              rev[index].get('productPrice'),
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  _firebaseServices
                                                      .deleteFyItems(
                                                          rev[index].id);
                                                  print('deleted');
                                                })
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                    ],
                                  );
                                })
                            : Container(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
