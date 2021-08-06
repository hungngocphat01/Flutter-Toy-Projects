import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'product.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ShoppingCart>(
      create: (context) => ShoppingCart(),
      child: const MaterialApp(
        home: Homescreen(),
      ),
    ),
  );
}
