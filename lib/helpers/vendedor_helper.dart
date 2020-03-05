import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:venda_produto/models/vendedor_moldels.dart';

class VendedorHelper {
  static final VendedorHelper _instance = VendedorHelper.internal();

  factory VendedorHelper() => _instance;

  VendedorHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "vendedor.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $vendedorTable($idAutoColumn INTEGER PRIMARY KEY, $idVendedorColumn TEXT, $nameVendedorColumn TEXT)"
      );
    });
  }

  Future<Vendedor> saveVendedor(Vendedor vendedor) async{
    Database dbVendedor = await db;
    vendedor.idAuto = await dbVendedor.insert(vendedorTable, vendedor.toMapVendedor());
    return vendedor;
  }

  Future<Vendedor> getVendedor(int idAuto) async {
    Database dbVendedor = await db;
    List<Map> mapsVendedor = await dbVendedor.query(vendedorTable,
      columns: [idVendedorColumn, nameVendedorColumn],
        where: "$idAutoColumn = ?",
        whereArgs: [idAuto]);
      if(mapsVendedor.length > 0){
        return Vendedor.fromMap(mapsVendedor.first);
      } else {
        return null;
      }
  }

  Future<int> deleteVendedor(int idAuto) async {
    Database dbVendedor = await db;
    return dbVendedor.delete(vendedorTable, where: "$idAutoColumn = ?", whereArgs: [idAuto]);
  }

  Future<int> updateVendedor(Vendedor vendedor) async {
    Database dbVendedor = await db;
    return await dbVendedor.update(vendedorTable,
      vendedor.toMapVendedor(),
      where: "$idAutoColumn = ?",
      whereArgs:[vendedor.idAuto]
    );
  }

  Future<List> getAllVendedor() async {
    Database dbVendedor = await db;
    List listMapVendedor = await dbVendedor.rawQuery("SELECT * FROM $vendedorTable");
    List<Vendedor> listVendedor = List();
    for(Map mV in listMapVendedor) {
      listVendedor.add(Vendedor.fromMap(mV));
    }
    return listVendedor;
  }

  Future<int> getNumber() async {
    Database dbVendedor = await db;
    return Sqflite.firstIntValue(await dbVendedor.rawQuery("SELECT COUNT(*) FROM $vendedorTable"));
  }

  Future close() async {
    Database dbVendedor = await db;
    dbVendedor.close();
  }

}