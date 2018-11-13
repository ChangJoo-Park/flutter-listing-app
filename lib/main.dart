import 'package:flutter/material.dart';

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
  int _counter = 0;

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
        onPressed: () {
          pushWithModal(NearMeWidget());
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
            ListTile(
              contentPadding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              leading: Image.network(
                'https://images.unsplash.com/photo-1542091934-0f2075cd3433?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=65c33f5a7864882a76f1c3dcb5802316&auto=format&fit=crop&w=658&q=80',
                width: 60,
                height: 60,
              ),
              title: Text('Hello World'),
              subtitle: Text('Subtitle'),
              onTap: () => {},
              onLongPress: () => {},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              leading: Image.network(
                'https://images.unsplash.com/photo-1542091934-0f2075cd3433?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=65c33f5a7864882a76f1c3dcb5802316&auto=format&fit=crop&w=658&q=80',
                width: 60,
                height: 60,
              ),
              title: Text('Hello World'),
              subtitle: Text('Subtitle'),
              onTap: () => {},
              onLongPress: () => {},
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

class NearMeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Near Me'),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
