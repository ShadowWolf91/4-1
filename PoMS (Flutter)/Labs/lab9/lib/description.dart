import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
      height: 560,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Very Berry Tart',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 8, right: 20),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Amazing combo of sweet and sour taste! Super easy to cook. Enjoy!",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 35, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Preparation",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.timer_sharp),
                    Text(
                      "35'",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
          slider(),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
           alignment: Alignment.center,
           height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              color: Colors.orange,
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow_outlined, color: Colors.white,),
                Text(
                  "Watch Video",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget slider() {
    List<Map<String, dynamic>> dishes = [
      {
        "image": "assets/image/1.jpg",
        "name": "1. BlueBerry Pancakes",
      },
      {
        "image": "assets/image/2.jpg",
        "name": "2. Avocado Toast",
      },
      {
        "image": "assets/image/3.jpg",
        "name": "3. Eggs Benedict",
      },
      {
        "image": "assets/image/4.jpg",
        "name": "4. French Toast",
      },
      {
        "image": "assets/image/5.jpg",
        "name": "5. Omelette",
      },
    ];

    return Container(
      child: CarouselSlider(
        items: dishes.map((dish) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                    Container(
                      width: 170,
                      height: 250,
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 20, left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            dish["image"],
                          ),
                          fit: BoxFit.cover,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      child: Text(
                        dish["name"],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

              ],
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 300,
          viewportFraction: 0.5, // добавлен параметр viewportFraction
          enlargeCenterPage: true, // добавлен параметр enlargeCenterPage
        ),
      ),
    );
  }
}
