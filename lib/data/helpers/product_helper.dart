import 'package:sqflite/sqflite.dart';
import 'package:venda_produto/data/models/product_model.dart';

import '../database.dart';

class ProductHelper {

  static final ProductHelper _instance = ProductHelper.internal();

  factory ProductHelper() => _instance;

  ProductHelper.internal();

  Database _database;

  Future<Database> get _db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<ProductModel> save(ProductModel product) async{
    Database db = await _db;
    product.id = await db.insert(productTable, product.toMap());
    return product;
  }

  Future<List<ProductModel>> saveAll(List<ProductModel> products) async{
    Database db = await _db;
    List<ProductModel> productsWithId = new List();
    products.forEach((product) async {
      product.id = await db.insert(productTable, product.toMap());
      productsWithId.add(product);
    });
    return productsWithId;
  }

  Future<ProductModel> get(int id) async {
    Database db = await _db;
    List<Map> maps = await db.query(productTable,
        columns: [productCodeColumn, productDescriptionColumn, productPriceColumn, productCategoryColumn],
        where: "$productIdColumn = ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return ProductModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    Database db = await _db;
    return db.delete(productTable, where: "$productIdColumn = ?", whereArgs: [id]);
  }

  Future<int> update(ProductModel product) async {
    Database db = await _db;
    return await db.update(productTable,
        product.toMap(),
        where: "$productIdColumn = ?",
        whereArgs:[product.id]
    );
  }

  Future<List> getAll() async {
    Database db = await _db;
    List listMap = await db.rawQuery("SELECT * FROM $productTable");
    List<ProductModel> list = List();
    for(Map mV in listMap) {
      list.add(ProductModel.fromMap(mV));
    }
    return list;
  }

  Future<int> count() async {
    Database db = await _db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $productTable"));
  }

  Future close() async {
    Database db = await _db;
    db.close();
  }

}