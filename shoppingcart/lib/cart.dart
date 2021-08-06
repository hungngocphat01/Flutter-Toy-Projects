import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping cart"),
      ),
      body: const CartList(),
    );
  }
}

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  late ShoppingCart _cart;

  void onProductRemove(int i, BuildContext context) {
    debugPrint("${_cart.at(i).productName} removed from cart");
    _cart.setProductState(i, false);

    _cart.removeIndex(i);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${_cart.at(i).productName} has been removed from cart"),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _cart = Provider.of<ShoppingCart>(context);
    if (_cart.isEmpty()) {
      return const Center(child: Text("Cart is empty"));
    }

    List<Card> cardlist = [];

    for (int i = 0; i < _cart.size(); i++) {
      var item = _cart.at(i);
      cardlist.add(Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(item.productIcon),
                ),
                Text(item.productName)
              ],
            ),
            Row(
              children: [
                Text("\$${item.productPrice}"),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.delete),
                  ),
                  onTap: () => onProductRemove(i, context),
                )
              ],
            )
          ],
        ),
      ));
    }

    return ListView(
      children: cardlist,
    );
  }
}
