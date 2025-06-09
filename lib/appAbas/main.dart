import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sjr77_first_project/appAbas/account_page.dart';
import 'package:sjr77_first_project/appAbas/email_page.dart';
import 'package:sjr77_first_project/appAbas/home_page.dart';

class AppAbas extends StatelessWidget {
  const AppAbas({super.key});

  final title = "App com abas";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: "Home", icon: Icon(Icons.home)),
            Tab(text: "Email", icon: Icon(Icons.email)),
            Tab(text: "Conta", icon: Icon(Icons.account_circle)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[HomePage(), EmailPage(), AccountPage()],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
