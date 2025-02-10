import 'dart:async';

import 'package:flutter/material.dart';

import 'boton.dart';
import 'pixel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int numberOFSquares = 130;
  int playerPosition = 0;
  int bombPosition = -1;
  List<int> barriers = [
    11,
    13,
    15,
    17,
    18,
    31,
    33,
    35,
    37,
    38,
    51,
    53,
    55,
    57,
    58,
    71,
    73,
    75,
    77,
    78,
    91,
    93,
    95,
    97,
    98,
    111,
    113,
    115,
    117,
    118
  ];
  List<int> boxes = [
    12,
    14,
    16,
    28,
    21,
    41,
    61,
    81,
    101,
    112,
    114,
    116,
    119,
    123,
    127,
    103,
    83,
    63,
    65,
    67,
    47,
    39,
    19,
    30,
    50,
    70,
    121,
    100,
    96,
    79,
    99,
    107,
    7,
    3,
  ];
  void moveUp() {
    setState(() {
      if (playerPosition - 10 >= 0 &&
          !barriers.contains(playerPosition - 10) &&
          !boxes.contains(playerPosition - 10)) {
        playerPosition -= 10;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerPosition % 10 == 0 &&
          !barriers.contains(playerPosition - 1) &&
          !boxes.contains(playerPosition - 1))) {
        playerPosition -= 1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerPosition % 10 == 9 &&
          !barriers.contains(playerPosition + 1) &&
          !boxes.contains(playerPosition + 1))) {
        playerPosition += 1;
      }
    });
  }

  void moveDown() {
    setState(() {
      if (playerPosition + 10 < numberOFSquares &&
          !barriers.contains(playerPosition + 10) &&
          !boxes.contains(playerPosition + 10)) {
        playerPosition += 10;
      }
    });
  }

  List<int> fire = [-1];

  void placeBomb() {
    setState(() {
      bombPosition = playerPosition;
      fire.clear();
      Timer(const Duration(milliseconds: 4), () {
        setState(() {
          fire.add(bombPosition);
          fire.add(bombPosition - 1);
          fire.add(bombPosition + 1);
          fire.add(bombPosition - 10);
          fire.add(bombPosition + 10);
        });
        clearfire();
      });
    });
  }

  void clearfire() {
    setState(() {
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          for (int i = 0; i < fire.length; i++) {
            if (boxes.contains(fire[i])) {
              boxes.remove(fire[i]);
            }
          }
          fire.clear();
          bombPosition = -1; 
        });
        clearfire();
      });
    });
  }

  void destroyBoxes() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numberOFSquares,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10),
                  itemBuilder: (BuildContext context, int index) {
                    if (fire.contains(index)) {
                      return MyPixel(innerColor: Colors.red,
                      outerColor: Colors.red[900],);
                    } else if (bombPosition == index) {
                      return MyPixel(
                          innerColor: Colors.green,
                          outerColor: Colors.green[900],
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.asset('lib/imagenes/Bomba.png'),
                          ));
                    } else if (playerPosition == index) {
                      return MyPixel(
                          innerColor: Colors.green,
                          outerColor: Colors.green[800],
                          child: Image.asset('lib/imagenes/bomberman.webp'));
                    } else if (barriers.contains(index)) {
                      return MyPixel(innerColor: Colors.black, 
                      outerColor: Colors.grey[900],);
                    } else if (boxes.contains(index)) {
                      return  MyPixel(innerColor: Colors.brown,
                      outerColor: Colors.brown[900],);
                    } else {
                      Text(index.toString());
                      return  MyPixel(innerColor: Colors.green, 
                      outerColor: Colors.green[900],);
                    } 
                  }),
            ),
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Mybutton(0),
                    Mybutton(
                      0,
                      function: moveUp,
                      Color: Colors.grey,
                      child: const Icon(Icons.arrow_drop_up, size: 70),
                    ),
                    const Mybutton(0),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Mybutton(
                      0,
                      function: moveLeft,
                      Color: Colors.grey,
                      child: const Icon(Icons.arrow_left, size: 70),
                    ),
                    Mybutton(0,
                        function: placeBomb,
                        Color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            'lib/imagenes/bombaa.png',
                            fit: BoxFit.cover,
                          ),
                        )),
                    Mybutton(
                      0,
                      function: moveRight,
                      Color: Colors.grey,
                      child: const Icon(Icons.arrow_right, size: 70),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Mybutton(0),
                    Mybutton(
                      0,
                      function: moveDown,
                      Color: Colors.grey,
                      child: const Icon(Icons.arrow_drop_down, size: 70),
                    ),
                    const Mybutton(0),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
