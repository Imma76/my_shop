import 'package:alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_shop/crud_services/crud.dart';
import 'package:provider/provider.dart';
import '../models/product_models/hot_list.dart';
import 'package:my_shop/models/product_models/for_you_list.dart';
import '../models/cart_model/cart_model.dart';
import '../models/cart_model/cart_item.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List item = [];
  Stream firebaseHlData;
  Stream firebaseFyData;
  FirebaseServices _firebaseServices = new FirebaseServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseServices.getForYouData().then((result) {
      setState(() {
        firebaseFyData = result;
      });
    });

    _firebaseServices.getHotListData().then((result) {
      firebaseHlData = result;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 70.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.asset('images/admin.png'),
                      backgroundColor: Colors.blue,
                      radius: 40.0,
                    ),
                    title: Text('Welcome',
                        style: TextStyle(color: Color(0xff84B7DD))),
                    subtitle: Text('Joni Beckham'),
                    trailing: Icon(Icons.notifications),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText:
                            'Search here                                                   ⌕ ',
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hot Picks',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      InkWell(
                          // onTap: () => Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return AllVideoPage(
                          //         name: 'Recent Videos',
                          //       );
                          //     },
                          //   ),
                          // ),
                          child: Text('See All >')),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                      //color: Colors.red,
                      height: 294.0,
                      child: StreamBuilder(
                          stream: firebaseHlData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final double categoryHeight = 180.0;
                                    //MediaQuery.of(context).size.height * 0.30 - 20;
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                snapshot.data.docs[index]
                                                    .get('imgUrl'),
                                                height: 300.0,
                                                width: 230.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        .get('productName'),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(height: 7),
                                                  Text(
                                                      '\$ ${snapshot.data.docs[index].get('productPrice')}',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  SizedBox(height: 25),
                                                ],
                                              ),
                                            ),
                                          ],
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
                SizedBox(
                  height: 7.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('For You',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      InkWell(
                          // onTap: () => Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return AllVideoPage(
                          //         name: 'Recent Videos',
                          //       );
                          //     },
                          //   ),
                          // ),
                          child: Text('See All >')),
                    ],
                  ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200.0,
                                          width: 154.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          //color: Colors.lightBlueAccent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15.0),
                                                child: Text(
                                                  snapshot.data.docs[index]
                                                      .get('productName'),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '\$ ${snapshot.data.docs[index].get('productPrice')}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      // padding: EdgeInsets.zero,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        color: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                      child: Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            var cartItems =
                                                                CartItem(
                                                              productPrice: snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .get(
                                                                      'productPrice'),
                                                              productImage: snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .get(
                                                                      'imgUrl'),
                                                              productName: snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .get(
                                                                      'productName'),
                                                            );
                                                            Provider.of<Cart>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addItemToCart(
                                                                    cartItems);
                                                            Alert(
                                                                    message:
                                                                        'item added to cart')
                                                                .show();
                                                            var sum = Provider.of<
                                                                        Cart>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getSumOfProductss(
                                                              snapshot.data
                                                                  .docs[index]
                                                                  .get(
                                                                      'productPrice'),
                                                            );
                                                          },
                                                          child: Icon(Icons.add,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   backgroundColor: Colors.lightBlueAccent,
        //   onPressed: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) {
        //         return AddProducts();
        //       },
        //     ),
        //   ),
        // ),
      ),
    );
  }
}


// IconButton(
//                                                     icon: Icon(Icons
//                                                         .shopping_cart_rounded),
//                                                     onPressed: () {
//                                                       var cartItems = CartItem(
//                                                         productPrice: snapshot
//                                                             .data.docs[index]
//                                                             .get(
//                                                                 'productPrice'),
//                                                         productName: snapshot
//                                                             .data.docs[index]
//                                                             .get('productName'),
//                                                         productImage: snapshot
//                                                             .data.docs[index]
//                                                             .get('imgUrl'),
//                                                       );
//                                                       Provider.of<Cart>(context,
//                                                               listen: false)
//                                                           .addItemToCart(
//                                                               cartItems);
//                                                       Alert(
//                                                               message:
//                                                                   'item added to cart')
//                                                           .show();
//                                                     },
//                                                   )