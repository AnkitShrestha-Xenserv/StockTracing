import 'package:flutter/material.dart';
import 'credentials_bloc.dart';
export 'credentials_bloc.dart';

class CredentialsProvider extends InheritedWidget {
  final CredentialsBloc bloc;

  CredentialsProvider({Key key, Widget child})
      : bloc = CredentialsBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CredentialsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CredentialsProvider>())
        .bloc;
  }
}
