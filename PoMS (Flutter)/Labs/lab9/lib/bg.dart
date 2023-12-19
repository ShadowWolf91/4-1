import 'package:flutter/material.dart';
class Bg extends StatefulWidget {
  const Bg({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Bg> {

  void _onButtonPressed1() {
    setState(() {

      Navigator.pushNamed(context as BuildContext, "/");

    }
        );}

  @override
  Widget build(BuildContext context) {
    final Object? data = ModalRoute.of(context)!.settings.arguments;

    return Container(
      padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("$data"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: _onButtonPressed1,
              icon: Icon(
                Icons.arrow_back_outlined,
                size: 30,
                color: Colors.white,
              )),
          Icon(
            Icons.favorite_border,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );

  }
}
