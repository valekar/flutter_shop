import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.provider.dart';
import '../screens/product.detail.screen.dart';
import '../providers/Cart.provider.dart';

class ProductItem extends StatelessWidget {
  void _loadProductDetail(BuildContext context, String id) {
    Navigator.of(context)
        .pushNamed(ProductDetailScreen.routeName, arguments: {"id": id});
  }

  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<Product>(context);
    //_id = product.id;

    final cart = Provider.of<Cart>(context, listen: false);

    return Consumer<Product>(
      builder: (ctx, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            child: Image.network(product.imageUrl, fit: BoxFit.fill),
            onTap: () => _loadProductDetail(context, product.id),
          ),
          footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                product.toggleFavStatus();
              },
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
