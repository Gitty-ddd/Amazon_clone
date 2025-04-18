import 'dart:convert';

import 'package:amazon_clone/constants/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/userModel.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Addresscontroller {
  Future<void> saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "stamp": userProvider.user.stamp,
        },
        body: jsonEncode({'address': address}),
      );
      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userProvider.setUserFromMode(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double total,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/order"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "stamp": userProvider.user.stamp,
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'total': total,
        }),
      );

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          //final newOrder = Order.fromDBtoApp(jsonDecode(res.body));
          showSnackBar(context, "Your Order has been Susscessfully Placed");
        },
      );
      User user = userProvider.user.copyWith(cart: []);
      userProvider.setUserFromMode(user);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
