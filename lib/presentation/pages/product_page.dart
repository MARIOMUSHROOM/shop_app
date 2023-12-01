import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/presentation/bloc/cart_bloc.dart';
import 'package:shop_app/presentation/bloc/product_detail_bloc.dart';
import 'package:shop_app/presentation/bloc/saved_bloc.dart';
import 'package:shop_app/presentation/widgets/sizer.dart';

class ProductPage extends StatelessWidget {
  ProductPage(this.productId, {super.key});
  int productId;
  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().add(OnLoadProductDetail(productId));
    return Scaffold(
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          // if (state is ProductDetailInitial) {
          //   context
          //       .read<ProductDetailBloc>()
          //       .add(OnLoadProduct(widget.productId));
          // }
          if (state is ProductDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductDetailLoaded) {
            BlocProvider.of<SavedBloc>(context)
                .add(OnLoadOnlySaved(state.result));
            return Container(
              width: Sizer(context).w,
              height: Sizer(context).h,
              decoration: BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          state.result.imageUrl,
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
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.result.name,
                                  style: const TextStyle(
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
                                  BlocProvider.of<SavedBloc>(context)
                                      .add(OnAddSaved(state.result));
                                },
                                child: BlocBuilder<SavedBloc, SavedState>(
                                  builder: (contextSaved, stateSaved) {
                                    if (stateSaved is SavedLoading) {
                                      return Container();
                                    }
                                    if (stateSaved is SavedOnlyLoaded) {
                                      if (stateSaved.result.isSelected) {
                                        return const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        );
                                      }
                                      return const Icon(
                                        Icons.favorite_outline,
                                        color: Colors.grey,
                                      );
                                    }
                                    return Container();
                                  },
                                ),
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
                              "\$${money.format(state.result.price)} ",
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
                        context
                            .read<CartBloc>()
                            .add(AddtoCart(context, state.result));
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
            );
          }
          return Container();
        },
      ),
    );
  }
}
