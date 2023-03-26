import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry_jack/models/welcome.dart';
import 'package:hungry_jack/resources/colors.dart';
import 'package:hungry_jack/screens/authentication.dart';
import 'package:hungry_jack/utilities/common.dart';

import '../resources/images.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Future<List<WelcomeItem>> welcomeItems;
  int _current = 0;
  bool _isButtonVisible = false;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    welcomeItems = readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: AppColors.black,
          child: FutureBuilder(
            future: welcomeItems,
            builder: (context, snapshot) {
              List<WelcomeItem> data = snapshot.data ?? [];
              return Stack(
                children: [
                  CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: CommonUtils.getDeviceHeight(context),
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                          _isButtonVisible = index == 4? true: false;
                        });
                      },
                    ),
                    items: data.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(i.image),
                                //whatever image you can put here
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _isButtonVisible? Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: ()=>{
                                moveToLoginPage()
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,// You can use like this way or like the below line
                                  //borderRadius: new BorderRadius.circular(30.0),
                                  color: AppColors.red,
                                ),
                                //child:const  Text("cvc", style:  TextStyle(color: Colors.white, fontSize: 50.0)),
                                child: const Icon(Icons.arrow_forward, size: 25.0, color: AppColors.black),
                              ),
                            ),
                          ): const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: data.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness == Brightness.dark
                                          ? Colors.red
                                          : Colors.yellow)
                                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
    );
  }

  Future<List<WelcomeItem>> readJson() async {
    final String response = await rootBundle.loadString('assets/welcome.json');
    final data = await json.decode(response) as List;
    final welcomeItems =
        data.map((item) => WelcomeItem.fromJson(item)).toList();
    return welcomeItems;
  }

  moveToLoginPage(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder:
            (context) =>
         AuthenticationPage()
        )
    );
  }
}
