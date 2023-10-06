import 'package:burmese_number/burmese_number.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Burmese Number'),
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
  TextEditingController numberController = TextEditingController();
  String longBurmesePlainText = "";
  String longBurmeseWithNumber = "";
  String simpleNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(hintText: "Enter a number"),
            ),
            const SizedBox(
              height: 28,
            ),
            Text(simpleNumber),
            const SizedBox(
              height: 28,
            ),
            Text(longBurmeseWithNumber),
            const SizedBox(
              height: 26,
            ),
            Text(longBurmesePlainText),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          longBurmesePlainText = BurmeseNumHelper.convertToLongNumber(
              number: numberController.text);
          longBurmeseWithNumber = BurmeseNumHelper.convertToLongNumber(
              number: numberController.text,
              numberFormat: NumberFormat.numberInText);
          simpleNumber = BurmeseNumHelper.convertToSimpleNumber(
              number: numberController.text);
          setState(() {});
        },
        child: const Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
