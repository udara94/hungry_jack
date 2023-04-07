import 'package:flutter/material.dart';
import 'package:hungry_jack/resources/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.fbBlue,
        child: const Center(child: Text("home page", style: TextStyle(fontSize: 30),)),
      ),
    );
  }
}
