import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/model/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  static const String routeName = '/order-details';
  Order order;
  OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),

        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/images/amazon_clone.png",
                  width: 120,
                  height: 120,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications, size: 30),
              ),
              // SizedBox(width: 10,),
              IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 30)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View Order Details',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date :   ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}',
                    ),
                    Text('Order ID :      ${widget.order.id}'),
                    Text('Order Total :      Rs.${widget.order.total}'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Purchase Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('Qty : ${widget.order.quantity[i]}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tracking ',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Stepper(
                controlsBuilder: (context, details) {
                  if (user.type == 'seller') {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          currentStep += 1;
                        });
                      },
                      child: Text("Done"),
                    );
                  }
                  return SizedBox();
                },
                currentStep: currentStep,
                steps: [
                  Step(
                    title: Text("Pending"),
                    content: Text("Your order is being processed"),
                    isActive: currentStep > 0,
                    state:
                        currentStep > 0
                            ? StepState.complete
                            : StepState.indexed,
                  ),
                  Step(
                    title: Text("Order Confirmed"),
                    content: Text("Your order is Confirmed"),
                    isActive: currentStep > 1,
                    state:
                        currentStep > 1
                            ? StepState.complete
                            : StepState.indexed,
                  ),
                  Step(
                    title: Text("Shipped"),
                    content: Text("Your order has been Shipped"),
                    isActive: currentStep > 2,
                    state:
                        currentStep > 2
                            ? StepState.complete
                            : StepState.indexed,
                  ),
                  Step(
                    title: Text("Delivered"),
                    content: Text("Your order is Delivered"),
                    isActive: currentStep > 3,
                    state:
                        currentStep > 3
                            ? StepState.complete
                            : StepState.indexed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
