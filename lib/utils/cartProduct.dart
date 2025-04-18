import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/controller/userController.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/view/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartProduct extends StatefulWidget {
  int index;
  CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  void increaseQuantity(Product product) {
    Usercontroller().addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    Usercontroller().removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final products = Product.fromDBtoApp(productCart['product']);
    final quantity = productCart['quantity'];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: products,
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 4, right: 10, bottom: 8),
            child: Row(
              children: [
                Image.network(
                  products.images[0],
                  height: 130,
                  width: 130,
                  fit: BoxFit.contain,
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        products.name,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: RatingStars(value: 4),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        'Rs.${products.price.toString()}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Text("Free Shipping"),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        "In Stock",
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    decreaseQuantity(products);
                                  },
                                  child: Container(
                                    color: Colors.grey,
                                    width: 35,
                                    height: 32,
                                    alignment: Alignment.center,
                                    child: Icon(Icons.remove, size: 18),
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 35,
                                  alignment: Alignment.center,
                                  child: Text(
                                    quantity.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    increaseQuantity(products);
                                  },
                                  child: Container(
                                    color: Colors.grey,
                                    width: 35,
                                    height: 32,
                                    alignment: Alignment.center,
                                    child: Icon(Icons.add, size: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
