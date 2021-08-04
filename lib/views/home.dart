import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PayHome extends StatefulWidget {
  const PayHome({Key? key}) : super(key: key);

  @override
  _PayHomeState createState() => _PayHomeState();
}

class _PayHomeState extends State<PayHome> {
  Razorpay razorpay = new Razorpay();
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_uKkRjJ8kerzlUb",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Payment App",
      "description": "Payment",
      "prefill": {
        "contact": "9824343803",
        "email": "dvpandya2138433@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    Fluttertoast.showToast(
        msg: "Payment Successful",
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG);
  }

  void handlerPaymentError() {
    Fluttertoast.showToast(
        msg: "Payment Error",
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG);
  }

  void handlerExternalWallet() {
    Fluttertoast.showToast(
        msg: "External Wallet",
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment System"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "Amount",
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () {
                openCheckOut();
              },
              child: Text("Pay Now"),
            ),
          ],
        ),
      ),
    );
  }
}
