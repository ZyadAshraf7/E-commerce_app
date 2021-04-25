import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/cart.dart';
import 'package:my_shop_app/provider/products.dart';
import 'package:my_shop_app/widgets/badge.dart';
import 'package:my_shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  static const routeName = "/favorite-screen";

  @override
  Widget build(BuildContext context) {
    final favoriteProducts =Provider.of<Products>(context, listen: false).favoriteOnly;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: TextStyle(
            fontFamily: 'Roboto Bold',
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (ctx, cart, _) => Badge(
              value: cart.itemCount.toString(),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xffF3F3FF),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Text(
                'No Favorites Yet',
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto Bold'),
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 10),
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: favoriteProducts[i],
                  child: ProductItem(),
                ),
                itemCount: favoriteProducts.length,
              ),
            ),
    );
  }
}
