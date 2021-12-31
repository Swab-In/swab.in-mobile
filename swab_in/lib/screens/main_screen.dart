import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swab_in/screens/komentar_screen.dart';
import '../widgets/main_drawer.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/home';

  MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _counter = 0;
  void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.setInt('counter', _counter);

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swab.In'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Kelompok B10',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // A button that navigates to a named route.
                  // The named route extracts the arguments
                  // by itself.
                  ElevatedButton(
                    onPressed: () {
                      // When the user taps the button,
                      // navigate to a named route and
                      // provide the arguments as an optional
                      // parameter.
                      Navigator.pushNamed(
                        context,
                        KomentarScreen.routeName,
                        arguments: KomentarArguments(title: "asu", pk: '2'),
                      );
                    },
                    child: const Text(
                        'Navigate to screen that extracts arguments'),
                  ),
                  // A button that navigates to a named route.
                  // For this route, extract the arguments in
                  // the onGenerateRoute function and pass them
                  // to the screen.
                  ElevatedButton(
                    onPressed: () {
                      // When the user taps the button, navigate
                      // to a named route and provide the arguments
                      // as an optional parameter.
                      Navigator.pushNamed(
                        context,
                        KomentarScreen.routeName,
                        arguments: KomentarArguments(
                          title: "test",
                          pk: '1',
                        ),
                      );
                    },
                    child: const Text(
                        'Navigate to a named that accepts arguments'),
                  ),
                ],
              ),
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
