import 'package:flutter/foundation.dart';

class ForYouList extends ChangeNotifier {
  List _forYouItems = [];
  List get forYouItems => _forYouItems;

  void addItemsToForYouList(var item) {
    forYouItems.add(item);
    notifyListeners();
  }

  void deleteItemsFromForYouList(var index) {
    forYouItems.removeAt(index);
    notifyListeners();
  }

  // void editItem(){
  //   forYouItems.
  // }
}
