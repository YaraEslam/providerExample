import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/bloc/BlocBase.dart';
import 'package:provider_example/bloc/Register_bloc.dart';
import 'package:provider_example/provider/provider.dart';
import 'package:provider_example/model/Register_data.dart';
import 'package:provider_example/screens/googleMap.dart';
import 'package:provider_example/utils/constants.dart';

enum FormType{
  login, register
}

Widget createRegisterPage() {
  return
    BlocProvider<Register_bloc>(
        bloc: Register_bloc(),
        child: LoginRegister()
        );
}

class LoginRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginRegisterState();
  }
}

class LoginRegisterState extends State<LoginRegister> {

  final formKey = new GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Register_bloc register_bloc = Register_bloc();
  Provide provider = Provide();

  valid(){
    if (emailController.text.isEmpty) {
      provider.setValidEmail(true);
    }else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text.trim())) {
      provider.setValidEmail(true);
    }
    else{
      provider.setValidEmail(false);
    }

    if (passwordController.text.isEmpty) {
      provider.setValidPassword(true);
    } else{
      provider.setValidPassword(false);
    }
  }

  void _register() async {

    valid();
    if(provider.email  == false && provider.password == false){
      // api register
      Register register = await register_bloc.getRegister(emailController.text.trim(), passwordController.text.trim());
      if(register.success){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Google_Maps(),));
      }
    }
    print("true register");

  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Provide>(context);
    register_bloc = BlocProvider.of<Register_bloc>(context);
    return Scaffold(
        body: _layout()
    );
  }

  Widget _layout() {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 20.0,right: 10.0,left: 10.0, bottom: 10.0),
              child: Text(provider.formType == FormType.login?"Login":"Sign Up",
                style: TextStyle(
                  color: Constants.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),textAlign: TextAlign.center,)
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
            child: new TextField(
              controller: emailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Email",
                errorText: provider.email
                    ? "Enter Email"
                    : null,
                icon: new Icon(Icons.email),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
            child: new TextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                errorText: provider.password
                    ? "Enter Password"
                    : null,
                icon: new Icon(Icons.lock),
              ),
            ),
          ),
          createButtons()
        ],
      ),
    );
  }

  Widget createButtons(){
    if(provider.formType == FormType.login){
      return registerLogin("Login", "Don't have an account. ", "Sign Up");

    }else{
      return registerLogin("Sign Up", "Have an account? ", "Login");
    }
  }

  registerLogin(String type, String status, String otherType){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
          child: RaisedButton(
              child: new Text(
                type,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontSize: 25.0,
                ),
              ),
              onPressed: () {
                _register();
              },
              color: Constants.red,
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: new Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 16.0),
                child: new Text(
                    status,
                    style: new TextStyle(
                        fontSize: 15.0, color: Colors.grey)),
              ),
              new Padding(
                  padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
                  child: new InkWell(
                    onTap: () {
                      (type == "Login")? moveToRegister():moveToLogin();
                    },
                    child: new Text(
                      otherType,
                      style: new TextStyle(
                        color: Constants.red,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )),
            ],
          )
        )
      ],
    );
  }

  moveToLogin(){
    formKey.currentState.reset();
    provider.setFormType(FormType.login);
  }

  moveToRegister(){
    formKey.currentState.reset();
    provider.setFormType(FormType.register);
  }

}