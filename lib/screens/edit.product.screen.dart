import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.provider.dart';
import 'package:shop/providers/products.provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "Edit-screen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFOcusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Product _edittedProduct =
      Product(id: null, price: 0, title: '', description: '', imageUrl: '');

  var _isInit = true;
  var _initValues = {
    'title': "",
    "description": "",
    "price": "",
    "imageUrl": "",
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _edittedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          "title": _edittedProduct.title,
          "price": _edittedProduct.price.toString(),
          "description": _edittedProduct.description,
          //"imageUrl": _edittedProduct.imageUrl,
          "imageUrl": ""
        };
      }
      _imageUrlController.text = _edittedProduct.imageUrl;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _priceFOcusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    print(isValid);
    if (isValid) {
      _form.currentState.save();
      final productsData =
          Provider.of<ProductsProvider>(context, listen: false);
      if (_edittedProduct.id != null) {
        productsData.updateProduct(_edittedProduct.id, _edittedProduct);
      } else {
        productsData.addProduct(_edittedProduct);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues["title"],
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFOcusNode);
                },
                onSaved: (val) {
                  _edittedProduct = Product(
                    id: _edittedProduct.id,
                    title: val,
                    price: _edittedProduct.price,
                    description: _edittedProduct.description,
                    imageUrl: _edittedProduct.imageUrl,
                    isFavorite: _edittedProduct.isFavorite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues["price"],
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFOcusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter something";
                  }
                  return null;
                },
                onSaved: (val) {
                  _edittedProduct = Product(
                    id: _edittedProduct.id,
                    title: _edittedProduct.toString(),
                    price: double.parse(val),
                    description: _edittedProduct.description,
                    imageUrl: _edittedProduct.imageUrl,
                    isFavorite: _edittedProduct.isFavorite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues["description"],
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descFocusNode,
                onSaved: (val) {
                  _edittedProduct = Product(
                    id: _edittedProduct.id,
                    title: _edittedProduct.toString(),
                    price: _edittedProduct.price,
                    description: val,
                    imageUrl: _edittedProduct.imageUrl,
                    isFavorite: _edittedProduct.isFavorite,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text("Preview Image")
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (val) {
                        _saveForm();
                      },
                      onSaved: (val) {
                        _edittedProduct = Product(
                          id: _edittedProduct.id,
                          title: _edittedProduct.toString(),
                          price: _edittedProduct.price,
                          description: _edittedProduct.description,
                          imageUrl: val,
                          isFavorite: _edittedProduct.isFavorite,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
