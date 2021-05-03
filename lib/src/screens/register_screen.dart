import 'package:flutter/material.dart';
import '../blocs/credentials_provider.dart';
import '../mixins/validation_mixin.dart';

class RegisterScreen extends StatefulWidget {
  createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  int _userId = 0;
  String _firstName = '';
  String _lastName = '';
  String _password = '';

  Widget build(context) {
    final bloc = CredentialsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                firstNameField(),
                lastNameField(),
                userIdField(),
                passwordField(),
                Container(margin: EdgeInsets.only(top: 15)),
                submit(context, bloc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstNameField() {
    return TextFormField(
      onSaved: (String value) {
        _firstName = value;
      },
      validator: validateName,
      decoration: InputDecoration(
        hintText: 'Enter you First name',
        labelText: 'First name',
      ),
    );
  }

  Widget lastNameField() {
    return TextFormField(
      onSaved: (String value) {
        _lastName = value;
      },
      validator: validateName,
      decoration: InputDecoration(
        hintText: 'Enter you Last name',
        labelText: 'Last name',
      ),
    );
  }

  Widget userIdField() {
    return TextFormField(
      onSaved: (String value) {
        _userId = int.parse(value);
      },
      validator: validateUserId,
      decoration: InputDecoration(
        hintText: 'Enter your desired Id',
        labelText: 'User ID',
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget passwordField() {
    return TextFormField(
      onSaved: (String value) {
        _password = value;
      },
      validator: validatePassword,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        labelText: 'Password',
      ),
    );
  }

  Widget submit(context, CredentialsBloc bloc) {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          bloc.register(
            _userId,
            _firstName,
            _lastName,
            _password,
          );
          Navigator.pushNamed(context, '/login');
        }
      },
    );
  }
}
