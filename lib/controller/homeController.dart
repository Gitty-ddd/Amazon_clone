import 'dart:convert';

import 'package:amazon_clone/constants/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Homecontroller {
  Future<List<Product>> fetchCategory({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/product?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp,
        },
      );
      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
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

  Future<Product> fetchDealOfTheDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      id: '',
      name: '',
      description: '',
      price: 0,
      quantity: 0,
      images: [],
      category: '',
    );
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/deal-of-the-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp,
        },
      );
      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
