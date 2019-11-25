import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/cart.screen.dart';
import 'package:shop/widgets/app.drawer.dart';
import '../widgets/products.grid.dart';
import '../providers/products.provider.dart';
import '../widgets/badge.dart';
import '../providers/Cart.provider.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFave = false;

  @override
  Widget build(BuildContext context) {
    // final productsCOntainer =
    //     Provider.of<ProductsProvider>(context, listen: false);

    //final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Overview"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onSelected: (FilterOptions selected) {
              setState(() {
                if (FilterOptions.Favorites == selected) {
                  //productsCOntainer.showFavOnly();
                  _showOnlyFave = true;
                } else {
                  //productsCOntainer.showAll();
                  _showOnlyFave = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Ony Fav'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: ch,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFave),
    );
  }
}

class _ {}
