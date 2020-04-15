import 'package:flutter/material.dart';
import 'package:venda_produto/data/models/product_model.dart';
import 'package:venda_produto/data/models/seller_model.dart';

class ProductSale extends StatefulWidget {

  final ProductModel product;
  final SellerModel seller;

  ProductSale({Key key, this.seller, this.product}): super(key: key);

  @override
  _ProductSaleState createState() => _ProductSaleState();
}

class _ProductSaleState extends State<ProductSale> {

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("Produto"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                TextField(

                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                print(widget.seller.code);
                print(widget.product);
              }),
        ),
    );
  }

  Future<bool> _requestPop(){
    int varRequestPop;
    varRequestPop = 0;
    if(varRequestPop == 0){
      Navigator.pop(context);
      return Future.value(false);
    } else Navigator.pop(context);
    return Future.value(false);
  }
}
