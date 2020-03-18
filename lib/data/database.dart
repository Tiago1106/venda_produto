import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:venda_produto/data/models/product_model.dart';
import 'package:venda_produto/data/models/seller_model.dart';

Future<Database> initDb() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, "productSales.db");

  return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
    await db.execute(
        "CREATE TABLE $sellerTable($sellerIdColumn INTEGER PRIMARY KEY, $sellerCodeColumn INTEGER NOT NULL UNIQUE, $sellerNameColumn TEXT)"
    );

    await db.execute(
        "CREATE TABLE $productTable($productIdColumn INTEGER PRIMARY KEY, $productCodeColumn INTEGER NOT NULL UNIQUE, $productDescriptionColumn TEXT, $productPriceColumn REAL, $productCategoryColumn TEXT)"
    );
  });
}