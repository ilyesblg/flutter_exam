class Coin {
  String? id;
  String? name;
  String? image;
  double? unitPrice;
  String? code;
  String? description;
  Coin(
      {this.id,
      this.name,
      this.image,
      this.unitPrice,
      this.code,
      this.description});

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        id: json['_id'],
        name: json['name'],
        image: json['image'],
        unitPrice: json['unitPrice'].toDouble(),
        code: json['code'],
        description: json['description']);
  }

  @override
  String toString() {
    return 'Coin{id: $id,name: $name, image: $image, unitPrice: $unitPrice, code: $code, description: $description}';
  }
}
