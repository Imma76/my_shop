import 'package:flutter/foundation.dart';
import 'cart_item.dart';

class Cart extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List get cartItems => _cartItems;
  int _sum = 0;
  int get sum => _sum;
  void addItemToCart(CartItem item) {
    cartItems.add(item);
    notifyListeners();
  }

  void getSumOfProductss(var totalSum) {
    _sum = _sum + int.parse(totalSum);
    notifyListeners();
  }

  void getSubOfProductss(var totalSum) {
    _sum = _sum - int.parse(totalSum);
    notifyListeners();
  }

  void removeItemFromCart(int item) {
    cartItems.removeAt(item);

    notifyListeners();
  }
}
