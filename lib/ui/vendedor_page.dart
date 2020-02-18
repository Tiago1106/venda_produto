import 'package:flutter/material.dart';

class VendedorPage extends StatefulWidget {
  @override
  _VendedorPageState createState() => _VendedorPageState();
}

class _VendedorPageState extends State<VendedorPage> {

  Widget _vendedorCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.check),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        //itemCount: vendedor.length,
        itemBuilder: (context, index) {
          return _vendedorCard(context, index);
        },
        ),
    );
  }
}
