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
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  bool isAble = false;

  void _incrementCounter() {
    setState(() {
      
      if (_counter >= 0) {
        isAble = true;
      } else {
        isAble = false;
      }
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      
      if (_counter <= 0) {
        isAble = false;
      } else {
        _counter--;
        if (_counter <= 0) {
          isAble = false;
        }
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
              decoration: BoxDecoration(color: Colors.yellow),
              child: Text('Counter Options'),
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Add'),
              onTap: () {
                _incrementCounter();
              },
            ),
            ListTile(
                leading: const Icon(Icons.remove_circle_outline),
                title: const Text('Subtract'),
                enabled: isAble,
                onTap: () {
                  _decrementCounter();
                }),
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
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
