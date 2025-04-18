import 'package:amazon_clone/model/orders.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/seller_view/addProduct.dart';
import 'package:amazon_clone/utils/bottom_nav.dart';
import 'package:amazon_clone/view/addressScreen.dart';
import 'package:amazon_clone/view/auth/authScreen.dart';
import 'package:amazon_clone/view/orderDetails.dart';
import 'package:amazon_clone/view/productdetail.dart';
import 'package:amazon_clone/view/searchscreen.dart';
//import 'package:amazon_clone/view/homescreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => AuthScreen());
    case BottomNavBar.routeName:
      return MaterialPageRoute(builder: (_) => BottomNavBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => AddProductScreen());
    case Searchscreen.routeName:
      return MaterialPageRoute(
        builder:
            (_) => Searchscreen(searchQuery: routeSettings.arguments as String),
      );
    case ProductDetailScreen.routeName:
      return MaterialPageRoute(
        builder:
            (_) => ProductDetailScreen(
              product: routeSettings.arguments as Product,
            ),
      );
    case AddressScreen.routeName:
      return MaterialPageRoute(
        builder:
            (_) =>
                AddressScreen(totalAmount: routeSettings.arguments as String),
      );
    case OrderDetails.routeName:
      return MaterialPageRoute(
        builder: (_) => OrderDetails(order: routeSettings.arguments as Order),
      );
    default:
      return MaterialPageRoute(
        builder:
            (_) => Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(child: Text('Page Not Found')),
            ),
      );
  }
}
