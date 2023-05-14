import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:my_app/tuple2.dart';
import 'package:provider/provider.dart';

import 'models/light.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // var lights = <Light>[Light("toto", false)];
  var lights = <Light>[];

  void addLight() {
    final label = "light-${lights.length + 1}";
    lights.add(Light(label, lights.length % 2 == 0));
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = LightPage();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = Placeholder();
        break;
      case 4:
        page = Placeholder();
        break;
      case 5:
        page = Placeholder();
        break;
      case 6:
        page = Placeholder();
        break;
      case 7:
        page = Placeholder();
        break;
      case 8:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  Tuple2(Icons.home, 'Home'),
                  Tuple2(Icons.lightbulb, 'Lights'),
                  Tuple2(Icons.window, 'Windows'),
                ]
                    .map(
                      (e) => NavigationRailDestination(
                        icon: Icon(e.a),
                        label: Text(e.b),
                      ),
                    )
                    .toList(growable: false),
                //   NavigationRailDestination(
                //     icon: Icon(Icons.water),
                //     label: Text('Water'),
                //   ),
                //   NavigationRailDestination(
                //     icon: Icon(Icons.air),
                //     label: Text('Clim'),
                //   ),
                //   NavigationRailDestination(
                //     icon: Icon(Icons.local_fire_department),
                //     label: Text('Heat'),
                //   ),
                //   NavigationRailDestination(
                //     icon: Icon(Icons.router),
                //     label: Text('Internet'),
                //   ),
                //   NavigationRailDestination(
                //     icon: Icon(Icons.connected_tv),
                //     label: Text('TV'),
                //   ),
                //   NavigationRailDestination(
                //     icon: Icon(Icons.security),
                //     label: Text('Security'),
                //   ),
                // ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon = Icons.add;
    // if (appState.lights.contains(pair)) {
    //   icon = Icons.remove;
    // } else {
    //   icon = Icons.add;
    // }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.addLight();
                },
                icon: Icon(icon),
                label: Text('Add'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // appState.getOff();
                },
                icon: Icon(Icons.toggle_off),
                label: Text('Off'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Column(
      children: [
        Expanded(
          child: LightsView(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                appState.addLight();
              },
              icon: Icon(Icons.add),
              label: Text('Add'),
            ),
          ],
        ),
      ],
    );
  }
}

class LightsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.lights.isEmpty) {
      return Center(
        child: Text('No light yet!'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.lights.length} light:'),
        ),
        ...appState.lights
            .map((e) => ListTile(
                  leading: Icon(
                    Icons.lightbulb,
                    color: e.turn ? Colors.yellow : Colors.grey,
                  ),
                  title: Text(e.label),
                ))
            .toList()
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'light',
          style: style,
        ),
      ),
    );
  }
}
