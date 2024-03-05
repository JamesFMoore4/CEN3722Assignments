import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isAble1 = false;
  bool _isAble5 = false;
  bool _isAble20 = false;

  void _changeCounter(int _amount) {
    setState(() {
      _counter = _counter + _amount;
      if (_counter <= 0) {
        _isAble1 = false;
        _isAble5 = false;
        _isAble20 = false;
      } else if (_counter > 0 && _counter < 5) {
        _isAble1 = true;
        _isAble5 = false;
        _isAble20 = false;
      } else if (_counter >= 5 && _counter < 20) {
        _isAble1 = true;
        _isAble5 = true;
        _isAble20 = false;
      } else {
        _isAble1 = true;
        _isAble5 = true;
        _isAble20 = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text('Counter Options'),
            ),
            ExpansionTile(
              title: Text('Add...'),
              leading: const Icon(Icons.add_circle_outline),
              children: <Widget>[
                ListTile(
                  title: Text('+1'),
                  leading:
                      const Icon(Icons.add_circle_outline, color: Colors.green),
                  enabled: true,
                  onTap: () {
                    _changeCounter(1);
                  },
                ),
                ListTile(
                  title: Text('+5'),
                  leading:
                      const Icon(Icons.add_circle_outline, color: Colors.green),
                  enabled: true,
                  onTap: () {
                    _changeCounter(5);
                  },
                ),
                ListTile(
                  title: Text('+20'),
                  leading:
                      const Icon(Icons.add_circle_outline, color: Colors.green),
                  enabled: true,
                  onTap: () {
                    _changeCounter(20);
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Subtract...'),
              leading: const Icon(Icons.remove_circle_outline),
              children: <Widget>[
                ListTile(
                  title: Text('-1'),
                  iconColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }
                    return Colors.red;
                  }),
                  leading: const Icon(Icons.remove_circle_outline),
                  enabled: _isAble1,
                  onTap: () {
                    _changeCounter(-1);
                  },
                ),
                ListTile(
                  title: Text('-5'),
                  iconColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }
                    return Colors.red;
                  }),
                  leading: const Icon(Icons.remove_circle_outline),
                  enabled: _isAble5,
                  onTap: () {
                    _changeCounter(-5);
                  },
                ),
                ListTile(
                  title: Text('-20'),
                  iconColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }
                    return Colors.red;
                  }),
                  leading: const Icon(Icons.remove_circle_outline),
                  enabled: _isAble20,
                  onTap: () {
                    _changeCounter(-20);
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.arrow_circle_left),
              title: const Text('Close Menu'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Counter:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
