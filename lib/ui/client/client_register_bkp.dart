import 'package:flutter/material.dart';
import 'package:venda_produto/data/helpers/product_helper.dart';
import 'package:venda_produto/data/models/product_model.dart';

class ClientRegister extends StatefulWidget {
  
  final double priceFinal;
  final int sellerCode;
  final products;
  ClientRegister({Key key, @required
      this.priceFinal,
      this.sellerCode,
      this.products
      }
  ) : super(key: key);

  @override
  _ClientRegisterState createState() => _ClientRegisterState();
}

class _ClientRegisterState extends State<ClientRegister> {

  double valueDiscount;
  double valueFinal;

  @override
  void initState() {
    super.initState();
    _getAllProductSold();
  }

  ProductHelper helper = ProductHelper();

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

  Widget _productSoldList(){
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: productsSold.length,
      itemBuilder: (context, index) {
        return _productCard(context, index);
      },
    );
  }

  void _valueFinalSale(){
    valueFinal = widget.priceFinal - valueDiscount;
    _valueFinalController.text = valueFinal.toString();
    print(valueFinal);
    print(_valueFinalController);
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
                        Text(productsSold[index].qntProduct.toString() ?? "",
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
                        productsSold[index].description ?? "",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                      ),
                      Text(
                        productsSold[index].price.toString(),
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    _codeController.text = widget.sellerCode.toString();
    _valueTotalController.text = widget.priceFinal.toString();

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
            _valueFinalSale();
          }
      ),
        body: new Column(
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
                      },
                    ),
                ),
                new Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _valueFinalController,
                      decoration: InputDecoration(
                        labelText: "VALOR FINAL",
                        prefixIcon: Icon(Icons.monetization_on),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0))
                        ),
                      ),
                    ),
                ),
                new Expanded(
                    child: _productSoldList()
                ),
              ],
            ),
        );
  }
}


//NOME DO CLIENTE
//DATA VENDA
//CODE VENDEDOR
//VL TOTAL DOS PRODUTOS
//VL DESCONTO
//VALOR FINAL
//CANCELAR
