import 'package:sqflite/sqflite.dart';
import 'package:venda_produto/data/models/requests_model.dart';

import '../database.dart';

class RequestHelper {

  static final RequestHelper _instance = RequestHelper.internal();

  factory RequestHelper() => _instance;

  RequestHelper.internal();

  Database _database;

  Future<Database> get _db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<RequestModel> save(RequestModel request) async{
    Database db = await _db;
    request.id = await db.insert(requestTable, request.toMap());
    return request;
  }

  Future<RequestModel> get(int id) async {
    Database db = await _db;
    List<Map> maps = await db.query(requestTable,
        columns: [requestIdSellerColumn, requestDateColumn, requestNameClientColumn],
        where: "$requestIdColumn = ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return RequestModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    Database db = await _db;
    return db.delete(requestTable, where: "$requestIdColumn = ?", whereArgs: [id]);
  }

  Future<int> update(RequestModel request) async {
    Database db = await _db;
    return await db.update(requestTable,
        request.toMap(),
        where: "$requestIdColumn = ?",
        whereArgs:[request.id]
    );
  }

  Future<List> getAll() async {
    Database db = await _db;
    List listMap = await db.rawQuery("SELECT * FROM $requestTable");
    List<RequestModel> list = List();
    for(Map mV in listMap) {
      list.add(RequestModel.fromMap(mV));
    }
    return list;
  }

  Future<int> count() async {
    Database db = await _db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $requestTable"));
  }

  Future close() async {
    Database db = await _db;
    db.close();


  }

}