final String requestTable = "Request";
final String requestIdColumn = "Id";
final String requestNameClientColumn = "Name Client";
final String requestDateColumn = "Date";
final String requestIdSellerColumn = "Id Seller";
final String requestValorInicialColumn = "Valor Inicial";
final String requestValorDescontoColumn = "Valor Desconto";
final String requestValorFinalColumn = "Valor Final";
//final String requestListProduct = "Lista de Produtos";

class RequestModel {
  int id;
  String nameClient;
  String date;
  int idSeller;
  double valorInicial;
  double valorDesconto;
  double valorFinal;
  //List listProduct;

  RequestModel ({
    this.id,
    this.nameClient,
    this.date,
    this.idSeller,
    this.valorInicial,
    this.valorDesconto,
    this.valorFinal,
  });

  RequestModel.fromMap(Map mapRequest){
    id = mapRequest[requestIdColumn];
    nameClient = mapRequest[requestNameClientColumn];
    date = mapRequest[requestDateColumn];
    idSeller = mapRequest[requestIdSellerColumn];
    valorInicial = mapRequest[requestValorInicialColumn];
    valorDesconto = mapRequest[requestValorDescontoColumn];
    valorFinal = mapRequest[requestValorFinalColumn];
    //listProduct = mapRequest[requestListProduct];
  }

  Map toMap (){
    Map<String, dynamic> mapRequest = {
      requestNameClientColumn: nameClient,
      requestDateColumn: date,
      requestIdSellerColumn: idSeller,
      requestValorInicialColumn: valorInicial,
      requestValorDescontoColumn: valorDesconto,
      requestValorFinalColumn: valorFinal,
      //requestListProduct:  listProduct,
    };
    if(id != null){
      mapRequest[requestIdColumn] = id;
    }
    return mapRequest;
  }

  @override
  String toString() {
    return "ID $id | NAME CLIENT: $nameClient | DATE: $date | ID SELLER: $idSeller | VALOR DA COMPRA: $valorInicial | "
        "VALOR DO DESCONTO: $valorDesconto | VALOR TOTAL: $valorFinal | ";
        //"PRODUTOS: $listProduct";
  }
}