import 'package:flutter/material.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: size.width,
      color: const Color.fromARGB(255, 185, 204, 213),
      child: Stack(
        children: [
          // 🧱 Left-aligned text & button
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "NEW COLLECTIONS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -2,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "20",
                      style: TextStyle(
                        fontSize: 40,
                        height: 0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -2,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "%",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "OFF",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: -1.5,
                            height: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.black,
                  child: const Text(
                    "SHOP NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🖼 Right-aligned girl image
          Positioned(
            bottom: -20,
            right:-40 ,
            child: Image.asset(
              "assets/images _req/GIRL.png",
              height: size.height * 0.25,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
