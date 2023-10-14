import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/feature/home/controller/home_controller.dart';
import 'package:shop_app/feature/product/pages/product_page.dart';
import 'package:shop_app/feature/recommendation/pages/recommendation_page.dart';
import 'package:shop_app/models/banner_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/widgets/sizer.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController? homeController;

  @override
  void initState() {
    homeController = HomeController(context);
    homeController!.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return ChangeNotifierProvider.value(
      value: homeController,
      child: Consumer<HomeController>(builder: (context, con, _) {
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
                    Builder(builder: (context) {
                      if (con.bannerItems?.isEmpty ?? false) {
                        return SizedBox();
                      }
                      return Container(
                        height: 200.0,
                        child: Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0,
                                viewportFraction: 1,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  con.setIndex(index);
                                },
                              ),
                              items: con.bannerItems?.map((BannerItem item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: Image.network(
                                        item.imageUrl ?? "",
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: DotsIndicator(
                                dotsCount: con.bannerItems?.length ?? 0,
                                position: con.index,
                                decorator: DotsDecorator(
                                  color: Colors.white,
                                  size: const Size(10, 9.0),
                                  activeSize: const Size(30, 9.0),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Recommendation",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => RecommendationPage());
                              Navigator.push(context, route);
                            },
                            child: Text(
                              "View all",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: con.productList.length > 4
                            ? 4
                            : con.productList.length,
                        itemBuilder: (BuildContext context, index) {
                          ProductItem only = con.productList[index];
                          return GestureDetector(
                            onTap: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => ProductPage(only));
                              Navigator.push(context, route).then((value) {
                                con.init();
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
                                              only.imageUrl ?? "",
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
                                          Positioned(
                                            top: 5,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                con.saveFavorite(only);
                                              },
                                              child:
                                                  Builder(builder: (context) {
                                                bool selected = con.favorite!
                                                    .thisProductInFavorite(
                                                        only);
                                                if (selected) {
                                                  return Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  );
                                                }
                                                return Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                );
                                              }),
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
                                              only.name ?? "",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Builder(builder: (context) {
                                              var money = NumberFormat.currency(
                                                  customPattern: "#,##0.00",
                                                  locale: "th_TH",
                                                  symbol: "");
                                              return Text(
                                                "\$${money.format(only.price ?? 0)} ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              );
                                            }),
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
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: con.productList.length,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount:
                    //         (orientation == Orientation.portrait) ? 2 : 3,
                    //   ),
                    //   itemBuilder: (BuildContext context, int index) {
                    //     ProductItem only = con.productList[index];
                    //   },
                    // )
                  ],
                ),
              ),
            ),
            floatingActionButton: GestureDetector(
              onTap: () {
                con.sortByPrice();
              },
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Text("sort"),
              ),
            ),
          ),
        );
      }),
    );
  }
}
