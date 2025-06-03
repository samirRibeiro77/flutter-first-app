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
      postList.add(Post.fromJson(postJson));
    }

    return postList;
  }

  Future<int> _post() async {
    Post post = Post(77, "Titulo SJR77", "Descrição SJR77");
    var body = jsonEncode(post.toJson());

    var url = Uri.parse("$_baseUrl/posts");
    var response = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "true",
          "Content-type": "application/json; charset=UTF-8"
        },
        body: body
    );

    print("Salvar: ${response.statusCode} // ${response.body}");
    return response.statusCode;
  }

  Future<int> _put() async {
    Post post = Post(77, "Titulo alterado (put) SJR77", "Descrição alterada (put) SJR77");
    var body = jsonEncode(post.toJson());

    var url = Uri.parse("$_baseUrl/posts/1");
    var response = await http.put(
        url,
        headers: {
          "Access-Control-Allow-Origin": "true",
          "Content-type": "application/json; charset=UTF-8"
        },
        body: body
    );

    print("Atualizar (put): ${response.statusCode} //  ${response.body}");
    return response.statusCode;
  }

  Future<int> _patch() async {
    var body = jsonEncode(
        {
          "title": "Titulo alterado SJR77"
        }
    );

    var url = Uri.parse("$_baseUrl/posts/1");
    var response = await http.patch(
        url,
        headers: {
          "Access-Control-Allow-Origin": "true",
          "Content-type": "application/json; charset=UTF-8"
        },
        body: body
    );

    print("Atualizar (patch): ${response.statusCode} //  ${response.body}");
    return response.statusCode;
  }

  Future<int> _delete() async {
    var url = Uri.parse("$_baseUrl/posts/1");
    var response = await http.delete(
        url,
        headers: {
          "Access-Control-Allow-Origin": "true"
        }
    );

    print("Deletar: ${response.statusCode} //  ${response.body}");
    return response.statusCode;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      var statusCode = await _post();
                      var message = "Erro salvando post";
                      if (statusCode == 201) {
                        message = "Post salvo com sucesso";
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message))
                      );
                    },
                    child: Text("Salvar")
                ),
                ElevatedButton(
                    onPressed: () async {
                      var statusCode = await _patch(); // _patch();
                      var message = "Erro atualizando post";
                      if (statusCode == 200) {
                        message = "Post atualizado com sucesso";
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message))
                      );
                    },
                    child: Text("Atualizar")
                ),
                ElevatedButton(
                    onPressed: () async {
                      var statusCode = await _delete();
                      var message = "Erro deletando post";
                      if (statusCode == 200) {
                        message = "Post deletado com sucesso";
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message))
                      );
                    },
                    child: Text("Deletar")
                ),
              ],
            ),
            Expanded(
                child: FutureBuilder <List<Post>>(
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
                          return Center(
                            child: Row(
                              children: [
                                Text("Error: ", style: Theme.of(context).textTheme.headlineMedium),
                                Text(snapshot.error.toString())
                              ],
                            ),
                          );
                        default:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                      }
                    }
                ),
            )
          ],
        ),
      )
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
