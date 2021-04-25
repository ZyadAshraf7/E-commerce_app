import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imagePath;

  CartItem(
      {this.id,
      this.title,
      this.price,
      this.quantity,
      this.productId,
      this.imagePath});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Dismissible(
                key: ValueKey(id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  Provider.of<Cart>(context, listen: false)
                      .removeItem(productId);
                },
                confirmDismiss: (direction) {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Are you sure ?"),
                      content: Text("Do you want to remove this item"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text(
                            "yes",
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text(
                            "No",
                          ),
                        ),
                      ],
                    ),
                  );
                },
                background: Container(
                  padding: EdgeInsets.all(10.0),
                  // margin: EdgeInsets.only(right: 10),
                  color: Colors.redAccent,
                  child: Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerRight,
                ),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    leading: Container(
                      // padding: EdgeInsets.all(10),
                      height: 75,
                      width: 75,
                      child: Image.network(imagePath),
                    ),
                    title: Text("$title"),
                    trailing: Container(
                      width: 120,
                      child: Row(
                        children: [
                          IconButton(icon: Icon(Icons.add), onPressed: (){cart.addToCart(productId, price, title, imagePath);},iconSize: 20,),
                          Text("$quantity x"),
                          IconButton(icon: Icon(Icons.remove), onPressed: (){cart.decrementItem(productId);},iconSize: 20,),
                        ],
                      ),
                    ),
                    subtitle: Text(
                        "Total: \$${(price * quantity).toStringAsFixed(2)}"),
                  ),
                ),
              ),
            ),
            // Divider(),
            // Expanded(
            //   flex: 0,
            //   child: ListTile(
            //     leading: Icon(Icons.shop),
            //     title: Text("Shop"),
            //   ),
            // ),
            // Divider(),
            // Expanded(
            //   flex: 0,
            //   child: ListTile(
            //     leading: Icon(Icons.shop),
            //     title: Text("Shop"),
            //   ),
            // ),
            // Divider(),
            // Expanded(
            //   flex: 0,
            //   child: ListTile(
            //     leading: Icon(Icons.shop),
            //     title: Text("Shop"),
            //   ),
            // ),
            // Divider(),
            // Expanded(
            //   flex: 0,
            //   child: ListTile(
            //     leading: Icon(Icons.shop),
            //     title: Text("Shop"),
            //   ),
            // ),
            // Divider(),
            // Expanded(
            //   flex: 0,
            //   child: ListTile(
            //     leading: Icon(Icons.shop),
            //     title: Text("Shop"),
            //   ),
            // ),
            // Divider(),
          ],
        ),
      ),
    );
  }
}
