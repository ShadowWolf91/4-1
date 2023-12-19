import 'package:flutter/material.dart';
import 'about.dart';
import 'package:lab45/ima.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'food_shop_bloc.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FoodShop(),
        '/about': (context) => About(),
      },
    ));

class FoodShop extends StatefulWidget {
  const FoodShop({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FoodShop> {
  late FoodShopBloc _bloc;
  late Color _containerColor1 = Colors.grey.shade200;
  late Color _containerColor2 = Colors.grey.shade200;
  late Color _containerColor3 = Colors.grey.shade200;
  late Color _iconColor1 = Colors.black87;
  late Color _iconColor2 = Colors.black87;
  late Color _iconColor3 = Colors.black87;
  late Color _textColor1 = Colors.black87;
  late Color _textColor2 = Colors.black;
  late Color _textColor3 = Colors.black87;

  @override
  void initState() {
    super.initState();
    _bloc = FoodShopBloc();
    _containerColor1 = _bloc.getContainerColor(FoodCategory.Breakfast);
    _containerColor2 = _bloc.getContainerColor(FoodCategory.Dessert);
    _containerColor3 = _bloc.getContainerColor(FoodCategory.Meat);
    _textColor1 = _bloc.getTextColor(FoodCategory.Breakfast);
    _textColor2 = _bloc.getTextColor(FoodCategory.Dessert);
    _textColor3 = _bloc.getTextColor(FoodCategory.Meat);
    _iconColor1 = _bloc.getIconColor(FoodCategory.Breakfast);
    _iconColor2 = _bloc.getIconColor(FoodCategory.Dessert);
    _iconColor3 = _bloc.getIconColor(FoodCategory.Meat);

  }

  void _onButtonPressed1() {
    setState(() {
      if (_containerColor1 == Colors.grey.shade200) {
        _bloc.updateColor(FoodCategory.Breakfast, Colors.orange);
        Navigator.pushNamed(context, "/about", arguments: "assets/image/5.jpg");

      } else {
        _bloc.updateColor(FoodCategory.Breakfast, Colors.grey.shade200);
      }
      _containerColor1 = _bloc.getContainerColor(FoodCategory.Breakfast);
      _iconColor1 = _bloc.getIconColor(FoodCategory.Breakfast);
      _textColor1 = _bloc.getTextColor(FoodCategory.Breakfast);
    });
  }

// Аналогичные изменения для остальных кнопок _onButtonPressed2 и _onButtonPressed3


  void _onButtonPressed2() {
    setState(() {
      if (_containerColor2 == Colors.grey.shade200) {
        _bloc.updateColor(FoodCategory.Dessert, Colors.orange);
        Navigator.pushNamed(context, "/about", arguments: "assets/image/4.jpg");


      } else {
        _bloc.updateColor(FoodCategory.Dessert, Colors.grey.shade200);
      }
      _containerColor2 = _bloc.getContainerColor(FoodCategory.Dessert);
      _iconColor2 = _bloc.getIconColor(FoodCategory.Dessert);
      _textColor2 = _bloc.getTextColor(FoodCategory.Dessert);
    });
  }

  void _onButtonPressed3() {
    setState(() {
      if (_containerColor3 == Colors.grey.shade200) {
        _bloc.updateColor(FoodCategory.Meat, Colors.orange);
        Navigator.pushNamed(context, "/about", arguments: "assets/image/1.jpg");

      } else {
        _bloc.updateColor(FoodCategory.Meat, Colors.grey.shade200);
      }
      _containerColor3 = _bloc.getContainerColor(FoodCategory.Meat);
      _iconColor3 = _bloc.getIconColor(FoodCategory.Meat);
      _textColor3 = _bloc.getTextColor(FoodCategory.Meat);
    });
  }


  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 40, top: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    textDirection: TextDirection.ltr,
                    text: const TextSpan(
                        text: 'Hello there, ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black87,
                        ),
                        children: [
                          TextSpan(
                              text: "Ana!",
                              style: TextStyle(color: Colors.orange)),
                        ]),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange,
                      image: const DecorationImage(
                          image: AssetImage("assets/image/woman.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ) //  Image(image: AssetImage(images[index]))
                ],
              ),
            ), //Top
            Container(
              margin: const EdgeInsets.only(
                  left: 40, top: 15, right: 40, bottom: 8),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select a category',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ), //text
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        Container(
                          width: 55,
                          height: 55,
                          margin: const EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: _containerColor1,
                          ),
                        ),
                        IconButton(
                          onPressed: _onButtonPressed1,
                          icon: Icon(Icons.cake_outlined),
                          color: _iconColor1,
                        )
                      ]),
                      Text(
                        'Breakfast',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: _textColor1),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        Container(
                          width: 55,
                          height: 55,
                          margin: const EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: _containerColor2,
                          ),
                        ),
                        IconButton(
                          onPressed: _onButtonPressed2,
                          icon: Icon(Icons.cake_outlined),
                          color: _iconColor2,
                        )
                      ]),
                      Text(
                        'Dessert',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: _textColor2),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        Container(
                          width: 55,
                          height: 55,
                          margin: const EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: _containerColor3,
                          ),
                        ),
                        IconButton(
                          onPressed: _onButtonPressed3,
                          icon: Icon(Icons.restaurant_menu),
                          color: _iconColor3,
                        )
                      ]),
                      Text(
                        'Meat',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: _textColor3),
                      )
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 58,
                    margin: EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('more', textDirection: TextDirection.ltr)
                      ],
                    ),
                  ),
                ],
              ),
            ), //menu
            Container(
              margin: EdgeInsets.only(left: 40, top: 15, right: 40, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Popular',
                      textDirection: TextDirection.ltr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ],
              ),
            ), //Popular

            slider(),

            Container(
              margin: EdgeInsets.only(left: 40, right: 40, bottom: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search by cuisine',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ), //search
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(bottom: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            image: DecorationImage(
                                image: AssetImage("assets/image/8.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        'French',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(bottom: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: Colors.grey,
                            image: DecorationImage(
                                image: AssetImage("assets/image/9.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        'Italian',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(bottom: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            image: DecorationImage(
                                image: AssetImage("assets/image/10.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        'Moroccan',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(bottom: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            image: DecorationImage(
                                image: AssetImage("assets/image/11.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        'Asian',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: 48,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/about", arguments: "assets/image/2.jpg");
                        },
                        icon: Icon(Icons.home_outlined, size: 40,)),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/about", arguments: "assets/image/1.jpg");
                        },
                        icon: Icon(Icons.search, size: 40,)),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/about", arguments: "assets/image/3.jpg");
                        },
                        icon: Icon(Icons.favorite_border, size: 40,)),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/about", arguments: "assets/image/5.jpg");
                        },
                        icon: Icon(Icons.person_outline, size: 40,)),
                  ]),
            ),

          ],
        ),
    ),),
    );
  }

  Widget slider() {
    List<Map<String, dynamic>> dishes = [
      {
        "image": "assets/image/1.jpg",
        "name": "BlueBerry Pancakes",
        "description": "Amazing combo of sweet and sour taste!",
        "time": "25s'",
        "rating": "4,9",
      },
      {
        "image": "assets/image/2.jpg",
        "name": "Avocado Toast",
        "description": "Healthy and delicious breakfast option!",
        "time": "15s'",
        "rating": "4,5",
      },
      {
        "image": "assets/image/3.jpg",
        "name": "Eggs Benedict",
        "description": "Classic breakfast dish with a twist!",
        "time": "30s'",
        "rating": "4,8",
      },
      {
        "image": "assets/image/4.jpg",
        "name": "French Toast",
        "description": "Soft and fluffy bread with a cinnamon!",
        "time": "20s'",
        "rating": "4,7",
      },
      {
        "image": "assets/image/5.jpg",
        "name": "Omelette",
        "description": "Customizable and filling breakfast option!",
        "time": "25s'",
        "rating": "4,6",
      },
    ];

    return Container(
      child: CarouselSlider(
        items: dishes.map((dish) {
          return Container(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 300,
                      height: 200,
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange,
                        image: DecorationImage(
                          image: AssetImage(dish["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Icon(Icons.favorite_border),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 20.0)),
                    Text(
                      dish["name"],
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 8.0)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dish["description"],
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer_sharp),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Text(
                          dish["time"],
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(padding: EdgeInsets.only(right: 20)),
                        Icon(Icons.star_border_rounded),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Text(
                          dish["rating"],
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 350,
        ),
      ),
    );
  }
}