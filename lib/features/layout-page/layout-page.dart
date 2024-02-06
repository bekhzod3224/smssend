import 'package:flutter/material.dart';
import 'package:send_sms_app/features/home-page/home-page.dart';
import 'package:send_sms_app/features/profile-page/profile.page.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentPageIndex = 0;
  List<Widget> list = [
    HomePage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.dashboard, color: Colors.blue,),
            icon: Icon(Icons.dashboard),
            label: 'Мои проекты',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: Colors.blue,),

            icon:  Icon(Icons.person),
            label: 'Мой аккаунт',
          ),
         
        ],
      ),
      body: list[currentPageIndex],
    );
  }
}