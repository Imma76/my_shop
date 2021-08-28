import 'package:flutter/material.dart';

import 'items.dart';

class HotList extends ChangeNotifier {
  List _hotListItems = [];

  List get hotListItems => _hotListItems;

  addItemToHotList(var items) {
    hotListItems.add(items);
    notifyListeners();
  }

  deleteItemFromHotList(int index) {
    hotListItems.removeAt(index);
    notifyListeners();
  }
}
