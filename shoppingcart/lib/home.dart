import 'package:flutter/material.dart';
import 'package:listview/cart.dart';
import 'package:listview/product.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Product list"),
            InkWell(
              child: const Icon(Icons.shopping_cart),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cartscreen(),
                ),
              ),
            )
          ],
        ),
      ),
      body: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ShoppingItem> shoppingItems = [
    ShoppingItem(
      productName: "Laptop",
      productPrice: 1000,
      productIcon: Icons.laptop_windows,
    ),
    ShoppingItem(
      productName: "Macbook Pro",
      productPrice: 2000,
      productIcon: Icons.laptop_mac,
    ),
    ShoppingItem(
      productName: "TV",
      productPrice: 200,
      productIcon: Icons.tv,
    ),
    ShoppingItem(
      productName: "SD card",
      productPrice: 10,
      productIcon: Icons.sd_card,
    ),
    ShoppingItem(
      productName: "Stroller",
      productPrice: 50,
      productIcon: Icons.stroller,
    )
  ];
  late ShoppingCart _cart;

  void onProductAdd(ShoppingItem item, BuildContext context) {
    debugPrint("${item.productName} added to cart");
    item.productChosen = !item.productChosen;

    if (item.productChosen) {
      _cart.add(item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${item.productName} as been added to cart"),
          duration: const Duration(milliseconds: 500),
        ),
      );
    } else {
      _cart.remove(item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${item.productName} as been removed from cart"),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _cart = Provider.of<ShoppingCart>(context);
    List<Card> cardlist = [];

    for (var item in shoppingItems) {
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: item.productChosen
                          ? Colors.greenAccent
                          : Colors.black,
                    ),
                  ),
                  onTap: () => onProductAdd(item, context),
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
