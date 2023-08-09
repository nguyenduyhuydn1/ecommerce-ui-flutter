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
  final ShippingAddress shippingAddress;

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
    required this.shippingAddress,
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
        shippingAddress: ShippingAddress.fromJson(json["shippingAddress"]),
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
        "shippingAddress": shippingAddress.toJson(),
      };
}

class ShippingAddress {
  final String fullName;
  final String address;
  final String city;
  final String postalCode;
  final String phone;
  final String country;

  ShippingAddress({
    required this.fullName,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.phone,
    required this.country,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        fullName: json["fullName"],
        address: json["address"],
        city: json["city"],
        postalCode: json["postalCode"],
        phone: json["phone"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "address": address,
        "city": city,
        "postalCode": postalCode,
        "phone": phone,
        "country": country,
      };
}
