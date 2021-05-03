import 'package:flutter/material.dart';
import 'shares_bloc.dart';
export 'shares_bloc.dart';

class SharesProvider extends InheritedWidget {
  final SharesBloc bloc;
  SharesProvider({Key key, Widget child})
      : bloc = SharesBloc(),
        super(key: key, child: child);
  bool updateShouldNotify(_) => true;

  static SharesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<SharesProvider>()).bloc;
  }
}
