import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/entities/cart_item.dart';
import 'package:shop_app/presentation/bloc/cart_bloc.dart';
import 'package:shop_app/presentation/widgets/sizer.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  var money = NumberFormat.currency(
      customPattern: "#,##0.00", locale: "th_TH", symbol: "");
  CartBloc? cartBloc;
  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);
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
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartState) {
                context.read<CartBloc>().add(OnloadCart());
              }
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CartLoaded) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: itemListInShop(state.result),
                    ),
                    const SizedBox(height: 80),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        bottomSheet: Container(
          height: 50,
          width: Sizer(context).w,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Expanded(
                    child: Text(
                      'Total : \$${money.format(cartBloc?.total ?? 0)} ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  // con.checkOut();
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
  }

  Widget itemListInShop(List<CartItemEntity> result) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: result.length,
      itemBuilder: (context, index) {
        CartItemEntity only = result[index];
        return ClipRect(
          child: Slidable(
            key: ValueKey(index),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    context.read<CartBloc>().add(RemoveFromCart(only));
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
                                only.product.imageUrl,
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
                              only.product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              "\$${money.format(only.product.price)} ",
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
                                      context
                                          .read<CartBloc>()
                                          .add(MinusQuantity(only));
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
                                      context
                                          .read<CartBloc>()
                                          .add(AddQuantity(only));
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
