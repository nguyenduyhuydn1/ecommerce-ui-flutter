import 'package:ecommerce_ui_flutter/auth/domain/entities/user.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
        wishLists: List<dynamic>.from(json["wishLists"].map((x) => x)),
        isAdmin: json["isAdmin"],
        hasShippingAddress: json["hasShippingAddress"],
        id: json["_id"],
        token: json["token"],
        message: json["message"],
      );
}
