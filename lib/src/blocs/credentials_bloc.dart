import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../resources/repository.dart';
import '../mixins/validation_mixin.dart';
import '../models/item_model.dart';

class CredentialsBloc {
  final _repository = Repository();
  final _validationMixin = ValidationMixin();

  final _idController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get id => _idController.stream;
  Stream<String> get password => _passwordController.stream;

  Function(String) get changeId => _idController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void register(
      int userId, String firstName, String lastName, String password) async {
    _repository.addUser(userId, firstName, lastName, password);
  }

  login(context) async {
    final _inputId = _idController.value;
    final _inputPassword = _passwordController.value;

    if (_inputId == null) {
      _idController.sink.addError('User ID cannot be empty');
      return;
    }
    if (_inputPassword == null) {
      _passwordController.sink.addError('Password cannot be empty');
      return;
    }
    final id = _validationMixin.validateUserId(_inputId.toString());
    if (!(id == null)) {
      _idController.addError(id);
      return;
    }

    final valid =
        await _repository.checkValidity(int.tryParse(_inputId), _inputPassword);
    if (valid) {
      Navigator.pushNamed(context, '/dashboard');
    } else {
      _idController.sink.addError('Invalid Id or Password');
      _passwordController.sink.addError('Invalid Id or Password');
    }
    return;
  }

  addToStock(List<ItemModel> items) {}

  addToWatchlist(List<ItemModel> items) {}

  void dispose() {
    _idController.close();
    _passwordController.close();
  }
}
