

import 'package:flutter/material.dart';

class MyDormPage extends StatefulWidget {
  const MyDormPage({super.key,});

  @override
  State<MyDormPage> createState() => _MyDormPageState();
}

class _MyDormPageState extends State<MyDormPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text("Dormsity", style: Theme.of(context).textTheme.headlineMedium,),
            ),
          ),
          body: Container(),
        );
      },
    );
  }
}