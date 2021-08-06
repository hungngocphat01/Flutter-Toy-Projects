import 'package:flutter/material.dart';

class ShoppingItem {
  String productName;
  double productPrice;
  IconData productIcon;
  bool productChosen = false;

  ShoppingItem({
    required this.productName,
    required this.productPrice,
    required this.productIcon,
  });
}

class ShoppingCart with ChangeNotifier {
  List<ShoppingItem> _cart = [];

  void add(ShoppingItem item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeIndex(int i) {
    _cart.remove(_cart[i]);
    notifyListeners();
  }

  void remove(ShoppingItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  void setProductState(int i, bool state) {
    _cart[i].productChosen = state;
    notifyListeners();
  }

  bool isEmpty() => _cart.isEmpty;

  int size() => _cart.length;

  ShoppingItem at(int i) => _cart[i];
}
