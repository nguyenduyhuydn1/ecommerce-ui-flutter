import 'package:ecommerce_ui_flutter/products/domain/entities/product.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        brand: json["brand"],
        category: json["category"],
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        colors: List<String>.from(json["colors"].map((x) => x)),
        user: json["user"],
        images: List<String>.from(json["images"].map((x) => x)),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        price: json["price"],
        totalQty: json["totalQty"],
        totalSold: json["totalSold"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        totalReviews: json["totalReviews"],
        averageRating: json["averageRating"],
        productId: json["id"],
        qty: json['qty'] ?? 0,
      );
}
