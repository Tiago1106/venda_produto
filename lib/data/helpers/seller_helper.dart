import 'package:sqflite/sqflite.dart';
import 'package:venda_produto/data/models/seller_model.dart';

import '../database.dart';

class SellerHelper {

  static final SellerHelper _instance = SellerHelper.internal();

  factory SellerHelper() => _instance;

  SellerHelper.internal();

  Database _database;

  Future<Database> get _db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<SellerModel> save(SellerModel seller) async{
    Database db = await _db;
    seller.id = await db.insert(sellerTable, seller.toMap());
    return seller;
  }

  Future<SellerModel> get(int id) async {
    Database db = await _db;
    List<Map> maps = await db.query(sellerTable,
      columns: [sellerCodeColumn, sellerNameColumn],
        where: "$sellerIdColumn = ?",
        whereArgs: [id]);
      if(maps.length > 0){
        return SellerModel.fromMap(maps.first);
      } else {
        return null;
      }
  }

  Future<int> delete(int id) async {
    Database db = await _db;
    return db.delete(sellerTable, where: "$sellerIdColumn = ?", whereArgs: [id]);
  }

  Future<int> update(SellerModel seller) async {
    Database db = await _db;
    return await db.update(sellerTable,
      seller.toMap(),
      where: "$sellerIdColumn = ?",
      whereArgs:[seller.id]
    );
  }

  Future<List> getAll() async {
    Database db = await _db;
    List listMap = await db.rawQuery("SELECT * FROM $sellerTable");
    List<SellerModel> list = List();
    for(Map mV in listMap) {
      list.add(SellerModel.fromMap(mV));
    }
    return list;
  }

  Future<int> count() async {
    Database db = await _db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $sellerTable"));
  }

  Future close() async {
    Database db = await _db;
    db.close();
  }

}