import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:venda_produto/data/helpers/product_helper.dart';
import 'package:venda_produto/data/models/product_model.dart';

void main() => runApp(new ProductImport());

class ProductImport extends StatefulWidget {
  @override
  _ProductImportState createState() => new _ProductImportState();
}

class _ProductImportState extends State<ProductImport> {

  String _fileName;
  String _path;

  ProductHelper helper = ProductHelper();

  @override
  void initState() {
    super.initState();
  }

  void _openFileExplorer() async {
    try {
      _path = await FilePicker.getFilePath(
          type: FileType.custom, fileExtension: 'json');

      if (!mounted) return;

      setState(() {
        _fileName = _path.split('/').last;
      });
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  Future<String> _readFile() async {
    final file = new File(_path);
    return file.readAsString();
  }

  Future<List<ProductModel>> _loadProducts() async {
    String jsonString = await _readFile();
    final jsonResponse = json.decode(jsonString);

    final products = ProductModel.fromJsonArray(jsonResponse);
    products.forEach((product) => print(product.toString()));

    return products;
  }

  Future _saveProducts() async {
    final products = await _loadProducts();

    helper.saveAll(products);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Importar Produto'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: new Center(
            child: new Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: new SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: new RaisedButton(
                        onPressed: () => _openFileExplorer(),
                        child: new Text("Importar arquivo"),
                      ),
                    ),
                    new Builder(
                      builder: (BuildContext context) => _path != null
                          ? new Container(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: new Scrollbar(
                            child: new ListView.separated(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                final String name = 'File $index: ' + _fileName ?? '...';
                                final path = _path;
                                print(path);

                                return new ListTile(
                                  title: new Text(name),
                                  subtitle: new Text(path),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                              new Divider(),
                            )),
                      )
                          : new Container(),
                    ),
                  ],
                ),
              ),
            )),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.import_export),
            onPressed: () {
              _saveProducts();
            }),
      ),
    );
  }
}
