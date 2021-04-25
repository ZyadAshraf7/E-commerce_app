import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/cart.dart';
import 'package:my_shop_app/provider/product.dart';
import 'package:my_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Image.network(product.imagePath, width: 150, height: 150),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            product.title,
            style: TextStyle(fontSize: 16, fontFamily: 'Roboto Bold'),
          ),
          Text("\$${product.price}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Product>(
                builder: (ctx, product, _) => IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color:
                        product.isFavorite ? Color(0xffF20850) : Colors.black54,
                  ),
                  onPressed: () {
                    product.toggleFavorite();
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black54,
                ),
                onPressed: () {
                  cart.addToCart(product.id, product.price, product.title,
                      product.imagePath);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(
                        "Added item to cart",
                      ),
                      action: SnackBarAction(
                        onPressed: () {
                          cart.undoSingleItem(product.id);
                        },
                        label: "UNDO",
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );

    // return GridTile(
    //   child: GestureDetector(
    //     onTap: (){
    //       Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: id);
    //     },
    //     child: Image.asset(
    //       imagePath,
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   footer: GridTileBar(
    //     title: Text(title,textAlign: TextAlign.center,),
    //     backgroundColor: Colors.black54,
    //     leading: IconButton(
    //       icon: Icon(Icons.favorite),
    //       onPressed: () {},
    //     ),
    //     trailing: IconButton(
    //       icon: Icon(Icons.shopping_cart),
    //       onPressed: () {},
    //     ),
    //   ),
    // );
  }
}
