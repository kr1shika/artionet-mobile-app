import 'package:flutter/material.dart';

class Customerprofileview extends StatelessWidget {
  const Customerprofileview({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2, // Number of tabs
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
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
                      "meow",
                      style: TextStyle(
                        fontFamily: 'IM_FELL_Great_Primer',
                        fontSize: 27,
                      ),
                    ),
                    const SizedBox(height: 5),
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
                    const Divider(
                      thickness: 0.3,
                      color: Colors.black,
                      indent: 80,
                      endIndent: 80,
                    ),
                    // TabBar for "Created" and "Saved"
                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      tabs: [
                        Tab(text: "Created"),
                        Tab(text: "Saved"),
                      ],
                    ),
                  ],
                ),
              ),
              // TabBarView for the content of each tab
              const SizedBox(
                height: 400, // Adjust height based on your content
                child: TabBarView(
                  children: [
                    // Content for "Created" tab
                    Center(
                      child: Text(
                        "No posts created yet!",
                        style: TextStyle(
                          fontFamily: 'IM_FELL_Great_Primer',
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // Content for "Saved" tab
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
