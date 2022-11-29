import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryapp/StyleScheme.dart';
import 'package:laundryapp/orders/TrackOrderPage.dart';

import '../controllers/CartController.dart';

class OrderConfirmPage extends StatelessWidget {
  final String orderId;
  OrderConfirmPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: orderConfirmPage(
        orderId: orderId,
      ),
    );
  }
}

class orderConfirmPage extends StatefulWidget {
  final String orderId;
  orderConfirmPage({required this.orderId});
  @override
  _orderConfirmPageState createState() => _orderConfirmPageState();
}

class _orderConfirmPageState extends State<orderConfirmPage> {
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Order Confirmed",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/onBoard2.png'))),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Thank you for choosing us!",
              style: headingStyle,
            ),
            Text(
              "Your oder has been placed and we will pick up your clothes on time!",
              style: contentStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID",
                  style: headingStyle,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: gradientStyle,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "${widget.orderId}",
                    style: headingStyle.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
            divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Clothes Count",
                  style: headingStyle,
                ),
                Obx(
                  () => Text(
                    "${cartController.clothesCount}",
                    style: headingStyle.copyWith(color: Colors.grey),
                  ),
                )
              ],
            ),
            divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Final Amount",
                  style: headingStyle,
                ),
                Obx(
                  () => Text(
                    "${cartController.cartTotal.value}",
                    style: headingStyle.copyWith(color: Colors.grey),
                  ),
                )
              ],
            ),
            // divider(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Pick up Date & Time",
            //       style: headingStyle,
            //     ),
            //     Text(
            //       "Wednesday, 07 Aug, 2020. Between 10:00 AM & 12:00 PM",
            //       style:
            //           contentStyle.copyWith(color: Colors.grey, fontSize: 16),
            //     ),
            //   ],
            // ),
            // divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Method",
                  style: headingStyle,
                ),
                Text(
                  "Cash",
                  style: headingStyle.copyWith(color: Colors.grey),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TrackOrderPage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(gradient: gradientStyle),
                child: Center(
                  child: Text(
                    "TRACK ORDER",
                    style: contentStyle.copyWith(
                        color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 1,
      color: Colors.grey,
    );
  }
}
