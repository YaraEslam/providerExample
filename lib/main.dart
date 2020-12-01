import 'package:flutter/material.dart';
import 'package:provider_example/provider/provider.dart';
import 'package:provider_example/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Provide>(
      create: (_) => Provide(),
      child: MaterialApp(
        home: createRegisterPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}