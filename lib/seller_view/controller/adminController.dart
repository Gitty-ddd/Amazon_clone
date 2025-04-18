import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/global.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class AdminController {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    // ignore: unused_local_variable
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      print("Step 1: Starting upload");
      final cloudinary = CloudinaryPublic('delc6lpe8', 'n2hj6ajd');

      List<String> imageUrl = [];

      for (var img in images) {
        print("Uploading image: ${img.path}");
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(img.path, folder: name),
        );
        print("Uploaded to: ${res.secureUrl}");
        imageUrl.add(res.secureUrl);
        print(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrl,
        category: category,
        price: price,
      );
      http.Response res = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp,
        },
        body: product.toJson(),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product Added Successfully!");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      print("ERROR: $e");
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
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

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'stamp': userProvider.user.stamp,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product Deleted Successfully!");
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
