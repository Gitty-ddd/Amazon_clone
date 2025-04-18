import 'dart:convert';

import 'package:amazon_clone/constants/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchControllerService {
  Future<List<Product>> fetchSearchProduct({
    required String searchQuery,
    required BuildContext context,
  }) async {
    final UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Product> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/product/search/$searchQuery'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "stamp": userProvider.user.stamp,
        },
      );

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }
}
