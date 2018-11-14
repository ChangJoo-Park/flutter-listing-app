import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Listing App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  bool _permission = false;
  String error;

  void pushWithModal(Widget nextWidget) {
    Navigator.push(
        context,
        MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return nextWidget;
          },
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Map<String, double> location;
          try {
            _permission = await _location.hasPermission();
            location = await _location.getLocation();
            error = null;
            pushWithModal(NearMe(location));
          } on PlatformException catch (e) {
            print('=============');
            print(e);
            print('=============');
            if (e.code == 'PERMISSION_DENIED') {
              error = 'Permission denied';
            } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
              error =
                  'Permission denied - please ask the user to enable it from the app settings';
            }
            location = null;
          }
        },
        tooltip: 'Near Me',
        elevation: 4.0,
        backgroundColor: Colors.blue,
        icon: Icon(Icons.near_me),
        label: Text('Near Me'),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.list),
                            title: Text('Hello World'),
                            onTap: () => {},
                          ),
                          ListTile(
                            leading: Icon(Icons.list),
                            title: Text('Hello World'),
                            onTap: () => {},
                          ),
                          ListTile(
                            leading: Icon(Icons.list),
                            title: Text('Hello World'),
                            onTap: () => {},
                          ),
                          ListTile(
                            leading: Icon(Icons.list),
                            title: Text('Hello World'),
                            onTap: () => {},
                          ),
                          ListTile(
                            leading: Icon(Icons.list),
                            title: Text('Hello World'),
                            onTap: () => {},
                          ),
                        ],
                      );
                    });
              },
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    pushWithModal(SearchWidget());
                  },
                ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    const List<Choice> choices = const <Choice>[
                      const Choice(title: 'Car', icon: Icons.directions_car),
                      const Choice(
                          title: 'Bicycle', icon: Icons.directions_bike),
                      const Choice(title: 'Boat', icon: Icons.directions_boat),
                      const Choice(title: 'Bus', icon: Icons.directions_bus),
                      const Choice(
                          title: 'Train', icon: Icons.directions_railway),
                      const Choice(title: 'Walk', icon: Icons.directions_walk),
                    ];
                    return choices.skip(2).map((Choice choice) {
                      return PopupMenuItem<Choice>(
                        value: choice,
                        child: Text(choice.title),
                      );
                    }).toList();
                  },
                ),
              ],
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: const Text(
                        'Music by Julie Gable. Lyrics by Sidney Stein'),
                    onTap: () => {},
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: const Text(
                        'Music by Julie Gable. Lyrics by Sidney Stein'),
                    onTap: () => {},
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle: const Text(
                        'Music by Julie Gable. Lyrics by Sidney Stein'),
                    onTap: () => {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
    );
  }
}

class NearMe extends StatefulWidget {
  Map<String, double> location;

  NearMe(this.location);

  @override
  State createState() => NearMeState(location);
}

class NearMeState extends State<NearMe> {
  GoogleMapController mapController;
  Map<String, double> location;

  NearMeState(this.location);

  @override
  void initState() {
    super.initState();
    print('===============');
    print(this.location);
    _initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void _initPlatformState() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQueryData.fromWindow(ui.window).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Near Me'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: size.width,
                      height: size.height - 80,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller.updateMapOptions(
        GoogleMapOptions(
          cameraPosition: CameraPosition(
            target:
                LatLng(this.location['latitude'], this.location['longitude']),
            zoom: 16.0,
          ),
        ),
      );
      mapController = controller;
    });
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
