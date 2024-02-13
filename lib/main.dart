import 'dart:io';

import 'package:flutter/material.dart';

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
    CalculatorScreen(),
    ImageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Color.fromARGB(126, 176, 250, 211),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              title: Text('Calculator'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              title: Text('Image'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.image,
            size: 100,
            color: Colors.blue,
          ),
          Text(
            'Image',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.all(16),
              child: Image.file(File(
                  'C:/Users/hp/Documents/m0bile/tab_proj/assets/images/a.png'))),
        ],
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

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  double _result = 0;
  String _operator = '';
  double _lastNumber = 0;

  void _clear() {
    setState(() {
      _expression = '';
      _result = 0;
      _operator = '';
      _lastNumber = 0;
    });
  }

  void _append(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _chooseOperator(String operator) {
    if (_operator.isNotEmpty) {
      _calculate();
    }
    _operator = operator;
    _lastNumber = _result;
    _expression = '';
  }

  void _calculate() {
    switch (_operator) {
      case '+':
        setState(() {
          _result = _lastNumber + double.parse(_expression);
        });
        break;
      case '-':
        setState(() {
          _result = _lastNumber - double.parse(_expression);
        });
        break;
      case '*':
        setState(() {
          _result = _lastNumber * double.parse(_expression);
        });
        break;
      case '/':
        if (double.parse(_expression) == 0) {
          return;
        }
        setState(() {
          _result = _lastNumber / double.parse(_expression);
        });
        break;
    }
    _expression = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              _expression == '' ? 'Enter expression' : _expression,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Result: $_result',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _clear,
                child: Text('AC'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  _chooseOperator('+/-');
                },
                child: Text('+/-'),
              ),
              ElevatedButton(
                onPressed: () {
                  _chooseOperator('%');
                },
                child: Text('%'),
              ),
              ElevatedButton(
                onPressed: () {
                  _chooseOperator('=');
                },
                child: Text('='),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _append('7');
                },
                child: Text('7'),
              ),
              ElevatedButton(
                onPressed: () {
                  _append('8');
                },
                child: Text('8'),
              ),
              ElevatedButton(
                onPressed: () {
                  _append('9');
                },
                child: Text('9'),
              ),
              ElevatedButton(
                onPressed: () {
                  _chooseOperator('*');
                },
                child: Text('X'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _append('4');
                },
                child: Text('4'),
              ),
              ElevatedButton(
                onPressed: () {
                  _append('5');
                },
                child: Text('5'),
              ),
              ElevatedButton(
                onPressed: () {
                  _append('6');
                },
                child: Text('6'),
              ),
              ElevatedButton(
                onPressed: () {
                  _chooseOperator('/');
                },
                child: Text('/'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _append('1');
                },
                child: Text('1'),
              ),
              ElevatedButton(
                onPressed: () {
                  _append('2');
                },
                child: Text('2'),
              ),
              ElevatedButton(
                onPressed: () {
                  _append('3');
                },
                child: Text('3'),
              ),
              ElevatedButton(
                onPressed: () {
                  _chooseOperator('+');
                },
                child: Text('+'),
              ),
            ],
          ),
        ]);
  }
}
