import 'package:amazon_clone/model/orders.dart';
import 'package:amazon_clone/view/orderDetails.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SingleProduct extends StatelessWidget {
  Order order;
  SingleProduct({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, OrderDetails.routeName, arguments: order);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderDetails(order: order)),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Container(
            width: 180,
            height: 200,
            padding: EdgeInsets.all(10),
            child: Image.network(
              order.products[0].images[0],
              fit: BoxFit.fitHeight,
              width: 180,
            ),
          ),
        ),
      ),
    );
  }
}
