import 'package:flutter/material.dart';
class CrudPage extends StatelessWidget{
  const CrudPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text("Music")),
      floatingActionButton: FloatingActionButton(
        onPressed:(){},
        child:const Icon(Icons.add),
      )
    );
  }
}