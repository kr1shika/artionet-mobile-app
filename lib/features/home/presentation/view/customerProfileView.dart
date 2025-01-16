import 'package:flutter/material.dart';

class Customerprofileview extends StatelessWidget {
  const Customerprofileview({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/krishika.jpg',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Text(
                      "@kr1shika",
                      style: TextStyle(
                        fontFamily: 'IM_FELL_Great_Primer',
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "      !00 \n following ",
                          style: TextStyle(
                            fontFamily: 'Inknut_Antiqua',
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 30),
                        Text(
                          "   !00 \n Saved ",
                          style: TextStyle(
                            fontFamily: 'Inknut_Antiqua',
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 49,
                          vertical: 3,
                        ),
                        backgroundColor: const Color.fromARGB(73, 27, 29, 30),
                        foregroundColor: const Color(0xFFFFFFF7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontFamily: 'IM_FELL_Great_Primer',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // const Divider(
                    //   thickness: 0.3,
                    //   color: Colors.black,
                    //   indent: 80,
                    //   endIndent: 80,
                    // ),
                    const SizedBox(height: 10),

                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      tabs: [
                        Tab(text: "Your Orders"),
                        Tab(text: "Saved"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 400,
                child: TabBarView(
                  children: [
                    Center(
                      child: Text(
                        "No orders made yet!",
                        style: TextStyle(
                          fontFamily: 'IM_FELL_Great_Primer',
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "No saved posts yet!",
                        style: TextStyle(
                          fontFamily: 'IM_FELL_Great_Primer',
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
