import 'package:flutter/material.dart';
import 'package:page_state_handler/page_state_handler.dart';

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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  PageStateController pageStateController = PageStateController();

  void retry() async {
    pageStateController.onStateUpdate(PageState.loading);
    await Future.delayed(const Duration(seconds: 3));
    pageStateController.onStateUpdate(PageState.loaded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                pageStateController.onError('Something went wrong');
              },
              child: const Text('Error')),
          TextButton(
              onPressed: () {
                pageStateController.onStateUpdate(PageState.empty);
              },
              child: const Text('Empty')),
          TextButton(
              onPressed: () {
                pageStateController.onStateUpdate(PageState.loaded);
              },
              child: const Text('Loaded')),
          TextButton(
              onPressed: () {
                pageStateController.onStateUpdate(PageState.loading);
              },
              child: const Text('Loading'))
        ],
      ),
      body: PageStateHandler(
        controller: pageStateController,
        onRefresh: () => Future(() => retry()),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 40,
          itemBuilder: (context, index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              GestureDetector(
                onTap: _incrementCounter,
                child: Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
