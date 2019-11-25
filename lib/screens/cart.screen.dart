import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.provider.dart';
//import 'package:shop/widgets/cart.item.dart' as prefix0;
import '../providers/Cart.provider.dart';
import '../widgets/cart.item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "cart-screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your cart"),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    // SizedBox(width: 10),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      child: Text(
                        "Order now",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.cartItems.values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, i) {
                  return CartItemWidget(
                      id: cart.cartItems.values.toList()[i].id,
                      productId: cart.cartItems.keys.toList()[i],
                      quantity: cart.cartItems.values.toList()[i].quantity,
                      price: cart.cartItems.values.toList()[i].price,
                      title: cart.cartItems.values.toList()[i].title);
                },
              ),
            )
          ],
        ));
  }
}
