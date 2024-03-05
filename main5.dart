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
      home: const MyHomePage(title: 'Course List'),
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
  final List<String> items = [
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
    "CIS 4935",
  ];

  bool endToStart = false;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _removeItem(int index) {
    if (items.length > index) {
      final temp = items[index];
      _listKey.currentState?.removeItem(
        index,
        (context, animation) {
          return _buildListItem(temp, animation);
        },
        duration: const Duration(seconds: 0),
      );
      setState(() {
        items.removeAt(index);
      });
    }
  }

  void _restore() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    for (int i = items.length - 1; i >= 0; i--) {
      final item = items[i];
      _listKey.currentState?.removeItem(i, (context, animation) {
        return _buildListItem(item, animation);
      }, duration: const Duration(seconds: 0));
    }

    setState(() {
      items.clear();
      items.addAll([
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
        "CIS 4935",
      ]);
    });

    for (int i = 0; i < items.length; i++) {
      _listKey.currentState?.insertItem(
        i,
        duration: const Duration(seconds: 0),
      );
    }
  }

  Widget _buildListItem(String item, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: endToStart ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: ListTile(
        title: Text(item,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: items.length,
        itemBuilder: (context, index, animation) {
          return Dismissible(
            key: ValueKey(items[index]),
            onDismissed: (direction) {
              String temp = items[index];
              _removeItem(index);
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  endToStart = true;
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Delete $temp'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      _listKey.currentState?.insertItem(index,
                          duration: const Duration(seconds: 1));
                      setState(() {
                        items.insert(index, temp);
                      });
                    },
                  ),
                ));
              } else {
                setState(() {
                  endToStart = false;
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Archive $temp'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      _listKey.currentState?.insertItem(index,
                          duration: const Duration(seconds: 1));
                      setState(() {
                        items.insert(index, temp);
                      });
                    },
                  ),
                ));
              }
            },
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
            child: _buildListItem(items[index], animation),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _restore,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
