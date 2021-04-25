import 'package:flutter/material.dart';
import 'package:my_shop_app/screens/home_screen.dart';
import 'package:my_shop_app/screens/orders_screen.dart';
import 'package:my_shop_app/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Shopify"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          Divider(),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            child: ListTile(
              leading: Icon(Icons.shop),
              title: Text("Shop"),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
            child: ListTile(
              leading: Icon(Icons.payment),
              title: Text("Orders"),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap:(){
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            } ,
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Products"),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
