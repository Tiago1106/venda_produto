import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:venda_produto/models/vendedor_moldels.dart';
import 'package:venda_produto/helpers/vendedor_helper.dart';
import 'list_produto.dart';
import 'register_vendedor.dart';
import 'package:venda_produto/ui/import_produto.dart';

class VendedorPage extends StatefulWidget {
  @override
  _VendedorPageState createState() => _VendedorPageState();
}

class _VendedorPageState extends State<VendedorPage> {

  VendedorHelper helper = VendedorHelper();

  List<Vendedor> vendedores = List();

  @override
  void initState() {
    super.initState();

    _getAllVendedores();
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
                  _showRegisterVendedor();
                },
              ),
              ListTile(
                leading: Icon(Icons.import_export),
                trailing: Icon(Icons.arrow_right),
                title: Text("Importar Produtos"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FilePickerDemo()));
                },
              ),
            ],
          ),
        )
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: vendedores.length,
        itemBuilder: (context, index) {
          return _vendedorCard(context, index);
        },
        ),
    );
  }

  Widget _vendedorCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                vendedores[index].nameVendedor ?? "",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text(
                vendedores[index].idVendedor ?? "",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => ListProduto()),
        );
      },
      onLongPress: (){
        _showRegisterVendedor(vendedor: vendedores[index]);
      },
    );
  }

  void _showRegisterVendedor({Vendedor vendedor}) async{
    final recVendedor = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterVendedor(vendedor: vendedor,))
    );
    if(recVendedor != null){
      if(vendedor != null){
        await helper.updateVendedor(recVendedor);
      } else{
        await helper.saveVendedor(recVendedor);
      }
      _getAllVendedores();
    }
  }

  void _getAllVendedores(){
    helper.getAllVendedor().then((list){
      setState(() {
        vendedores = list;
      });
    });
  }
}
