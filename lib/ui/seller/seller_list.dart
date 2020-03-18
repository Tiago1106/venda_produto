import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:venda_produto/data/models/seller_model.dart';
import 'package:venda_produto/data/helpers/seller_helper.dart';
import '../product/product_list.dart';
import 'seller_register.dart';
import 'package:venda_produto/ui/product/product_import.dart';

class SellerList extends StatefulWidget {
  @override
  _SellerListState createState() => _SellerListState();
}

class _SellerListState extends State<SellerList> {

  SellerHelper helper = SellerHelper();

  List<SellerModel> sellers = List();

  @override
  void initState() {
    super.initState();

    _getAllSeller();
  }

  void _getAllSeller(){
    helper.getAll().then((list){
      setState(() {
        sellers = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venda de Produto"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(255, 0, 0, 0.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                trailing: Icon(Icons.arrow_right),
                title: Text("Adicionar Vendedor"),
                onTap: (){
                  _showRegisterSeller();
                },
              ),
              ListTile(
                leading: Icon(Icons.import_export),
                trailing: Icon(Icons.arrow_right),
                title: Text("Importar Produtos"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductImport()));
                },
              ),
            ],
          ),
        )
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: sellers.length,
        itemBuilder: (context, index) {
          return _sellerCard(context, index);
        },
        ),
    );
  }

  Widget _sellerCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                sellers[index].name ?? "",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text(
                sellers[index].code.toString(),
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => ListProduct()),
        );
      },
      onLongPress: (){
        _showRegisterSeller(seller: sellers[index]);
      },
    );
  }

  void _showRegisterSeller({SellerModel seller}) async{
    final recSeller = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SellerRegister(seller: seller,))
    );
    if(recSeller != null){
      if(seller != null){
        await helper.update(recSeller);
      } else{
        await helper.save(recSeller);
      }
      _getAllSeller();
    }
  }
}
