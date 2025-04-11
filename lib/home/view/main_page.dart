import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:one_store_delivery/home/view/home_page_view.dart';
import 'package:one_store_delivery/home/view/order_history_page_view.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';
import 'custom_drawer.dart';
import 'order_taken_page_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // List of pages for bottom navigation
  final List<Widget> _pages = [
    const HomePageView(),
    const OrderTakenPageView(),
    const OrderHistory(),
  ];

  // Handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return "طلبات التوصيل";
      case 1:
        return "الطلبات الجارية";
      case 2:
        return "سجل الطلبات";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CustomText(
          text: getAppBarTitle(_selectedIndex),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColor.appColor,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColor.appColor),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const CustomDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColor.appColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            label: 'طلباتي الجارية',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar_circle_fill),
            label: 'سجل الطلبات',
          ),
        ],
      ),
    );
  }
}
