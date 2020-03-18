import 'package:flutter/material.dart';
import 'package:venda_produto/data/helpers/product_helper.dart';
import 'package:venda_produto/data/models/product_model.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {

  ProductHelper helper = ProductHelper();

  List<ProductModel> products = List();

  @override
  void initState() {
    super.initState();

    _getAllSeller();
  }

  void _getAllSeller(){
    helper.getAll().then((list){
      setState(() {
        products = list;
        products.forEach((product) => print(product.toString()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Porduto"),
        )
    );
  }
}
