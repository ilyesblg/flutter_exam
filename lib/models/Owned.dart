class Owned {
  int? quantity;
  String? image;
  String? code;
  Owned({
    this.quantity,
    this.image,
    this.code,
  });

  factory Owned.fromJson(Map<String, dynamic> json) {
    return Owned(
        quantity: json['quantity'],
        code: json['currency']['code'],
        image: json['currency']['image']);
  }

  @override
  String toString() {
    return 'Owned{quantity: $quantity,code: $code, image: $image,}';
  }
}
