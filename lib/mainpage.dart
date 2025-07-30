import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:e_commerce/app_home_screen.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}
class _MainpageState extends State<Mainpage> {
  int selectedIndex=0;
  final List pages = [
   const AppHomeScreen(),
   const Scaffold(),
   const Scaffold(),
   const Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black12,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        elevation: 0,
        backgroundColor: Colors.white,
        onTap:(value){
          setState(() {
            selectedIndex = value;
          });
          //selectedIndex = value;

        } ,

         items:[
          BottomNavigationBarItem(
            icon:Icon(Iconsax.home),
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon:Icon(Iconsax.search_normal),
            label: "Search"
            ),
          BottomNavigationBarItem(
            icon:Icon(Iconsax.notification),
            label: "Notifications"
            ),
          BottomNavigationBarItem(
            icon:Icon(Icons.person_outline),
            label: "Profile"
            ),
         ]
    ),
    body: pages[selectedIndex],
    );
  }
}