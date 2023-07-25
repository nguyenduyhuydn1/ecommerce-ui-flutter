class User {
  final String id;
  final String fullname;
  final String email;
  final String password;
  final List<dynamic> orders;
  final List<dynamic> wishLists;
  final bool isAdmin;
  final bool hasShippingAddress;
  final String token;
  final String message;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.orders,
    required this.wishLists,
    required this.isAdmin,
    required this.hasShippingAddress,
    required this.token,
    required this.message,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
        wishLists: List<dynamic>.from(json["wishLists"].map((x) => x)),
        isAdmin: json["isAdmin"],
        hasShippingAddress: json["hasShippingAddress"],
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "email": email,
        "password": password,
        "orders": List<dynamic>.from(orders.map((x) => x)),
        "wishLists": List<dynamic>.from(wishLists.map((x) => x)),
        "isAdmin": isAdmin,
        "hasShippingAddress": hasShippingAddress,
        "token": token,
        "message": message,
      };
}
