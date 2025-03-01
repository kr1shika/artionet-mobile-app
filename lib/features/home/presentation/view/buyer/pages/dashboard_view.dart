import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryproject/app/constants/theme_constant.dart';
import 'package:tryproject/core/app_theme/ThemeProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.isDarkMode
              ? ThemeConstant.darkPrimaryColor
              : ThemeConstant.lightPrimaryColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Artionet",
                      style: TextStyle(
                        fontFamily: 'IM_Fell_DW_Pica_SC',
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? 44.0
                            : 33.0,
                        // color: state.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 62),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final screenWidth =
                                          MediaQuery.of(context).size.width;

                                      final imageHeight =
                                          screenWidth > 600 ? 170.0 : 120.0;
                                      final imageWidth =
                                          screenWidth > 600 ? 300.0 : 170.0;

                                      return Image.asset(
                                        'assets/images/hel.png',
                                        height: imageHeight,
                                        width: imageWidth,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '"Deities of Nepal II", 2024',
                                    style: TextStyle(
                                      fontFamily: 'IM_Fell_DW_Pica',
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 15.0
                                              : 11.0,
                                      // color: state.isDarkMode
                                      //     ? Colors.white
                                      //     : Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width > 600
                                    ? 50.0
                                    : 20.0,
                              ),
                              Column(
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final screenWidth =
                                          MediaQuery.of(context).size.width;

                                      final imageHeight =
                                          screenWidth > 600 ? 170.0 : 120.0;
                                      final imageWidth =
                                          screenWidth > 600 ? 300.0 : 170.0;

                                      return Image.asset(
                                        'assets/images/helen.png',
                                        height: imageHeight,
                                        width: imageWidth,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '"Deities of Nepal II", 2024',
                                    style: TextStyle(
                                      fontFamily: 'IM_Fell_DW_Pica',
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 15.0
                                              : 11.0,
                                      // color: state.isDarkMode
                                      //     ? Colors.white
                                      //     : Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: MediaQuery.of(context).size.width > 600
                              ? 272.0
                              : 215.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Discover artworks, artists, art news, and ongoing exhibitions with Artionet.',
                              style: TextStyle(
                                fontFamily: 'IM_Fell_Great_Primer',
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 25.0
                                        : 18.0,
                                // color: state.isDarkMode
                                //     ? Colors.white
                                //     : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            Image.asset(
                              'assets/images/crest_2.png',
                              height: 28,
                              width: 302,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width > 600
                                  ? 550.0
                                  : 400.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 9.0, horizontal: 20.0),
                                  hintText: "Search for artists/Arts ",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                    // filled: true,
                                    // fillColor: state.isDarkMode
                                    //     ? Colors.grey[800]
                                    //     : const Color(0xFFFFFFF7),
                                  ),
                                  // textAlign: TextAlign.center,
                                  hintStyle: TextStyle(
                                    fontFamily: 'IM_FELL_English_SC',
                                    fontSize:
                                        MediaQuery.of(context).size.width > 600
                                            ? 20.0
                                            : 17.0,
                                    fontWeight: FontWeight.w600,
                                    // color: state.isDarkMode
                                    //     ? Colors.white
                                    //     : const Color.fromARGB(
                                    //         255, 158, 157, 157),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 27),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          // color: state.isDarkMode
                                          //     ? Colors.white
                                          //     : Colors.black38,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    child: Column(
                                      children: [
                                        LayoutBuilder(
                                          builder: (context, constraints) {
                                            final screenWidth =
                                                MediaQuery.of(context)
                                                    .size
                                                    .width;

                                            final imageWidth = screenWidth > 600
                                                ? 230.0
                                                : 150.0;
                                            final imageHeight =
                                                screenWidth > 600
                                                    ? 240.0
                                                    : 170.0;

                                            return Image.asset(
                                              'assets/images/ham.jpg',
                                              height: imageHeight,
                                              width: imageWidth,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          '"Artwork 1", 2024',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            // color: state.isDarkMode
                                            //     ? Colors.white
                                            //     : Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )),
                                const SizedBox(width: 18),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        // color: state.isDarkMode
                                        //     ? Colors.white
                                        //     : Colors.black38,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  child: Column(
                                    children: [
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          final screenWidth =
                                              MediaQuery.of(context).size.width;

                                          final imageHeight =
                                              screenWidth > 600 ? 240.0 : 170.0;
                                          final imageWidth =
                                              screenWidth > 600 ? 230.0 : 150.0;

                                          return Image.asset(
                                            'assets/images/art1.png',
                                            height: imageHeight,
                                            width: imageWidth,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        '"Gotern Mortensen", 2024',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          // color: state.isDarkMode
                                          //     ? Colors.white
                                          //     : Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "view more",
                              style: TextStyle(
                                fontFamily: 'IM_Fell_DW_Pica_SC',
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 22.0
                                        : 17.0,
                                // color: state.isDarkMode
                                //     ? Colors.white
                                //     : Colors.black,
                              ),
                            ),
                            const Divider(
                              thickness: 0.3,
                              color: Colors.black,
                              indent: 80,
                              endIndent: 80,
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                Text(
                                  "On going Events",
                                  style: TextStyle(
                                    fontFamily: 'IM_FELL_English_SC',
                                    fontSize:
                                        MediaQuery.of(context).size.width > 600
                                            ? 27.0
                                            : 20.0,
                                    // color: state.isDarkMode
                                    //     ? Colors.white
                                    //     : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width > 600
                                        ? 16.0
                                        : 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        // color: state.isDarkMode
                                        //     ? Colors.white
                                        //     : Colors.black38,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  child: Column(
                                    children: [
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          final screenWidth =
                                              MediaQuery.of(context).size.width;

                                          final imageHeight =
                                              screenWidth > 600 ? 340.0 : 180.0;
                                          final imageWidth =
                                              screenWidth > 600 ? 600.0 : 320.0;

                                          return Image.asset(
                                            'assets/images/dali.jpg',
                                            height: imageHeight,
                                            width: imageWidth,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'COllection-NAC, 2024 []',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontStyle: FontStyle.italic,
                                          // color: state.isDarkMode
                                          //     ? Colors.white
                                          //     : Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              themeProvider.toggleTheme(); // Toggle theme on button press
            },
            backgroundColor: themeProvider.isDarkMode
                ? const Color(0xFF1E1E1E) // Dark color when dark mode
                : const Color(0xFFE1E1D5),
            // Light color when light mode
            child: Icon(
              themeProvider.isDarkMode
                  ? Icons.dark_mode // Dark mode icon
                  : Icons.light_mode, // Light mode icon
              color: themeProvider.isDarkMode
                  ? Colors.white
                  : Colors.black, // Icon color
            ),
          ),
        );
      },
    );
  }
}
