import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/theme.dart';
import 'package:shop_app/feature/product/controller/product_controller.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/widgets/sizer.dart';

class ProductPage extends StatefulWidget {
  ProductPage(this.product, {super.key});
  ProductItem product;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductController? productController;

  @override
  void initState() {
    productController = ProductController(context, product: widget.product);
    productController!.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productController,
      child: Consumer<ProductController>(builder: (context, con, _) {
        return Scaffold(
          body: Container(
            width: Sizer(context).w,
            height: Sizer(context).h,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        con.product.imageUrl ?? "",
                        fit: BoxFit.cover,
                        height: 300,
                        width: Sizer(context).w,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            alignment: Alignment.center,
                            width: Sizer(context).w,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: Text("error image"),
                          );
                        },
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: SafeArea(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                con.product.name ?? "",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                con.saveFavorite(con.product);
                              },
                              child: Builder(builder: (context) {
                                bool selected = con.favorite!
                                    .thisProductInFavorite(con.product);
                                if (selected) {
                                  return Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  );
                                }
                                return Icon(
                                  Icons.favorite_outline,
                                  color: Colors.grey,
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Builder(builder: (context) {
                          var money = NumberFormat.currency(
                              customPattern: "#,##0.00",
                              locale: "th_TH",
                              symbol: "");
                          return Text(
                            "\$${money.format(con.product.price ?? 0)} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      con.addToCart(con.product);
                    },
                    child: Container(
                      width: Sizer(context).w,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        "Add to Cart",
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
}
