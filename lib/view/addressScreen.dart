import 'package:amazon_clone/constants/googlepayconfig.dart';
import 'package:amazon_clone/controller/addressController.dart';
import 'package:amazon_clone/controller/provider_controller/user_provider.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String addressToBeUsed = "";

  final _addressFormKey = GlobalKey<FormState>();

  final TextEditingController addressLine1Controller = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController addressLine2Controller = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController landmarkController = TextEditingController();

  final Addresscontroller addresscontroller = Addresscontroller();

  onGooglePaySuccess(res) {
    //
    if (addressToBeUsed.isEmpty) {
      showSnackBar(context, "Address is not valid");
      return;
    }
    //
    if (Provider.of<UserProvider>(
      context,
      listen: false,
    ).user.address.isEmpty) {
      addresscontroller.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addresscontroller.placeOrder(
      context: context,
      address: addressToBeUsed,
      total: double.parse(widget.totalAmount),
    );
  }

  void payment(String addressFromProvider, BuildContext context) {
    addressToBeUsed = "";
    bool isFormFill =
        addressLine1Controller.text.isNotEmpty ||
        addressLine2Controller.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        stateController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        landmarkController.text.isNotEmpty;

    if (isFormFill) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${addressLine1Controller.text},${addressLine2Controller.text},${cityController.text},${stateController.text},${pincodeController.text},${landmarkController.text}';
      } else {
        throw Exception("Please Enter all Values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      //showSnackBar(context, "Ordered Successfully");
    } else {
      showSnackBar(context, "Error");
    }

    onGooglePaySuccess("res");
  }

  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(
      PaymentItem(
        label: 'Total Price',
        amount: widget.totalAmount,
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(title: Text("Enter Your Address")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              address.isNotEmpty
                  ? Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Text(address),
                      ),
                      //SizedBox(height: 20),
                      Text("OR"),
                    ],
                  )
                  : SizedBox(height: 20),

              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    //SizedBox(height: 20),
                    TextFormField(
                      controller: addressLine1Controller,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This feild is mandatory";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: "Address Line 1",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: addressLine2Controller,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This feild is mandatory";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: "Address Line 2",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: cityController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This feild is mandatory";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: "City",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: stateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This feild is mandatory";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: "State",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: pincodeController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This feild is mandatory";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: "Pincode",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: landmarkController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This feild is mandatory";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: "Landmark",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    GooglePayButton(
                      onPaymentResult: (res) {
                        onGooglePaySuccess(res);
                      },
                      onPressed: () => payment(address, context),
                      width: double.infinity,
                      type: GooglePayButtonType.order,
                      paymentConfiguration: PaymentConfiguration.fromJsonString(
                        defaultGooglePay,
                      ),
                      paymentItems: paymentItems,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
