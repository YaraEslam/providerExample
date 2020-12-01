
import 'package:provider_example/model/Register_data.dart';
import 'package:provider_example/services/Register_Service.dart';


class Repository_Handler{

  final register_Service = Register_Service();

  Future<Register> Fetch_registerData(String email, String password) =>
      register_Service.Fetch_registerData( email, password);
}

