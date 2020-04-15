final String requestItemsTable = "Request Items";
final String requestIdColumn = "Id";
final String requestIdRequstColumn = "Id Request";
final String requestIdProductColumn = "Id Product";
final String requestPriceProductColumn = "Price Product";
final String requestQuantityColumn = "Quantity";
final String requestPercentageColumn = "Percentage";

class RequestModel {
  int id;
  int idRequest;
  int idProduct;
  double priceProduct;
  int quantity;
  double percentage;

  RequestModel ({
    this.id,
    this.idRequest,
    this.idProduct,
    this.priceProduct,
    this.quantity,
    this.percentage
  });

  RequestModel.fromMap(Map mapRequest){
    id = mapRequest[requestIdColumn];
    idRequest = mapRequest[requestIdRequstColumn];
    idProduct = mapRequest[requestIdProductColumn];
    priceProduct = mapRequest[requestPriceProductColumn];
    quantity = mapRequest[requestQuantityColumn];
    percentage = mapRequest[requestPercentageColumn];
  }

  Map toMap (){
    Map<String, dynamic> mapRequestItems = {
      requestIdRequstColumn: idRequest,
      requestIdProductColumn: idProduct,
      requestPriceProductColumn: priceProduct,
      requestQuantityColumn: quantity,
      requestPercentageColumn: percentage
    };
    if(id != null){
      mapRequestItems[requestIdColumn] = id;
    }
    return mapRequestItems;
  }

  @override
  String toString() {
    return "ID $id | ID REQUEST: $idRequest | ID PRODUCT: $idProduct | PRICE PRODUCT: $priceProduct | QUANTITY: $quantity | PERCENTAGE: $percentage ";
  }
  
}