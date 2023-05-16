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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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
        page = LightsPage();
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
                  Tuple2(Icons.water, 'Water'),
                  Tuple2(Icons.air, 'Clim'),
                  Tuple2(Icons.local_fire_department, 'Heat'),
                  Tuple2(Icons.router, 'Internet'),
                  Tuple2(Icons.connected_tv, 'TV'),
                  Tuple2(Icons.security, 'Security'),
                ]
                    .map(
                      (e) => NavigationRailDestination(
                        icon: Icon(e.a),
                        label: Text(e.b),
                      ),
                    )
                    .toList(growable: false),
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

class LightsPage extends StatelessWidget {
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
        ...appState.lights.map((e) => LightView(e)).toList()
      ],
    );
  }
}

class LightView extends StatefulWidget {
  late Light light;
  LightView(this.light, {super.key});

  @override
  State<LightView> createState() => _LightViewState(light);
}

class _LightViewState extends State<LightView> {
  Light light;

  _LightViewState(this.light);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          Icons.lightbulb,
          color: light.turn ? Colors.yellow : Colors.grey,
        ),
        title: Text(light.label),
        trailing: Switch(
            value: light.turn,
            onChanged: (bool value) {
              setState(() {
                light.toggleLight();
                print(value);
              });
            }));
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
