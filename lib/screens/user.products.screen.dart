import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.provider.dart';
import 'package:shop/screens/edit.product.screen.dart';
import 'package:shop/widgets/app.drawer.dart';
import 'package:shop/widgets/user.product.item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "products-scren";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your products"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
            )
          ],
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) {
              return Column(
                children: <Widget>[
                  UserProductItem(
                    id: productsData.items[i].id,
                    imageUrl: productsData.items[i].imageUrl,
                    title: productsData.items[i].title,
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ));
  }
}
