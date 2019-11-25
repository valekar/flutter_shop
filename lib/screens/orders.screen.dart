import 'package:flutter/material.dart';
import 'package:shop/providers/orders.provider.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/app.drawer.dart';
import 'package:shop/widgets/order.item.dart' as prefix0;

class OrdersScreen extends StatelessWidget {
  static const routeName = "orders";

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.getOrders.length,
        itemBuilder: (ctx, i) => prefix0.OrderItem(ordersData.getOrders[i]),
      ),
    );
  }
}
