class ProdutoApi{
  int id;
  String name;
  String valor;

  ProdutoApi(int id, String name, String valor) {
    this.id = id;
    this.name = name;
    this.valor = valor;
  }
  ProdutoApi.fromJson(Map mapProduto)
      : id = mapProduto['id'],
        name = mapProduto['name'],
        valor = mapProduto['valor'];
  Map toJson() {
    return {'Id': id, 'Name': name, 'Valor': valor};
  }
}