import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<Test> with SingleTickerProviderStateMixin{

  TextEditingController textController = TextEditingController();
  final APIKEY  = "3b34b50322e1f7ca8e68e085ef754a9d";
  var search = false;
  var searchValue = "";
  var previousSearchValue = "";


  @override
  void initState() {
    super.initState();
    textController.addListener((){
      if(previousSearchValue != textController.text) {
        setState(() {
          searchValue = textController.text;
        });
        previousSearchValue = textController.text;
      }
    });
  }

  @override
   void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: search ? TextField(
          controller: textController,
          decoration: InputDecoration(
          hintText: "Type a text...",
        ),) : Text("THE MOVIE DATABASE"),
        leading: IconButton(icon: Icon(Icons.search), onPressed: _ToggleSearchBar),
      ),
      body: SearchResult(search: searchValue),
    );
  }

  _ToggleSearchBar(){
    setState(() {
      search = !search;
    });
  }


}


class SearchResult extends StatefulWidget{
  final search;

  SearchResult({Key key, @required this.search});

  @override
  State<StatefulWidget> createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult> {

  final APIKEY  = "3b34b50322e1f7ca8e68e085ef754a9d";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> datas = widget.search != "" ? _getDatas(widget.search) : null;

    return
      FutureBuilder(
          future: datas,
          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else{
              if (!snapshot.hasData) {
                return Center(child: Text('no data'));
              }else{
                return GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 2.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,i){
                      return  snapshot.data[i]['poster_path'] != null ? Image(image: NetworkImage(_getImageFromApi(snapshot.data[i]['poster_path']))) :
                      Center(child: Text('Nothing'));
                    });
              }
            }
          }
          );
      }


  _getUrl(APIKEY,text){
    return "https://api.themoviedb.org/3/search/movie?api_key=${APIKEY}&language=fr&query=${text}";
  }

  Future<dynamic> _getDatas(text) async{
    final response = await http.get(_getUrl(APIKEY, text));
    if(response.statusCode == 200){
      List<dynamic> datas = (json.decode(response.body))['results'];
      return datas;
    }
  }

  _getImageFromApi (name) {
    return 'https://image.tmdb.org/t/p/w300' + name;
  }

}