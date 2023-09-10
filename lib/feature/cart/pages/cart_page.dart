import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/feature/cart/controller/cart_controller.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/widgets/sizer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartController? cartController;
  var money = NumberFormat.currency(
      customPattern: "#,##0.00", locale: "th_TH", symbol: "");

  @override
  void initState() {
    cartController = CartController(context);
    cartController!.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartController,
      child: Consumer<CartController>(builder: (context, con, _) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Cart",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: itemListInShop(con),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
            bottomSheet: Container(
              height: 50,
              width: Sizer(context).w,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total : \$${money.format(con.totalPrice)} ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      con.checkOut();
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        "Check out",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget itemListInShop(CartController con) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: con.cart?.cartList.length ?? 0,
      itemBuilder: (context, index) {
        CartModel only = con.cart!.cartList[index];
        return ClipRect(
          child: Slidable(
            key: ValueKey(index),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    con.removeItem(only);
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.delete_outline,
                ),
              ],
            ),
            child: FutureBuilder(builder: (context, option) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                only.item.imageUrl ?? "",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              only.item.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              "\$${money.format(only.item.price ?? 0)} ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      con.minusQuantity(only);
                                    },
                                    child: Container(
                                      width: 30,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${only.quantity}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      con.plusQuantity(only);
                                    },
                                    child: Container(
                                      width: 30,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
