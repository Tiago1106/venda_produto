final String sellerTable = "Sellers";
final String sellerIdColumn = "Id";
final String sellerCodeColumn = "Code";
final String sellerNameColumn = "Name";

class SellerModel {

  int id;
  int code;
  String name;

  SellerModel();

  SellerModel.fromMap(Map mapSeller) {
    id = mapSeller[sellerIdColumn];
    code = mapSeller[sellerCodeColumn];
    name = mapSeller[sellerNameColumn];
  }

  Map toMap() {
    Map<String, dynamic> mapSeller = {
      sellerNameColumn: name,
      sellerCodeColumn: code
    };
    if(id != null){
      mapSeller[sellerIdColumn] = id;
    }
    return mapSeller;
  }

  @override
  String toString() {
    return "ID $id | CODE: $code | NAME: $name";
  }
}