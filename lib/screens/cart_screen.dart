import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/cart.dart' show Cart;
import 'package:my_shop_app/provider/orders.dart';
import 'package:my_shop_app/provider/product.dart';
import 'package:my_shop_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _shippingFees = 10;
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Text(
                "No Items in The Cart",
                style: TextStyle(fontSize: 20, fontFamily: "Roboto Bold"),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, i) => CartItem(
                      id: cart.items.values.toList()[i].id,
                      productId: cart.items.keys.toList()[i],
                      title: cart.items.values.toList()[i].title,
                      price: cart.items.values.toList()[i].price,
                      quantity: cart.items.values.toList()[i].quantity,
                      imagePath: cart.items.values.toList()[i].imagePath,
                    ),
                    itemCount: cart.itemCount,
                  ),
                ),
                Expanded(
                  child: Container(
                    //color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Subtotal",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "Shipping",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("\$${cart.totalAmount.toStringAsFixed(2)}"),
                              Text("\$${_shippingFees.toStringAsFixed(2)}"),
                              Text(
                                "\$${(cart.totalAmount + _shippingFees).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: MediaQuery.of(context).size.width - 10,
                    height: 50,
                    color: Theme.of(context).primaryColor,

                    onPressed: (cart.totalAmount <=0 || _isLoading) ? null : () async {
                      setState(() {
                        _isLoading=true;
                      });
                      await Provider.of<Orders>(context, listen: false).addProducts(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                      cart.clear();
                    },
                    child: _isLoading ? CircularProgressIndicator() : Text(
                      "ORDER NOW",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
