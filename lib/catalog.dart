import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class Catalog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CatalogState();
}

class CatalogState extends State<Catalog>{

  final _articles = [
    {"id":0,"name": "Flutter"},
    {"id":1,"name": "React-native"},
    {"id":2,"name": "Xamarin"},
    {"id":3,"name": "Ionic"},
    {"id":4,"name": "Java"},
    {"id":5,"name": "Kotlin"},
    {"id":6,"name": "Swift"},
    {"id":7,"name": "Objective C"}
    ];

  final _validate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Catalog',style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Container(),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            Navigator.of(context).pushNamed('/cart');
          },)
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context,cart,child){
          return Center(
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: _articles.length,
              itemBuilder: (context,i){
                return ListTile(
                  title: Row(
                    children: <Widget>[
//                 // CustomPaint(painter: RectangleShape(colorValue: 15.0, height: 10.0, width: 10.0)),
                      Text("${_articles[i]['name']}"),
                    ],
                  ),
                  trailing: cart.cart.indexOf(_articles[i]) == -1 ?
                  RaisedButton(
                    child: Text("ADD",style: TextStyle(fontSize: 12)),
                    focusColor: Color.fromRGBO(255, 217, 85, 1),
                    onPressed: () => _addInCart(i, cart),
                    color: Colors.white,
                  ) :
                  IconButton(
                    icon: Icon(Icons.check,color: Colors.green),
                    onPressed: () => _addInCart(i,cart),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  _addInCart(i,cart){
    cart.add(_articles[i]);
  }
}

class RectangleShape extends CustomPainter{
  final colorValue;
  final height;
  final width;

  RectangleShape({this.colorValue,this.height,this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Color.fromRGBO(this.colorValue, this.colorValue, this.colorValue, 1);
    final rect = Rect.fromLTWH(0, 0, this.width, this.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

}
