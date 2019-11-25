import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/product.provider.dart";
import '../providers/products.provider.dart';
import './product.item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    final List<Product> loadedProducts =
        showFav ? productsProvider.favItems : productsProvider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          child: ProductItem(),
          value: loadedProducts[i],
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
