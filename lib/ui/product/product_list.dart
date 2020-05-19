import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:venda_produto/data/helpers/product_helper.dart';
import 'package:venda_produto/data/models/product_model.dart';
import 'package:venda_produto/data/models/seller_model.dart';
import 'package:venda_produto/ui/client/client_register.dart';

class ListProduct extends StatefulWidget {

  final SellerModel seller;

  ListProduct({Key key, this.seller}): super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {

  String searchedWord = "";
  String filter;
  int qnt;
  double priceFinal = 0;


  ProductHelper helper = ProductHelper();

  List<ProductModel> products = List();
  List<ProductModel> productsSold = List();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllSeller();
  }

  @override
  void setState(fn) {
    super.setState(fn);
    filter = _searchController.text;
  }

  void _getAllSeller() {
    helper.getAll().then((list) {
      setState(() {
        products = list;
        products.forEach((product) => print(product.toString()));
      });
    });
  }

  void _searchList(searchedWord){
    helper.searchList(searchedWord).then((list){
      setState(() {
        products = list;
        products.forEach((product) => print(product.toString()));
      });
    });
  }

  Widget _searchedWord(){
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) {
          return _productCard(context, index);
      },
    );
  }

  Widget _productCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(products[index].qntProduct.toString() ?? "",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      Text(
                        products[index].description ?? "",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                      ),
                      Text(
                        products[index].price.toString(),
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        products[index].code.toString(),
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(2.5),
                    child: FlatButton(
                      child: Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      color: Colors.red,
                      onPressed: (){
                        setState(() {
                          products[index].qntProduct--;
                        });
                        priceFinal -= products[index].qntProduct * products[index].price;
                        priceFinal =  (double.parse(priceFinal.toStringAsFixed(2)));
                      },
                    ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(2.5),
                  child: FlatButton(
                    child: Text(
                      "+",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    color: Colors.red,
                    onPressed: (){
                      setState(() {
                        products[index].qntProduct++;
                      });
                      priceFinal += products[index].qntProduct * products[index].price;
                      priceFinal =  (double.parse(priceFinal.toStringAsFixed(2)));
                    },
                  ),
                ),
              ),
            ],
          )
        ),
      ),
      onTap: (){

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Porduto"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              onPressed: (){
                print(widget.seller);
                print(searchedWord);
              },
              icon: Icon(Icons.camera),
            )
          ],
        ),
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: "Pesquisar Produto",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0))
                          ),
                        ),
                        onChanged: (context){
                          searchedWord = context;
                          _searchList(searchedWord);
                        },
                    ),
                  ),
              new Expanded(
                  child: _searchedWord()
              )
            ],
        ),
        floatingActionButton: FloatingActionButton(
            heroTag: "Route ProductImport",
            child: Icon(Icons.arrow_forward),
              backgroundColor: Colors.red,
            onPressed: (){
              print(priceFinal);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClientRegister(
                    priceFinal: priceFinal,
                    sellerCode: widget.seller.code,
                    products: products,
                  )));
            }
        ),
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
