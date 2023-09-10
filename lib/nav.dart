import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/feature/cart/pages/cart_page.dart';
import 'package:shop_app/feature/home/pages/home_page.dart';
import 'package:shop_app/feature/saved/pages/saved_page.dart';

class Nav extends StatefulWidget {
  Nav({super.key, this.index = 0});
  int index;
  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> with TickerProviderStateMixin {
  TabController? tabController;
  bool bigCenterButton = true;
  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    SavedPage(),
    CartPage(),
  ];

  tab(int value) {
    currentIndex = value;
    tabController!.animateTo(value);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: pages.length, vsync: this); // initialise it here
    currentIndex = widget.index;
    tabController!.animateTo(currentIndex);
    // init();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages.map<Widget>((e) => e).toList(),
      ),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.grey.shade50,
        child: BottomNavigationBar(
          elevation: 0,
          onTap: (value) {
            tab(value);
          },
          selectedLabelStyle: GoogleFonts.kanit(),
          unselectedLabelStyle: GoogleFonts.kanit(),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: "Home"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite),
                icon: Icon(Icons.favorite_outline_outlined),
                label: "Saved"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.shopping_cart),
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Cart"),
          ],
        ),
      ),
    );
  }
}
