import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 75,
        leading: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              "Warsaw, the capital city of Poland, is a vibrant and culturally rich metropolis. With its fascinating blend of history and modernity, Warsaw offers a unique experience for residents and visitors alike.",
            );
          },
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
              ),
              const Text(
                "Back",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: const Text(
              "Edit",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
      // Sets the content to the
      // center of the application page
      body: SingleChildScrollView(
          // Sets the content of the Application
          child: Column(
        children: [
          Container(
            height: 620,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
              image: DecorationImage(
                image: AssetImage('images/Warsaw.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 400, 40, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.eco_outlined,
                        size: 60,
                        color: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: Text(title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 42,
                                color: Colors.white)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Row(
                          children: [
                            Text(
                              "Spring 2019 - 7 days",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("The best spring holiday in Warsaw",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Warsaw, the capital city of Poland, is a vibrant and culturally rich metropolis. With its fascinating blend of history and modernity, Warsaw offers a unique experience for residents and visitors alike.",
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Poland.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        ],
      )),
    );
  }
}
