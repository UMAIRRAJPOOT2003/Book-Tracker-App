import 'package:booktracker/screens/favorites.dart';
import 'package:booktracker/screens/homescreen.dart';
import 'package:booktracker/screens/saved.dart';
import 'package:flutter/material.dart';

import 'Network/network.dart';
import 'models/bookmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentindex = 0;


  final List<Widget> _screens = [
    const homescreen(),
    const SavedPage(),
    const FavoritePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        title: Text(
          "Book Buddy",
          style: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 45,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Align(
        alignment:Alignment.center,
        child: Container(
          color: Colors.black,
          width: double.infinity,
          height: double.infinity,
          child: _screens[_currentindex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
        ],
        onTap: (value) {
          setState(() {
            _currentindex = value;
          });
        },
      ),
    );
  }
}
