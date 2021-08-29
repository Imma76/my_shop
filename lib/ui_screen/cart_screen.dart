import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/cart_model/cart_item.dart';
import 'package:my_shop/models/cart_model/cart_model.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _inProgress = false;
  String _cardNumber;

  String paystackPublicKey = 'pk_test_7d0ffd5d0a5c9a191879147cbcd10644e06cefd1';
  String _cvv;
  int _expiryMonth;
  int _expiryYear;
  CheckoutMethod _method = CheckoutMethod.card;
  int _radioValue = 0;
  final plugin = PaystackPlugin();
  @override
  void initState() {
    plugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

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
                child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    if (cart.cartItems.isEmpty) {
                      return Center(child: Text('No items in cart'));
                    }
                    return Column(
                      children: [
                        Container(
                          height: 100.0,
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
                                  cart.cartItems[index].productImage),
                              title:
                                  Text('${cart.cartItems[index].productName}'),
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
                  },
                ),
                _getPlatformButton(
                  'Checkout',
                  () => initiatePayment(context),
                ),
              ],
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

  initiatePayment(BuildContext context) async {
    if (_method != CheckoutMethod.card && _isLocal) {
      _showMessage('Select server initialization method at the top');
      return;
    }
    setState(() => _inProgress = true);
    _formKey.currentState?.save();
    Charge charge = Charge()
      ..amount =
          Provider.of<Cart>(context, listen: false).sum //In base currency
      ..email = 'customer@email.com'
      ..card = _getCardFromUI();
    if (!_isLocal) {
      var accessCode = await _fetchAccessCodeFrmServer(_getReference());
      charge.accessCode = accessCode;
    } else {
      charge.reference = _getReference();
    }

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      setState(() => _inProgress = false);
      _updateStatus(response.reference, '$response');
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("Check console for error");
      rethrow;
    }
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Widget _getPlatformButton(String string, Function() function) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = new CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: new Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = new ElevatedButton(
        onPressed: function,
        child: new Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
    return widget;
  }

  Future<String> _fetchAccessCodeFrmServer(String reference) async {
    String backendUrl = 'https://shoppage.herokuapp.com';
    String url = '$backendUrl/new-access-code';
    String accessCode;
    try {
      print("Access code url = $url");
      http.Response response = await http.get(Uri.parse(url));
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      setState(() => _inProgress = false);
      _updateStatus(
          reference,
          'There was a problem getting a new access code form'
          ' the backend: $e');
    }

    return accessCode;
  }

  _updateStatus(String reference, String message) {
    _showMessage('Reference: $reference \n\ Response: $message',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text('transaction failed'),
      duration: duration,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () =>
              ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    ));
  }

  bool get _isLocal => _radioValue == 0;
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "CO",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
