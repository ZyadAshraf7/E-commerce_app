import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/orders.dart' show Orders;
import 'package:my_shop_app/widgets/app_drawer.dart';
import 'package:my_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  var _initValue = true;
  @override
  void didChangeDependencies() async {
    if(_initValue) {
      setState(() {
        _isLoading = true;
      });
    }
    await Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_){
      setState(() {
        _isLoading = false;
      });
    });
    _initValue = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      backgroundColor: Color(0xffF3F3FF),
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "My Orders",
        ),
        centerTitle: true,
        //backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) => OrderItem(orderData.orders[i])),
    );
  }
}
