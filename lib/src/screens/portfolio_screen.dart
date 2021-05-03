import 'package:flutter/material.dart';
import '../blocs/shares_provider.dart';
import '../drawer/drawer_class.dart';

class Portfolio extends StatelessWidget {
  Widget build(context) {
    final _bloc = SharesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Portfolio'),
      ),
      drawer: DrawerClass(),
      body: body(_bloc),
      floatingActionButton: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget body(_bloc) {
    return Text('portfolio');
  }
}
