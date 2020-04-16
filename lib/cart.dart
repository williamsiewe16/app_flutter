import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class Cart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CartState();
}

class CartState extends State<Cart>{
  final _cart = [
    {"name": "Flutter"},
    {"name": "React-native"},
    {"name": "Xamarin"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: screenWidth,
        color: Color.fromRGBO(255, 217, 85, 1),
          child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(screenWidth/20),
                  child: Container(
                    height: 6.8*screenWidth/7,
                    alignment: Alignment.topLeft, child: Consumer<CartModel>(
                    builder: (context,cart,child){
                      return _list(cart);
                    },
                  ),
                ),
                ),
                Divider(thickness: 3, color: Colors.black),
                Container(
                    height: screenWidth/2.28,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _displayTotalPrice(254),
                      RaisedButton(child: Text("BUY"),color: Colors.white, onPressed: (){

                      },)
                    ],
                  )
                )
              ],
            ),
        ),
    );
  }

  _deleteFromCart(i,cart){
    cart.remove(i);
  }

  _list(cart){
    return ListView.builder(
      itemCount: cart.cart.length,
      itemBuilder: (context,i){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(cart.cart[i]['name']),
            IconButton(icon: Icon(Icons.restore_from_trash), onPressed: (){
              _deleteFromCart(i, cart);
            },)
          ],
        );
      },
    );
  }

  _displayTotalPrice(price){
    return Consumer<CartModel>(
      builder: (context,cart,child){
        return Padding(
            child: Text(cart.totalPrice.toString(),style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            padding: EdgeInsets.only(right: 10)
        );
      },
    );
  }
}