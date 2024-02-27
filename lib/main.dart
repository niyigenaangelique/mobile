import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    HomeScreen(),
    ContactsScreen(),
    GalleryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openContacts() async {
    // Request permission to access contacts
    var status = await Permission.contacts.request();

    // Check if permission is granted
    if (status.isGranted) {
      // If permission is granted, retrieve the contacts
      Iterable<Contact> contacts = await ContactsService.getContacts();
      // Now you have access to the contacts, you can use them as needed
      print(contacts);
    } else {
      // Handle the case where permission is denied
      // You might want to display a message to the user or handle it in another way
      print('Permission to access contacts was denied');
    }
  }

  void _openGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // You have the picked image file, you can now do whatever you want with it
      // For example, display it in an Image widget or upload it to a server
      print(pickedFile.path);
    }
  }

  void _openCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // You have the picked image file, you can now do whatever you want with it
      // For example, display it in an Image widget or upload it to a server
      print(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Android'),
      ),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Gallery',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Niyigena Angelique'),
              accountEmail: Text('angelbrenna20@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/profile_picture.jpg'), // Placeholder image
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0); // Navigate to the corresponding screen
              },
            ),
            ListTile(
              title: Text('Contacts'),
              onTap: () async {
                Navigator.pop(context);
                var status = await Permission.contacts.request();
                if (status.isGranted) {
                  _openContacts();
                } else {
                  // Handle permission denied
                }
              },
            ),
            ListTile(
              title: Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                var status = await Permission.photos.request();
                if (status.isGranted) {
                  _openGallery();
                } else {
                  // Handle permission denied
                }
              },
            ),
            ListTile(
              title: Text('Upload Profile Picture'),
              onTap: () {
                Navigator.pop(context);
                _openGallery();
              },
            ),
            ListTile(
              title: Text('Use Camera'),
              onTap: () {
                Navigator.pop(context);
                _openCamera();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.home,
            size: 100,
            color: Colors.blue,
          ),
          Text(
            'Home',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.contacts,
            size: 100,
            color: Colors.blue,
          ),
          Text(
            'Contacts',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.photo,
            size: 100,
            color: Colors.blue,
          ),
          Text(
            'Gallery',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
