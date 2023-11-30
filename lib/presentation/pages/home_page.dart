import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/domain/entities/product_item.dart';
import 'package:shop_app/presentation/bloc/home_bloc.dart';
import 'package:shop_app/presentation/pages/product_page.dart';
import 'package:shop_app/presentation/widgets/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "For you",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          height: Sizer(context).h,
          width: Sizer(context).w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  if (state is HomeState) {
                    context.read<HomeBloc>().add(const OnLoadProduct());
                  }
                  if (state is HomeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is HomeLoaded) {
                    return Container(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            state.result.length > 4 ? 4 : state.result.length,
                        itemBuilder: (BuildContext context, index) {
                          ProductItemEntity only = state.result[index];
                          return GestureDetector(
                            onTap: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => ProductPage(only));
                              Navigator.push(context, route).then((value) {
                                context
                                    .read<HomeBloc>()
                                    .add(const OnLoadProduct());
                              });
                            },
                            child: Container(
                              height: 200,
                              width: 150,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Image.network(
                                              only.imageUrl,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Center(
                                                  child: Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              only.name,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // Builder(builder: (context) {
                                            //   var money = NumberFormat.currency(
                                            //       customPattern: "#,##0.00",
                                            //       locale: "th_TH",
                                            //       symbol: "");
                                            //   return Text(
                                            //     "\$${money.format(only.price ?? 0)} ",
                                            //     style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 18,
                                            //     ),
                                            //   );
                                            // }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (state is HomeLoadFailue) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
