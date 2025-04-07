import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_store_delivery/home/view/home_page_view.dart';
import 'package:one_store_delivery/home/view/order_history_page_view.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'order_taken_page_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _pages[_selectedIndex], // Display the page based on selected index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Update selected index on tap
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
          // Add more BottomNavigationBarItems for additional tabs if needed
        ],
      ),
    );
  }
}
