import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shop_app/widgets/sizer.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage(this.totalPrice, {super.key});
  num totalPrice;
  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var money = NumberFormat.currency(
      customPattern: "#,##0.00", locale: "th_TH", symbol: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),
          color: Colors.black,
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: Sizer(context).w,
        height: Sizer(context).h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              QrImageView(
                data:
                    'https://payment.spw.challenge/checkout?price=${widget.totalPrice}',
                version: QrVersions.auto,
                size: 200.0,
              ),
              const SizedBox(height: 50),
              const Text(
                "Scan & Pay",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(height: 20),
              Text(
                "\$${money.format(widget.totalPrice)} ",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
