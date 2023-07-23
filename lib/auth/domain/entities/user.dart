class User {
  final String fullname;
  final String email;
  final String password;
  final List<dynamic> orders;
  final List<dynamic> wishLists;
  final bool isAdmin;
  final bool hasShippingAddress;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  User({
    required this.fullname,
    required this.email,
    required this.password,
    required this.orders,
    required this.wishLists,
    required this.isAdmin,
    required this.hasShippingAddress,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
        wishLists: List<dynamic>.from(json["wishLists"].map((x) => x)),
        isAdmin: json["isAdmin"],
        hasShippingAddress: json["hasShippingAddress"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "password": password,
        "orders": List<dynamic>.from(orders.map((x) => x)),
        "wishLists": List<dynamic>.from(wishLists.map((x) => x)),
        "isAdmin": isAdmin,
        "hasShippingAddress": hasShippingAddress,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
