import 'dart:async';

import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    final screen_width = MediaQuery.of(context).size.width;

     return Scaffold(key: _scaffoldKey,
       body: Form(key: _formKey,
         child: Padding(
           padding: EdgeInsets.all(screen_width/7),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
                 Text('Welcome', style: TextStyle(fontWeight: FontWeight.bold, fontSize: screen_width/15),),
                 TextFormField(
                   decoration: InputDecoration(
                     suffixIcon: IconButton(icon: Icon(Icons.person),onPressed: (){}),
                     labelText: "login",
                     ),
                   validator: (value){
                     return(value.isEmpty ? 'Ce champ doit être rempli': null);
                   },
                 ),
                 TextFormField(
                     obscureText: visible,
                     decoration: InputDecoration(
                       suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                         setState(() {
                          visible = !visible;
                         });
                       },),
                       labelText: "password",
                     ),
                   validator: (value){
                     return(value.isEmpty ? 'Ce champ doit être rempli': null);
                   }
                 ),
                  Container(
                     margin: EdgeInsets.all(screen_width/10),
                     child: RaisedButton(child: Text('ENTER'), color: Color.fromRGBO(255, 217, 85, 1),
                       onPressed: (){
                         final validate = _validate();
                         if(validate) _goToNextRoute(context);
                       },
                   ),
                 ),
               ],
             ),
         ),
       ),
     );
  }

  _validate(){
    bool validate = _formKey.currentState.validate();
      _showSnackbar(validate);
      return validate;
  }

  _showSnackbar(bool validate){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(validate ? 'Formulaire valide' : 'Formulaire invalide'),
      backgroundColor: validate ? Colors.green : Colors.red,
    ));
  }

  _goToNextRoute(context){
    const duration = Duration(seconds: 1);
    return Timer(duration,(){
      Navigator.of(context).pushNamed('/catalog');
    });
  }
}