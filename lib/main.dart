import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo To do'),
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
  final List<Map<String, dynamic>> _items = [
    {'text': 'todo1', 'checked': false},
    {'text': 'todo2', 'checked': true},
    {'text': 'todo3', 'checked': false},
  ];

  void _navigateToAddItemPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddItemPage()),
    );
  
    if (result != null) {
      setState(() {
        // Ensure that 'result' is a String before adding it to '_items'
        if (result is String) {
          _items.add({'text': result, 'checked': false});
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Container(
              color: _items[index]['checked'] ? Colors.green : Theme.of(context).colorScheme.primaryContainer,
              padding: const EdgeInsets.all(16),
              child: Text(_items[index]['text']),
            ),
            value: _items[index]['checked'],
            onChanged: (bool? value) {
              setState(() {
                _items[index]['checked'] = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddItemPage,
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add To do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Item',
                  labelStyle: TextStyle(
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20), // Add some space between the fields
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _controller.text);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red, // foreground color
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}