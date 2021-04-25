import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/cart.dart';
import 'package:my_shop_app/provider/orders.dart';
import 'package:my_shop_app/provider/product.dart';
import 'package:my_shop_app/provider/products.dart';
import 'package:my_shop_app/screens/cart_screen.dart';
import 'package:my_shop_app/screens/edit_product_screen.dart';
import 'package:my_shop_app/screens/favourite_screen.dart';
import 'package:my_shop_app/screens/home_screen.dart';
import 'package:my_shop_app/screens/login_screen.dart';
import 'package:my_shop_app/screens/orders_screen.dart';
import 'package:my_shop_app/screens/product_detail_screen.dart';
import 'package:my_shop_app/screens/signup_screen.dart';
import 'package:my_shop_app/screens/user_product_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Product(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Shop app',
          home: HomeScreen(),
          theme: ThemeData(
            primaryColor: Color(0xffF20850),
            accentColor: Color(0xffF20850),
            fontFamily: 'Roboto Medium',
          ),
          routes: {
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            Favorites.routeName: (ctx) => Favorites(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName:(ctx)=>OrdersScreen(),
            UserProductScreen.routeName:(ctx)=>UserProductScreen(),
            EditProductScreen.routeName:(ctx)=>EditProductScreen(),
          }),
    );
  }
}
