
import 'dart:async';

import 'package:provider_example/Repository/Repository_Handler.dart';
import 'package:provider_example/bloc/BlocBase.dart';
import 'package:provider_example/model/Register_data.dart';
import 'package:rxdart/rxdart.dart';

class Register_bloc implements BlocBase {
  Register _register;

  final _repository = Repository_Handler();

  final _registerFetcher = BehaviorSubject<Register>();

  Register_bloc();

  Stream<Register> get register_data => _registerFetcher.stream;


  @override
  void dispose() {
    _registerFetcher.close();
  }


  Future<Register> getRegister(String email, String password) async {
    _register = await _repository.Fetch_registerData( email, password);

    _registerFetcher.sink.add(_register);
    return _register;

  }

}