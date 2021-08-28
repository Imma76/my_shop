import 'package:flutter/material.dart';
import 'package:my_shop/models/cart_model/cart_item.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/models/cart_model/cart_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '\$${Provider.of<Cart>(context, listen: false).sum.toStringAsFixed(2)}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                if (cart.cartItems.isNotEmpty) {
                  return Column(
                    children: [
                      Container(
                        height: 100.0,
                        child: Card(
                          child: ListTile(
                            leading: Image.network(
                                cart.cartItems[index].productImage),
                            title: Text('${cart.cartItems[index].productName}'),
                            subtitle:
                                Text('${cart.cartItems[index].productPrice}'),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: () {
                                var cartItems = CartItem(
                                  productPrice:
                                      cart.cartItems[index].productPrice,
                                  productName:
                                      cart.cartItems[index].productName,
                                  productImage:
                                      cart.cartItems[index].productImage,
                                );
                                Provider.of<Cart>(context, listen: false)
                                    .getSubOfProductss(
                                        cart.cartItems[index].productPrice);
                                cart.removeItemFromCart(index);
                                print('done');
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                }
                return Center(child: Text('No items in cart'));
              },
            )
                // : Center(
                //     child: Text(
                //       'No Items added to cart',
                //       style: TextStyle(fontSize: 30.0),
                //     ),
                //   ),
                ),
          ),
        );
      },
    ));
  }
}
