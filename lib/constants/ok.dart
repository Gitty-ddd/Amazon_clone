// //cart product 
// import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
// import 'package:amazon_clone/controller/userController.dart';
// import 'package:amazon_clone/model/product.dart';
// import 'package:amazon_clone/view/productdetail.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_stars/flutter_rating_stars.dart';
// import 'package:provider/provider.dart';

// // ignore: must_be_immutable
// class CartProduct extends StatefulWidget {
//   int index;
//   CartProduct({super.key, required this.index});

//   @override
//   State<CartProduct> createState() => _CartProductState();
// }

// class _CartProductState extends State<CartProduct> {
//   void increaseQuantity(Product product) {
//     Usercontroller().addToCart(context: context, product: product);
//   }

//   void decreaseQuantity(Product product) {
//     Usercontroller().removeFromCart(context: context, product: product);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productCart = context.watch<UserProvider>().user.cart[widget.index];
//     final products = Product.fromDBtoApp(productCart['product']);
//     final quantity = productCart['quantity'];
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           ProductDetailScreen.routeName,
//           arguments: products,
//         );
//       },
//       child: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(left: 4, right: 10, bottom: 8),
//             child: Row(
//               children: [
//                 Image.network(
//                   products.images[0],
//                   height: 130,
//                   width: 130,
//                   fit: BoxFit.contain,
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                       width: 235,
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       child: Text(
//                         products.name,
//                         style: TextStyle(fontSize: 16),
//                         maxLines: 2,
//                       ),
//                     ),
//                     Container(
//                       width: 235,
//                       padding: EdgeInsets.only(left: 5, top: 5),
//                       child: RatingStars(value: 4),
//                     ),
//                     Container(
//                       width: 235,
//                       padding: EdgeInsets.only(left: 5, top: 5),
//                       child: Text(
//                         'Rs.${products.price.toString()}',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 2,
//                       ),
//                     ),
//                     Container(
//                       width: 235,
//                       padding: EdgeInsets.only(left: 5, top: 5),
//                       child: Text("Free Shipping"),
//                     ),
//                     Container(
//                       width: 235,
//                       padding: EdgeInsets.only(left: 5, top: 5),
//                       child: Text(
//                         "In Stock",
//                         style: TextStyle(color: Colors.teal),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.all(10),
//                           child: Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     decreaseQuantity(products);
//                                   },
//                                   child: Container(
//                                     color: Colors.grey,
//                                     width: 35,
//                                     height: 32,
//                                     alignment: Alignment.center,
//                                     child: Icon(Icons.remove, size: 18),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 32,
//                                   width: 35,
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     quantity.toString(),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     increaseQuantity(products);
//                                   },
//                                   child: Container(
//                                     color: Colors.grey,
//                                     width: 35,
//                                     height: 32,
//                                     alignment: Alignment.center,
//                                     child: Icon(Icons.add, size: 18),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// //cartscreen

// import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
// import 'package:amazon_clone/utils/cartProduct.dart';
// import 'package:amazon_clone/view/addressScreen.dart';
// import 'package:amazon_clone/view/searchscreen.dart' show Searchscreen;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Cartscreen extends StatefulWidget {
//   const Cartscreen({super.key});

//   @override
//   State<Cartscreen> createState() => _CartscreenState();
// }


// class _CartscreenState extends State<Cartscreen> {
//   // Make sure you're updating the local user state after product deletion

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;
//     int subtotal = 0;
//     for (var cartItems in user.cart) {
//       if (cartItems['product'] != null) {
//         // <- This check
//         subtotal +=
//             cartItems['quantity'] * cartItems['product']['price'] as int;
//       }
//     }
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(color: Colors.blueAccent),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 42,
//                   margin: const EdgeInsets.only(left: 15),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(7),
//                     elevation: 1,
//                     child: TextFormField(
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.search,
//                       onFieldSubmitted: (value) {
//                         Navigator.pushNamed(
//                           context,
//                           Searchscreen.routeName,
//                           arguments: value,
//                         );
//                       },
//                       decoration: InputDecoration(
//                         prefixIcon: InkWell(
//                           onTap: () {},
//                           child: const Padding(
//                             padding: EdgeInsets.only(left: 6),
//                             child: Icon(
//                               Icons.search,
//                               color: Colors.black,
//                               size: 23,
//                             ),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.only(top: 10),
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(7)),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(7)),
//                           borderSide: BorderSide(
//                             color: Colors.black38,
//                             width: 1,
//                           ),
//                         ),
//                         hintText: 'Search Amazon.in',
//                         hintStyle: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.transparent,
//                 height: 42,
//                 margin: const EdgeInsets.symmetric(horizontal: 10),
//                 child: const Icon(Icons.mic, color: Colors.black, size: 25),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 40,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 114, 226, 221),
//                   Color.fromARGB(255, 162, 236, 233),
//                 ],
//                 stops: [0.5, 1.0],
//               ),
//             ),
//             padding: const EdgeInsets.only(left: 10),
//             child: Row(
//               children: [
//                 const Icon(Icons.location_on_outlined, size: 20),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 5),
//                     child: Text(
//                       'Delivery to ${user.name} - ${user.address} ',
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 5, top: 2),
//                   child: Icon(Icons.arrow_drop_down_outlined, size: 18),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 const Text(
//                   "Subtotal: ",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   "Rs. $subtotal",
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(
//                     context,
//                     AddressScreen.routeName,
//                     arguments: subtotal.toString(),
//                   );
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width / 2 - 120,
//                     vertical: 20,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.orangeAccent,
//                   ),
//                   child: Text(
//                     "Proceed to Checkout (${user.cart.length} Items)",
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 25),
//             child: Divider(),
//           ),
//           ListView.separated(
//             separatorBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(vertical: 5),
//                 child: Divider(color: Colors.grey, endIndent: 10, indent: 10),
//               );
//             },
//             shrinkWrap: true,
//             itemCount:
//                 user.cart.where((item) => item['product'] != null).length,
//             //user.cart.length,
//             itemBuilder: (context, index) {
//               return CartProduct(index: index);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


// //usercontroller

// import 'dart:convert';

// import 'package:amazon_clone/constants/global.dart';
// import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
// import 'package:amazon_clone/model/product.dart';
// import 'package:amazon_clone/model/userModel.dart';
// import 'package:amazon_clone/utils/errorHandler.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class Usercontroller {
//   void addToCart({
//     required BuildContext context,
//     required Product product,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     try {
//       http.Response res = await http.post(
//         Uri.parse("$uri/api/add-to-cart"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'stamp': userProvider.user.stamp, // <-- Fix this key!
//         },

//         body: jsonEncode({'id': product.id}),
//       );
//       httpErrorHandler(
//         response: res,
//         context: context,
//         onSuccess: () {
//           User user = userProvider.user.copyWith(
//             cart: jsonDecode(res.body)['cart'],
//           );
//           userProvider.setUserFromMode(user);
//           showSnackBar(context, "Added to cart successfully!");
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, "Error Occured - ${e.toString()}");
//     }
//   }

//   void removeFromCart({
//     required BuildContext context,
//     required Product product,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     try {
//       http.Response res = await http.delete(
//         Uri.parse("$uri/api/remove-from-cart/${product.id}"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'stamp': userProvider.user.stamp, // <-- Fix this key!
//         },
//       );
//       httpErrorHandler(
//         response: res,
//         context: context,
//         onSuccess: () {
//           User user = userProvider.user.copyWith(
//             cart: jsonDecode(res.body)['cart'],
//           );
//           userProvider.setUserFromMode(user);
//           showSnackBar(context, "Removed from cart successfully!");
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, "Error Occured - ${e.toString()}");
//     }
//   }
// }
