import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_example/screens/login.dart';


class Provide with ChangeNotifier {
  bool email = false,
      password = false;

  FormType formType = FormType.login;
  MapType currentMapType = MapType.normal;

  void setValidEmail(value) {
    email = value;
    notifyListeners();
  }

  void setValidPassword(value) {
    password = value;
    notifyListeners();
  }

  void setFormType(value){
    formType = value;
    notifyListeners();
  }

  void setMapType(value){
    currentMapType = value == MapType.normal
        ? MapType.satellite
        : MapType.normal;
    notifyListeners();
  }
}