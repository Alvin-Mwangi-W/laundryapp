import 'package:flutter/material.dart';
import 'package:laundryapp/StyleScheme.dart';
import 'OrderConfirmPage.dart';

class TrackOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: trackOrderPage(),
    );
  }
}

class trackOrderPage extends StatefulWidget {
  @override
  _trackOrderPageState createState() => _trackOrderPageState();
}

class _trackOrderPageState extends State<trackOrderPage> {
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
          "Track Order",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Number 1001",
              style: headingStyle,
            ),
            Text(
              "Order confirmed. Ready to pick",
              style: contentStyle.copyWith(color: Colors.grey, fontSize: 16),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              height: 1,
              color: Colors.grey,
            ),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 13, top: 50),
                  width: 4,
                  height: 400,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    statusWidget('confirmed', "Confirmed", true),
                    statusWidget('onBoard2', "Picked Up", false),
                    statusWidget('servicesImg', "In Pricess", false),
                    statusWidget('shipped', "Shipped", false),
                    statusWidget('Delivery', "Delivered", false),
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              height: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.orange,
                      )),
                  child: Text(
                    "Cancel Order",
                    style: contentStyle.copyWith(color: Colors.orange),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.orange,
                  ),
                  child: Text(
                    "My Orders",
                    style: contentStyle.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        iconSize: 30,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), label: "Track Order"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.view_list), label: "My Orders"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Container statusWidget(String img, String status, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive) ? Colors.orange : Colors.white,
                border: Border.all(
                    color: (isActive) ? Colors.transparent : Colors.orange,
                    width: 3)),
          ),
          const SizedBox(
            width: 50,
          ),
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/images/$img.png"),
                        fit: BoxFit.contain)),
              ),
              Text(
                status,
                style: contentStyle.copyWith(
                    color: (isActive) ? Colors.orange : Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
