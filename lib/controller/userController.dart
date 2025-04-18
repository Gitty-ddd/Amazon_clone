import 'dart:convert';

import 'package:amazon_clone/constants/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/model/userModel.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Usercontroller {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/add-to-cart"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp, // <-- Fix this key!
        },

        body: jsonEncode({'id': product.id}),
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          userProvider.setUserFromMode(user);
          showSnackBar(context, "Added to cart successfully!");
        },
      );
    } catch (e) {
      showSnackBar(context, "Error Occured - ${e.toString()}");
    }
  }

  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/api/remove-from-cart/${product.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp, // <-- Fix this key!
        },
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          userProvider.setUserFromMode(user);
          showSnackBar(context, "Removed from cart successfully!");
        },
      );
    } catch (e) {
      showSnackBar(context, "Error Occured - ${e.toString()}");
    }
  }
}
