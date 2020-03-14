import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:venda_produto/models/produto_models.dart';



void main() => runApp(new FilePickerDemo());

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => new _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;
  TextEditingController _controller = new TextEditingController();


  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
      try {
        if (_multiPick) {
          _path = null;
          _paths = await FilePicker.getMultiFilePath(type: _pickingType, fileExtension: _extension);
        } else {
          _paths = null;
          _path = await FilePicker.getFilePath(type: _pickingType, fileExtension: _extension);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName = _path != null ? _path.split('/').last : _paths != null ? _paths.keys.toString() : '...';
      });
    }
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
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new DropdownButton(
                          hint: new Text('Tipo Arquivo'),
                          value: _pickingType,
                          items: <DropdownMenuItem>[
                            new DropdownMenuItem(
                              child: new Text('FROM AUDIO'),
                              value: FileType.AUDIO,
                            ),
                            new DropdownMenuItem(
                              child: new Text('FROM IMAGE'),
                              value: FileType.IMAGE,
                            ),
                            new DropdownMenuItem(
                              child: new Text('FROM VIDEO'),
                              value: FileType.VIDEO,
                            ),
                            new DropdownMenuItem(
                              child: new Text('FROM ANY'),
                              value: FileType.ANY,
                            ),
                            new DropdownMenuItem(
                              child: new Text('CUSTOM FORMAT'),
                              value: FileType.CUSTOM,
                            ),
                          ],
                          onChanged: (value) => setState(() {
                            _pickingType = value;
                            if (_pickingType != FileType.CUSTOM) {
                              _controller.text = _extension = '';
                            }
                          })),
                    ),
                    new ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 100.0),
                      child: _pickingType == FileType.CUSTOM
                          ? new TextFormField(
                        maxLength: 15,
                        autovalidate: true,
                        controller: _controller,
                        decoration: InputDecoration(labelText: 'File extension'),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          RegExp reg = new RegExp(r'[^a-zA-Z0-9]');
                          if (reg.hasMatch(value)) {
                            _hasValidMime = false;
                            return 'Invalid format';
                          }
                          _hasValidMime = true;
                        },
                      )
                          : new Container(),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: new RaisedButton(
                        onPressed: () => _openFileExplorer(),
                        child: new Text("Importar arquivo"),
                      ),
                    ),
                    new Builder(
                      builder: (BuildContext context) => _path != null || _paths != null
                          ? new Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              height: MediaQuery.of(context).size.height * 0.50,
                                child: new Scrollbar(
                                  child: new ListView.separated(
                                    itemCount: _paths != null && _paths.isNotEmpty ? _paths.length : 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      final bool isMultiPath = _paths != null && _paths.isNotEmpty;
                                      String name = 'File $index: ' + (isMultiPath ? _paths.keys.toList()[index] : _fileName ?? '...');
                                      final path = isMultiPath ? _paths.values.toList()[index].toString() : _path;
                                      final pathFinal = _path;

                                      print(pathFinal);



                                      return new ListTile(
                                        title: new Text(
                                          name,
                                        ),
                                        subtitle: new Text(path),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) => new Divider(),
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
            onPressed: (){
              carregaProduto();
            }),
      ),
    );
  }
  Future<String> _carregaProdutoJson() async {
    return await rootBundle.loadString(_path);
  }
  Future carregaProduto() async {
    String jsonString = await _carregaProdutoJson();
    final jsonResponse = json.decode(jsonString);

    print(jsonString);
    print(jsonResponse);

    Product produto = new Product.fromJson(jsonResponse);

    print(produto.name);
  }

}
