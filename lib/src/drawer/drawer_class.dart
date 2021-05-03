import 'package:flutter/material.dart';

class DrawerClass extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Text('Stocks'),
          ),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/dashboard');
            }),
        ListTile(
          title: Text('My Portfolio'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/portfolio');
          },
        ),
        ListTile(
          title: Text('Live Shares'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/liveShares');
          },
        ),
        ListTile(
          title: Text('My WatchList'),
          onTap: () {},
        ),
      ],
    ));
  }
}
