class Product {
  String id;
  String name;
  String price;

  Product({
    this.id,
    this.name,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        id: parsedJson['id'],
        name: parsedJson['nome'],
        price: parsedJson['valor']);
  }

  static List<Product> fromJsonArray(Map<String, dynamic> parsedJson) {

  }
}
