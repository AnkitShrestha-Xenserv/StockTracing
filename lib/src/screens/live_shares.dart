import 'package:flutter/material.dart';
import '../blocs/shares_provider.dart';
import '../models/item_model.dart';
import '../drawer/drawer_class.dart';
import '../widgets/list_widget.dart';

class LiveShares extends StatelessWidget {
  Widget build(BuildContext context) {
    final _bloc = SharesProvider.of(context);
    return Scaffold(
      drawer: DrawerClass(),
      appBar: AppBar(
        title: Text('Live Shares'),
      ),
      body: _body(_bloc),
    );
  }

  Widget _body(SharesBloc _bloc) {
    return StreamBuilder(
        stream: _bloc.shares,
        builder: (context, AsyncSnapshot<List<ItemModel>> snapshot) {
          if (!snapshot.hasData) {
            return Text('Still Loading Data');
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final item = snapshot.data[index];
                return buildTable(item);
              });
        });
  }
}
