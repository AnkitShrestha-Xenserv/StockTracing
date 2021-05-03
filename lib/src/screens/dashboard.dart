import 'package:flutter/material.dart';
import '../blocs/shares_provider.dart';
import '../drawer/drawer_class.dart';
import '../models/item_model.dart';
import '../widgets/list_widget.dart';

class Dashboard extends StatelessWidget {
  Widget build(context) {
    final _bloc = SharesProvider.of(context);
    return Scaffold(
      drawer: DrawerClass(),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: body(_bloc),
    );
  }

  Widget body(SharesBloc _bloc) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Text('Top Gainers'),
        StreamBuilder(
          stream: _bloc.topGainers,
          builder: (context, AsyncSnapshot<List<ItemModel>> topSnapshot) {
            if (!topSnapshot.hasData) {
              return Text('Loading Data');
            }
            return buildTables(topSnapshot);
          },
        ),
        Text('Top Losers'),
        StreamBuilder(
            stream: _bloc.topLosers,
            builder: (context, AsyncSnapshot<List<ItemModel>> bottomSnapshot) {
              if (!bottomSnapshot.hasData) {
                return Text('Loading Data');
              }
              return buildTables(bottomSnapshot);
            })
      ]),
    );
  }

  buildTables(snapshot) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 300,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              children: <Widget>[
                Expanded(
                    child: Text('Name',
                        style: TextStyle(
                          height: 3.0,
                          fontSize: 14.2,
                          fontWeight: FontWeight.bold,
                        ))),
                Expanded(
                    child: Text('Closing Price',
                        style: TextStyle(
                          height: 3.0,
                          fontSize: 14.2,
                          fontWeight: FontWeight.bold,
                        ))),
                Expanded(
                    child: Text('Traded Shares',
                        style: TextStyle(
                          height: 3.0,
                          fontSize: 14.2,
                          fontWeight: FontWeight.bold,
                        ))),
                Expanded(
                    child: Text('Difference',
                        style: TextStyle(
                          height: 3.0,
                          fontSize: 14.2,
                          fontWeight: FontWeight.bold,
                        ))),
              ],
            );
          }
          index -= 1;
          final item = snapshot.data[index];
          return buildTable(item);
        },
      ),
    );
  }
}
