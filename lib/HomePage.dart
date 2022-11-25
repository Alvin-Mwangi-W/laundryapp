import 'package:flutter/material.dart';
import 'package:laundryapp/AdminPage.dart';
import 'package:laundryapp/LandingPage.dart';
import 'package:laundryapp/user/Profile.dart';
import 'package:laundryapp/StyleScheme.dart';
import 'package:laundryapp/orders/MyOrders.dart';
import 'orders/OrderPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Widget> pages = [];

  Widget bodyWidget = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "Alpha Luandry",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        iconSize: 30,
        onTap: (value) => {openRelevantPage(value)},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), label: "My Orders"),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: "Profile",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: "Admin Page"),
        ],
      ),
    );
  }

  void openRelevantPage(int pageId) {
    setState(() {
      bodyWidget = pages[pageId];
    });
  }

  void openOrderPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderPage()));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      pages.addAll([
        LandingPage(openOrderPage: openOrderPage),
        MyOrders(),
        const Profile(),
        AdminPage()
      ]);

      bodyWidget = pages[0];
    });
  }
}
