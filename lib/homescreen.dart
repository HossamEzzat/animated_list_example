import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Items in the list
  final _items = ["Item 0"];

  // The key of the list
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  // Add a new item to the list
  // This is trigger when the floating button is pressed
  void _addItem() {
    _items.insert(0, "Item ${_items.length + 1}");
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
  }

  // Remove an item
  // This is trigger when an item is tapped
  void _removeItem(int index, BuildContext context) {
    AnimatedList.of(context).removeItem(index, (_, animation) {
      return FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: SizedBox(
            height: 150,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 20),
              elevation: 10,
              color: Colors.red[400],
              child: const Center(
                child: Text("I am going away",
                    style: const TextStyle(fontSize: 28)),
              ),
            ),
          ),
        ),
      );
    }, duration: const Duration(seconds: 1));

    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('example two'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.plus_one_outlined),
          )
        ],
      ),
      body: AnimatedList(
        key: _key,
        initialItemCount: 1,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            key: UniqueKey(),
            position: Tween<Offset>(
              begin: const Offset(-1, -0.5),
              end: const Offset(0, 0),
            ).animate(animation),
            child: RotationTransition(
              turns: animation,
              child: SizeTransition(
                axis: Axis.vertical,
                sizeFactor: animation,
                child: SizedBox(
                  height: 150,
                  child: InkWell(
                    onTap: () => _removeItem(index, context),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      elevation: 10,
                      color: Colors.primaries[
                      (index * 100) % Colors.primaries.length][300],
                      child: Center(
                        child: Text(_items[index],
                            style: const TextStyle(fontSize: 28)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}