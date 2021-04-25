import 'package:flutter/material.dart';
import 'package:my_shop_app/provider/products.dart';
import 'package:my_shop_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imagePath;

  UserProductItem({this.id,this.title, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        leading: Container(
          // padding: EdgeInsets.all(10),
          height: 75,
          width: 75,
          child: Image.network(imagePath),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
                },
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Provider.of<Products>(context,listen: false).removeProduct(id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
