import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:venda_produto/data/helpers/product_helper.dart';
import 'package:venda_produto/data/helpers/request_helper.dart';
import 'package:venda_produto/data/models/product_model.dart';
import 'package:venda_produto/data/models/requests_model.dart';

class ClientRegister extends StatefulWidget {

  final double priceFinal;
  final int sellerCode;
  final products;
  ClientRegister({Key key, @required this.priceFinal, this.sellerCode, this.products}) : super(key: key);

  @override
  _ClientRegisterState createState() => _ClientRegisterState();
}

class _ClientRegisterState extends State<ClientRegister> {

  double valueDiscount;
  double valueFinal;

  RequestModel _saveSale;


  @override
  void initState() {
    super.initState();
    _getAllProductSold();
  }

  ProductHelper helperProduct = ProductHelper();
  RequestHelper helperRequest = RequestHelper();

  List<ProductModel> productsSold = List();
  final TextEditingController _nameClientController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _valueTotalController = TextEditingController();
  final TextEditingController _valueDiscountController = TextEditingController();
  final TextEditingController _valueFinalController = TextEditingController();

  void _getAllProductSold() {
    widget.products.forEach((product) => {
      if (product.qntProduct > 0) productsSold.add(product)
    });
  }

  void _valueFinalSale(){
    valueFinal = widget.priceFinal - valueDiscount;
    _valueFinalController.text = valueFinal.toString();
    print(valueFinal);
    print(_valueFinalController);
  }

  @override
  Widget build(BuildContext context) {

    _codeController.text = widget.sellerCode.toString();
    _valueTotalController.text = widget.priceFinal.toString();
    //_saveSale.listProduct = productsSold;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Fechamento"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check_box),
          backgroundColor: Colors.red,
          onPressed: (){
            _notificationSave();
            helperRequest.save(_saveSale);
          }
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _nameClientController,
                decoration: InputDecoration(
                  labelText: "NOME DO CLIENTE",
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                ),
                onChanged: ( text ) {
                  _saveSale.nameClient = text;
                }
              ),
            ),
            new Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "DATA DA VENDA",
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                ),
                onChanged: ( text ){
                  _saveSale.date = text;
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                enabled: false,
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: "CÓDIGO DO VENDEDOR",
                  prefixIcon: Icon(Icons.recent_actors),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                ),
                onChanged: ( text ){
                  _saveSale.idSeller = int.parse(text);
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                enabled: false,
                controller: _valueTotalController,
                decoration: InputDecoration(
                  labelText: "VALOR TOTAL DA VENDA",
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                ),
                onChanged: ( text ){
                  _saveSale.valorInicial = double.parse(text);
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _valueDiscountController,
                decoration: InputDecoration(
                  labelText: "VALOR DO DESCONTO",
                  prefixIcon: Icon(Icons.money_off),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                ),
                onChanged: (text) {
                  valueDiscount = double.parse(text);
                  _valueFinalSale();
                  _saveSale.valorDesconto = double.parse(text);
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                enabled: false,
                controller: _valueFinalController,
                decoration: InputDecoration(
                  labelText: "VALOR FINAL",
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                ),
                onChanged: ( text ){
                  _saveSale.valorFinal = double.parse(text);
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  _notificationSave() {
    showDialog(context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Venda salva com sucesso"),
            content: Text("Deseja imprimir?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {},
                  child: Text("Sim")
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Não")
              )
            ],
          );
        }
    );
  }
}

