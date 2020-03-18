final String productTable = "Products";
final String productIdColumn = "Id";
final String productCodeColumn = "Code";
final String productDescriptionColumn = "Description";
final String productPriceColumn = "Price";
final String productCategoryColumn = "Category";

class ProductModel {

  int id;
  int code;
  String description;
  double price;
  String category;

  ProductModel({
    this.id,
    this.code,
    this.description,
    this.price,
    this.category
  });

  ProductModel.fromMap(Map mapSeller) {
    id = mapSeller[productIdColumn];
    code = mapSeller[productCodeColumn];
    description = mapSeller[productDescriptionColumn];
    price = mapSeller[productPriceColumn];
    category = mapSeller[productCategoryColumn];
  }

  Map toMap() {
    Map<String, dynamic> mapSeller = {
      productCodeColumn: code,
      productDescriptionColumn: description,
      productPriceColumn: price,
      productCategoryColumn: category
    };
    if(id != null){
      mapSeller[productIdColumn] = id;
    }
    return mapSeller;
  }

  factory ProductModel.fromJson(dynamic jsonObject) {
    return ProductModel(
        code: jsonObject['CodProduto'],
        description: jsonObject['Descricao'],
        price: jsonObject['VlProduto'],
        category: jsonObject['Categoria']);
  }

  static List<ProductModel> fromJsonArray(List<dynamic> jsonArray) {
    List<ProductModel> products = new List();

    jsonArray.forEach((jsonObject) =>
        products.add(ProductModel.fromJson(jsonObject))
    );

    return products;
  }

  @override
  String toString() {
    return "ID $id | CODE: $code | DESCRIPTION: $description | PRICE: $price | CATEGORY: $category";
  }
}
