// Importing important packages require to connect
// Flutter and Dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'secondPage.dart';

// Main Function
void main() {
// Giving command to runApp() to run the app.

/* The purpose of the runApp() function is to attach
the given widget to the screen. */
  runApp(const MyApp());
}

// Widget is used to create UI in flutter framework.

/* StatelessWidget is a widget, which does not maintain
any state of the widget. */

/* MyApp extends StatelessWidget and overrides its
build method. */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title of the application
      title: 'Hello World Demo Application',
      // theme of the widget
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      // Inner UI of the application
      home: const MyHomePage(title: 'Home page'),
    );
  }
}

/* This class is similar to MyApp instead it
returns Scaffold Widget */
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sets the content to the
      // center of the application page
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          // Sets the content of the Application
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    'My trips',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.view_stream_outlined,
                            color: Colors.black87,
                            size: 38.0,
                          ),
                          Icon(
                            Icons.south_america_outlined,
                            color: Colors.black26,
                            size: 38.0,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    image: AssetImage('images/Croatia.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        // shadow color
                        blurRadius: 10,
                        // shadow radius
                        offset: Offset(5, 5),
                        // shadow offset
                        spreadRadius: 0.1,
                        // The amount the box should be inflated prior to applying the blur
                        blurStyle: BlurStyle.normal // set blur style
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.light_mode_outlined,
                              size: 55,
                              color: Colors.white,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: const Text("Croatia",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34,
                                      color: Colors.white)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Summer 2017 - 14 days",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                      image: DecorationImage(
                                        image: AssetImage('images/Girl.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const SecondPage(title: 'Warsaw page')));
                  },
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        image: AssetImage('images/Warsaw.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            // shadow color
                            blurRadius: 10,
                            // shadow radius
                            offset: Offset(5, 5),
                            // shadow offset
                            spreadRadius: 0.1,
                            // The amount the box should be inflated prior to applying the blur
                            blurStyle: BlurStyle.normal // set blur style
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.eco_outlined,
                                  size: 55,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: const Text("Warsaw",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34,
                                          color: Colors.white)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Spring 2019 - 7 days",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          image: DecorationImage(
                                            image: AssetImage('images/Man.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    image: AssetImage('images/Kappl.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        // shadow color
                        blurRadius: 10,
                        // shadow radius
                        offset: Offset(5, 5),
                        // shadow offset
                        spreadRadius: 0.1,
                        // The amount the box should be inflated prior to applying the blur
                        blurStyle: BlurStyle.normal // set blur style
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.ac_unit_outlined,
                              size: 55,
                              color: Colors.white,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: const Text("Kappl",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34,
                                      color: Colors.white)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Winter 2021 - 6 days",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                      image: DecorationImage(
                                        image: AssetImage('images/Girl.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    image: AssetImage('images/Minsk.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        // shadow color
                        blurRadius: 10,
                        // shadow radius
                        offset: Offset(5, 5),
                        // shadow offset
                        spreadRadius: 0.1,
                        // The amount the box should be inflated prior to applying the blur
                        blurStyle: BlurStyle.normal // set blur style
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.water_drop_outlined,
                              size: 55,
                              color: Colors.white,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: const Text("Minsk",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34,
                                      color: Colors.white)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Autumn 2023 - 20 days",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                      image: DecorationImage(
                                        image: AssetImage('images/Girl.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}