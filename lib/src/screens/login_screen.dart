import 'package:flutter/material.dart';
import '../blocs/credentials_provider.dart';

class LoginScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = CredentialsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              idField(bloc),
              passwordField(bloc),
              Container(margin: EdgeInsets.only(top: 25)),
              buttons(bloc, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget idField(CredentialsBloc bloc) {
    return StreamBuilder(
        stream: bloc.id,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changeId,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter you UserID',
              labelText: 'User ID',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget passwordField(CredentialsBloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
            hintText: 'Enter you Password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget buttons(CredentialsBloc bloc, context) {
    return Row(
      children: <Widget>[
        submitButton(bloc, context),
        Container(margin: EdgeInsets.only(left: 25)),
        registerButton(context),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget submitButton(CredentialsBloc bloc, context) {
    return RaisedButton(
      onPressed: () {
        bloc.login(context);
      },
      child: Text('Login'),
      color: Colors.blue,
      disabledColor: Colors.grey,
    );
  }

  Widget registerButton(context) {
    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Text('Register'),
      color: Colors.blue,
      disabledColor: Colors.grey,
    );
  }
}
