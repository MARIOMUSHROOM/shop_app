import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shop_app/feature/checkout/controller/checkout_controller.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/widgets/sizer.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({super.key});
  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  CheckoutController? controller;

  @override
  void initState() {
    controller = CheckoutController(context);
    controller!.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<CheckoutController>(builder: (context, con, _) {
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
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  QrImageView(
                    data:
                        'h9ps://payment-api.yimplaZorm.com/checkout?price=${con.totalPrice}',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 50),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: con.cartList.length,
                    itemBuilder: (context, index) {
                      CartModel only = con.cartList[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${only.item.name ?? ""} ",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Text(
                            "\$${con.money.format(only.item.price! * only.quantity)} ",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "total",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      Text(
                        "\$${con.money.format(con.totalPrice)} ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
