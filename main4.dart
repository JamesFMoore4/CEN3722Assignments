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
  List<String> items = [
    "CGS 1540",
    "COP 2512",
    "COP 2513",
    "CIS 3213",
    "CGS 3303",
    "CIS 3363",
    "COP 3515",
    "CEN 3722",
    "CGS 3853",
    "CNT 4104",
    "CNT 4403",
    "COP 4538",
    "CNT 4603",
    "COP 4703",
    "CIS 4935"
  ];

  List<String> backup = [
    "CGS 1540",
    "COP 2512",
    "COP 2513",
    "CIS 3213",
    "CGS 3303",
    "CIS 3363",
    "COP 3515",
    "CEN 3722",
    "CGS 3853",
    "CNT 4104",
    "CNT 4403",
    "COP 4538",
    "CNT 4603",
    "COP 4703",
    "CIS 4935"
  ];

  void _restore() {
    setState(() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      items.clear();
      for (int i = 0; i < backup.length; i++) {
        items.add(backup[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        prototypeItem: ListTile(title: Text(items.first)),
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
                color: Colors.yellow,
                child: Row(children: [
                  const SizedBox(width: 20),
                  Text('Archive ${items[index]}'),
                ])),
            secondaryBackground: Container(
                color: Colors.red,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('Delete ${items[index]}'),
                  const SizedBox(width: 20),
                ])),
            key: ValueKey<String>(items[index]),
            onDismissed: (DismissDirection direction) {
              String temp = items[index];
              setState(() {
                items.removeAt(index);
              });
              if (direction == DismissDirection.endToStart) {
                final snackBar = SnackBar(
                  duration: const Duration(seconds: 10),
                  content: Text('$temp deleted'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        items.insert(index, temp);
                      });
                    },
                  ),
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                final snackBar = SnackBar(
                  duration: const Duration(seconds: 10),
                  content: Text('$temp archived'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        items.insert(index, temp);
                      });
                    },
                  ),
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: ListTile(
              title: Text(
                items[index],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _restore,
        tooltip: 'Increment',
        child: const Icon(Icons.replay),
      ), 
    );
  }
}
