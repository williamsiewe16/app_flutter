import 'package:BDE_App/cart.dart';
import 'package:BDE_App/catalog.dart';
import 'package:BDE_App/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:BDE_App/map.dart';
import 'test.dart';

void main(){
  runApp(
      ChangeNotifierProvider(
        create: (context) => numModel(),//CartModel(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primaryColor: Color.fromRGBO(255, 217, 85, 1),
      ),
      title: 'TestApp',
      routes: {
        '/login': (context) => Login(),
        '/catalog': (context) => Catalog(),
        '/cart': (context) => Cart(),
        '/map': (context) => Map(),
        '/test': (context) => Test(),
        '/a': (context) => A(),
        '/b': (context) => B(),
      },
      initialRoute: '/a',
    );
  }
}


class A extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('A'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            Navigator.of(context).pushNamed('/b');
            })
        ],
      ),
        body: Consumer<numModel>(
          builder: (context,num,child){
            return Padding(
              padding: EdgeInsets.all(screen_width/7),
              child: Column(
                children: <Widget>[
                  Center(child: Text(num.getValue().toString())),
                  RaisedButton(child: Text('increase'), onPressed: (){num.increase();}),
                  RaisedButton(child: Text('decrease'), onPressed: (){num.decrease();})
                ],
              ),
            );
          }
        )
      );
  }
}

class B extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B'),
      ),
      body: Consumer<numModel>(
        builder: (context,num,child){
          return Center(
            child: Text(num.getValue().toString()),
          );
        },
      ),
    );
  }
}

class numModel extends ChangeNotifier{
  var value = 0;

  int getValue(){
    return value;
  }

  void increase(){
    value++;
    notifyListeners();
  }

  void decrease(){
    value--;
   notifyListeners();
  }
}

class CartModel extends ChangeNotifier{
  final cart = [];
  int get totalPrice => cart.length*42;

  void add(item){
    cart.add(item);
    notifyListeners();
  }

  void remove(index){
    cart.removeAt(index);
    notifyListeners();
  }

  void removeAll(){
    cart.clear();
    notifyListeners();
  }
}