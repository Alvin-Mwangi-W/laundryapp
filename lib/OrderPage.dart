import 'package:flutter/material.dart';
import 'package:laundryapp/CartController.dart';
import 'package:laundryapp/PickUpTimePage.dart';
import 'package:laundryapp/StyleScheme.dart';
import 'package:get/get.dart';
import 'package:laundryapp/CartController.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: orderPage(),
    );
  }
}

class orderPage extends StatefulWidget {
  @override
  _orderPageState createState() => _orderPageState();
}

class _orderPageState extends State<orderPage> {
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
          "Select Clothes",
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: cartController.cartItems
                      .map((element) => Obx(() => ClothWidget(element.value)))
                      .toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Your Basket",
                      style: headingStyle,
                    ),
                    Text(
                      "7 Items added",
                      style: contentStyle,
                    )
                  ],
                ),
                Obx(() => Text(
                      "${cartController.cartTotal}",
                      style: headingStyle,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PickUpTimePage()));
              },
              child: Container(
                  padding: EdgeInsets.all(20),
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: gradientStyle,
                  ),
                  child: const Center(
                    child: Text(
                      "SELECT DATE & TIME",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

Column categoryWidget(String img, String name, bool isActive) {
  return Column(
    children: [
      Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: (isActive) ? null : Colors.grey.withOpacity(0.3),
          gradient: (isActive) ? gradientStyle : null,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/$img.png'),
                    fit: BoxFit.contain)),
          ),
        ),
      ),
      Text(name, style: headingStyle)
    ],
  );
}

class ClothWidget extends StatelessWidget {
  ClothWidget(ClothingItem this.item);
  final ClothingItem item;

  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/images/${item.image}'))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.name}",
                      style: headingStyle,
                    ),
                    Text(
                      "\$${item.price}",
                      style: headingStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      "Add Note",
                      style: contentStyle.copyWith(color: Colors.orange),
                    )
                  ],
                ),
                Text(
                  "\$45",
                  style: headingStyle,
                ),
                Row(
                  children: [
                    // minus button
                    InkWell(
                      onTap: () {
                        //cartController.removeFromCart(item);
                        cartController.updateItem(item, item.quantity - 1);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: gradientStyle, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            "-",
                            style: headingStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text(
                          '${item.quantity}',
                          style: headingStyle.copyWith(fontSize: 30),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ///cartController.addToCart(item);
                        cartController.updateItem(item, item.quantity + 1);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: gradientStyle, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            "+",
                            style: headingStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.75,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
