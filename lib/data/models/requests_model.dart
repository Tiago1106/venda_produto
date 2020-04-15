final String requestTable = "Request";
final String requestIdColumn = "Id";
final String requestIdSellerColumn = "Id Seller";
final String requestDateColumn = "Date";
final String requestNameClientColumn = "Name Client";

class RequestModel {
  int id;
  int idSeller;
  DateTime date;
  String nameClient;

  RequestModel ({
    this.id,
    this.idSeller,
    this.date,
    this.nameClient
  });

  RequestModel.fromMap(Map mapRequest){
    id = mapRequest[requestIdColumn];
    idSeller = mapRequest[requestIdSellerColumn];
    date = mapRequest[requestDateColumn];
    nameClient = mapRequest[requestNameClientColumn];
  }

  Map toMap (){
    Map<String, dynamic> mapRequest = {
      requestIdSellerColumn: idSeller,
      requestDateColumn: date,
      requestNameClientColumn: nameClient
    };
    if(id != null){
      mapRequest[requestIdColumn] = id;
    }
    return mapRequest;
  }

  @override
  String toString() {
    return "ID $id | ID SELLER: $idSeller | DATE: $date | NAME CLIENT: $nameClient ";
  }
}