final String vendedorTable = "vendedorTable";
final String idVendedorColumn = "idVendedorColumn";
final String nameVendedorColumn = "nameVendedorColumn";
final String idAutoColumn = "idAutoColumn";

class Vendedor {

  int idAuto;
  String idVendedor;
  String nameVendedor;

  Vendedor();

  Vendedor.fromMap(Map mapVendedor) {
    idAuto = mapVendedor[idAutoColumn];
    idVendedor = mapVendedor[idVendedorColumn];
    nameVendedor = mapVendedor[nameVendedorColumn];
  }

  Map toMapVendedor() {
    Map<String, dynamic> mapVendedor = {
      nameVendedorColumn: nameVendedor,
      idVendedorColumn: idVendedor
    };
    if(idVendedor != null){
      mapVendedor[idAutoColumn] = idAuto;
    }
    return mapVendedor;
  }

  @override
  String toString() {
    return "ID AUTO $idAuto | ID VENDEDOR: $idVendedor | NOME VENDEDOR: $nameVendedor";
  }
}