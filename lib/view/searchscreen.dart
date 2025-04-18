import 'package:amazon_clone/controller/SearchController.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/view/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key, required this.searchQuery});

  static const String routeName = '/search-screen';
  final String searchQuery;

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  List<Product>? product;
  final SearchControllerService SearchController = SearchControllerService();
  fetchSearchProduct() async {
    product = await SearchController.fetchSearchProduct(
      context: context,
      searchQuery: widget.searchQuery,
    );
    print(product);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchSearchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        Navigator.pushNamed(
                          context,
                          Searchscreen.routeName,
                          arguments: value,
                        );
                      },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      initialValue: widget.searchQuery,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body:
          product == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  SizedBox(height: 15),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.black12,
                          thickness: 1,
                        );
                      },
                      itemCount: product!.length,
                      itemBuilder: (context, index) {
                        final products = product![index];
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
                                margin: const EdgeInsets.only(
                                  left: 4,
                                  right: 10,
                                  bottom: 8,
                                ),
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
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Text(
                                            products.name,
                                            style: TextStyle(fontSize: 16),
                                            maxLines: 2,
                                          ),
                                        ),
                                        Container(
                                          width: 235,
                                          padding: EdgeInsets.only(
                                            left: 5,
                                            top: 5,
                                          ),
                                          child: RatingStars(value: 4),
                                        ),
                                        Container(
                                          width: 235,
                                          padding: EdgeInsets.only(
                                            left: 5,
                                            top: 5,
                                          ),
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
                                          padding: EdgeInsets.only(
                                            left: 5,
                                            top: 5,
                                          ),
                                          child: Text("Free Shipping"),
                                        ),
                                        Container(
                                          width: 235,
                                          padding: EdgeInsets.only(
                                            left: 5,
                                            top: 5,
                                          ),
                                          child: Text(
                                            "In Stock",
                                            style: TextStyle(
                                              color: Colors.teal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
