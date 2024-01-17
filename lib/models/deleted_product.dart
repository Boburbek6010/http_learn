import 'dart:convert';

DeletedProduct deletedProductFromJson(String str) => DeletedProduct.fromJson(json.decode(str));

String deletedProductToJson(DeletedProduct data) => json.encode(data.toJson());

class DeletedProduct {
  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final bool isDeleted;
  final DateTime deletedOn;

  DeletedProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.isDeleted,
    required this.deletedOn,
  });

  factory DeletedProduct.fromJson(Map<String, dynamic> json) => DeletedProduct(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    brand: json["brand"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    images: List<String>.from(json["images"].map((x) => x)),
    isDeleted: json["isDeleted"],
    deletedOn: DateTime.parse(json["deletedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
    "images": List<dynamic>.from(images.map((x) => x)),
    "isDeleted": isDeleted,
    "deletedOn": deletedOn.toIso8601String(),
  };
}
