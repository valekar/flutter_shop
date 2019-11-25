import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/Cart.provider.dart';
import 'package:shop/providers/orders.provider.dart';
import 'package:shop/screens/cart.screen.dart';
import 'package:shop/screens/orders.screen.dart';

import 'package:shop/screens/product.detail.screen.dart';
import 'package:shop/screens/products.overview.screen.dart';
import './providers/products.provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        //home: ProductsOverviewScreen(),
        routes: {
          "/": (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen()
        },
        //onUnknownRoute: (ctx) =>
      ),
    );
  }
}
