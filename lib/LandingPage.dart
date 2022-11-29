import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundryapp/StyleScheme.dart';

class LandingPage extends StatelessWidget {
  final void Function() openOrderPage;
  LandingPage({required this.openOrderPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xfff1ffff),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("BLESS THIS MESS", style: headingStyle),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "We pick your clothes and give \nthem a fresh look",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/images/bannerImg.png'))),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("SERVICES", style: headingStyle),
          Container(
            height: 200,
            color: const Color(0xfff1ffff),
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 120,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/images/servicesImg.png'))),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "IRON ONLY",
                          style: headingStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: openOrderPage,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: gradientStyle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: const Text(
                              "Place Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xfff1ffff),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "AVAILABILITY ",
                      style: contentStyle,
                    ),
                    Text(
                      "AVAILABLE",
                      style: contentStyle.copyWith(color: Colors.blue),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("We are open from 7.00 am to 8.00 pm")
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xfff1ffff),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CHECK THE ESTIMATION",
                  style: contentStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "You can check time extimation with price",
                  style: contentStyle,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    gradient: gradientStyle, shape: BoxShape.circle),
                child: const Text(
                  "+",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
