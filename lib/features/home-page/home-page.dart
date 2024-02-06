import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  List<Widget> list = [

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Home Page"),
       ),
      body: Column(
        children: [],
      ),
    );
  }
}