import 'package:flutter/material.dart';
import 'package:venda_produto/data/helpers/product_helper.dart';
import 'package:venda_produto/data/models/product_model.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {

  String searchedWord = "";
  String filter;

  ProductHelper helper = ProductHelper();

  List<ProductModel> products = List();
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

  void _getAllSeller(){
    helper.getAll().then((list){
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
        print(searchedWord);
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
          padding: EdgeInsets.all(10.0),
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

                print(searchedWord);
              },
              icon: Icon(Icons.camera),

            )
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            print(searchedWord);
            _searchList(searchedWord);
          },
          child: Icon(Icons.search),
          backgroundColor: Colors.red,
        ),

        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
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
                      },
                    ),
                  ),
              new Expanded(
                  child: _searchedWord()
              )
            ],
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
