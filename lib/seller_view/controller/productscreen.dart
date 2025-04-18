import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/seller_view/addProduct.dart';
import 'package:amazon_clone/seller_view/controller/adminController.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? products;
  final AdminController adminController = AdminController();

  fetchAllProducts() async {
    products = await adminController.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product delProduct, int index) {
    adminController.deleteProduct(
      context: context,
      product: delProduct,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            title: const Text(
              'Your Products',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProductScreen.routeName);
            },
            child: Icon(Icons.add),
          ),

          body: Padding(
            padding: const EdgeInsets.all(8.0),

            child: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 8,
                childAspectRatio: 0.87,
              ),
              itemBuilder: (context, index) {
                final product = products![index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            product.images[0],
                            width: double.infinity,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 50);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),

                            // Text(
                            //   product.price.toString(),
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.green,
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹${product.price}",
                                  style: const TextStyle(color: Colors.green),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    deleteProduct(product, index);
                                  },
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
  }
}
        


  //       body: GridView.builder(
                        //         itemCount: products!.length,
                        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisCount: 2,
                        //         ),
                        //         itemBuilder: (context, index) {
                        //           return Card(
                        //             child: Column(
                        //               children: [
                        //                 Image.network(products![index].images[0]),
                        //                 Text(products![index].name),
                        //                 Text(products![index].description),
                        //                 Text(products![index].price.toString()),
                        //               ],
                        //             ),
                        // 