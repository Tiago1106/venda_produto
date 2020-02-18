final String idVendedorColumn = "idVendedorColumn";
final String nameVendedorColumn = "nameVendedorColumn";

class Vendedor {

  int idVendedor;
  String nameVendedor;

  Vendedor.fromMap(Map mapVendedor) {
    idVendedor = mapVendedor[idVendedorColumn];
    nameVendedor = mapVendedor[nameVendedorColumn];
  }

  Map toMapVendedor() {
    Map<String, dynamic> mapVendedor = {
      idVendedorColumn: idVendedor,
      nameVendedorColumn: nameVendedor
    };
  }

  @override
  String toStringVendedor() {
    return "ID VENDEDOR: $idVendedor | NOME VENDEDOR: $nameVendedor";
  }
}