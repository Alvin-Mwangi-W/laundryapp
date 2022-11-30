import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundryapp/AdminPage.dart';
import 'package:laundryapp/LandingPage.dart';
import 'package:laundryapp/user/LoginPage.dart';
import 'package:laundryapp/user/Profile.dart';
import 'package:laundryapp/StyleScheme.dart';
import 'package:laundryapp/orders/MyOrders.dart';
import 'orders/OrderPage.dart';

class HomePage extends StatelessWidget {
  final int initialPage;
  HomePage({this.initialPage = 0});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(
        initialPage: initialPage,
      ),
    );
  }
}

class homePage extends StatefulWidget {
  final int initialPage;
  homePage({required this.initialPage });
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Widget> pages = [];
  var currentPage = 0;
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
        currentIndex: currentPage,
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
      currentPage = pageId;
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
        Profile(),
        AdminPage()
      ]);
      currentPage = widget.initialPage;
      bodyWidget = pages[currentPage];
    });

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print('User is signed in!');
      }
    });
  }
}
