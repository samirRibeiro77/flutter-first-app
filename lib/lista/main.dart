import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sjr77_first_project/lista/post.dart';

class AppLista extends StatelessWidget {
  const AppLista({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App com lista',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const MyHomePage(title: 'Lista de posts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // var _itens = [];
  final _baseUrl = "https://jsonplaceholder.typicode.com";

  // _carregarList() {
  //   _itens = [];
  //   for (int i=1 ; i<21 ; i++) {
  //     var item = {
  //       "title": "Titulo item $i",
  //       "subtitle": "Um subtitulo legal pro item $i"
  //     };
  //
  //     _itens.add(item);
  //   }
  // }

  Future<List<Post>> _loadPosts() async {
    var url = Uri.parse("$_baseUrl/posts");
    var response = await http.get(url, headers: {"Access-Control-Allow-Origin": "true"});

    var responseBody = jsonDecode(response.body);
    List<Post> postList = [];

    for(var postJson in responseBody) {
      var post = Post.fromJson(postJson);
      print(post.toString());
      postList.add(post);
    }

    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder <List<Post>>(
          future: _loadPosts(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.done:
                if(!snapshot.hasError) {
                  var postList = snapshot.data ?? [];
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(postList[index].title),
                          subtitle: Text(postList[index].body),
                          leading: Text(postList[index].userId.toString()),
                        );
                      }
                  );
                }
                return Text("Error ${snapshot.error.toString()}");
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }
      ),
      /*Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: (){
                  print("Tap $index");
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(_itens[index]["title"]),
                          titlePadding: EdgeInsets.all(20),
                          content: Text(_itens[index]["subtitle"]),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  print("Selecionado sim para $index");
                                  Navigator.pop(context);
                                },
                                child: Text("Sim")
                            ),
                            TextButton(
                                onPressed: (){
                                  print("Selecionado não para $index");
                                  Navigator.pop(context);
                                },
                                child: Text("Não")
                            ),
                          ]
                        );
                      }
                  );
                },
                /*onLongPress: (){
                  print("LongPress $index");
                },*/
                title: Text(_itens[index]["title"]),
                subtitle: Text(_itens[index]["subtitle"]),
                leading: Icon(Icons.abc),
              );
            }
        ),
      );*/
    );
  }
}
