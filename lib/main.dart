import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(SodexoTracker());

class SodexoTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sodexo Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double saldo = 250.0;

  @override
  void initState() {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      setState(() {
        saldo = prefs.getDouble('saldo') ?? 250.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sodexo Tracker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Saldo: $saldo",
              style: TextStyle(fontSize: 32),
            ),
            Divider(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor da compra',
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (String val) {
                    SharedPreferences.getInstance()
                        .then((SharedPreferences prefs) {
                      setState(() {
                        saldo-=double.parse(val);
                        prefs.setDouble('saldo', saldo);
                      });
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
