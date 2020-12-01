import 'package:dio/dio.dart';
import 'package:provider_example/API/api.dart';
import 'package:provider_example/model/Register_data.dart';


class Register_Service {
  Dio dio_client = Dio_Api.getClient();

  Future<Register> Fetch_registerData(String email, String password
      ) async {

    FormData formData1 = new FormData();

    formData1=FormData.fromMap({
      'email': email,
      'password' : password,
    });

    try {
      dio_client.options.headers = {
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };

      Response response =
      await dio_client.post("https://providerexample.getsandbox.com/register", data: formData1);

      if (response.statusCode == 200) {
        return Register.fromJson(response.data);
      } else {
        return new Register();
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
