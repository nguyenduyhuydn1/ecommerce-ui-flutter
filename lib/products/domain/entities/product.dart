class ProductResponse {
  final String status;
  final int total;
  final int results;
  final dynamic pagination;
  final String message;
  final List<Product> products;

  ProductResponse({
    required this.status,
    required this.total,
    required this.results,
    required this.pagination,
    required this.message,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        status: json["status"],
        total: json["total"],
        results: json["results"],
        pagination: json["pagination"],
        message: json["message"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total": total,
        "results": results,
        "pagination": pagination,
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  final String id;
  final String name;
  final String description;
  final String brand;
  final String category;
  final List<dynamic> sizes;
  final List<String> colors;
  final String user;
  final List<String> images;
  final List<dynamic> reviews;
  final int price;
  final int totalQty;
  final int totalSold;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final int totalReviews;
  final int averageRating;
  final String productId;
  late int? qty;

  Product({
    this.qty,
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.user,
    required this.images,
    required this.reviews,
    required this.price,
    required this.totalQty,
    required this.totalSold,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.totalReviews,
    required this.averageRating,
    required this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "brand": brand,
        "category": category,
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "user": user,
        "images": List<dynamic>.from(images.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "price": price,
        "totalQty": totalQty,
        "totalSold": totalSold,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "totalReviews": totalReviews,
        "averageRating": averageRating,
        "id": productId,
        "qty": qty ?? 0,
      };
}
