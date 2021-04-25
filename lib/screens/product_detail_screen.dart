import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/cart.dart';
import 'package:my_shop_app/provider/product.dart';
import 'package:my_shop_app/provider/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product detail screen';
  final String title;

  ProductDetailScreen({this.title});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProducts =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context,listen:false );
    return Scaffold(
      backgroundColor: Color(0xffF3F3FF),
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              //alignment: Alignment.center,
              height: 170,
              width: 170,
              child: Image.network(loadedProducts.imagePath),
            ),
          ),
          Text(
            "${loadedProducts.title}",
            style: TextStyle(fontFamily: "Roboto Bold", fontSize: 18),
          ),
          Text(
            "\$${loadedProducts.price}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Colors",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6, left: 2),
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: Color(0xff402373),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: Color(0xff2AC6EE),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: Color(0xffE00F83),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Details",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("${loadedProducts.description}"),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        padding: EdgeInsets.all(15),
                        onPressed: () {
                          cart.addToCart(loadedProducts.id, loadedProducts.price, loadedProducts.title,loadedProducts.imagePath);
                        },
                        child: Text("Add To Cart"),
                        color: Color(0xfff3f3f3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(15),
                        onPressed: () {
                         loadedProducts.toggleFavorite();
                        },
                        child: Text("Add To Favorites",style: TextStyle(color: Colors.white),),
                        color: Color(0xffF20050),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
