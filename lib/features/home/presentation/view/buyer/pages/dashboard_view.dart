import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tryproject/app/constants/theme_constant.dart';
import 'package:tryproject/core/app_theme/ThemeProvider.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/home/presentation/view/buyer/pages/artists_view.dart';

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
                            ? 40.0
                            : 28.0,
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
                            const SizedBox(height: 15),

                            Text(
                              'Discover artworks, artists, art news, and ongoing exhibitions with Artionet.',
                              style: TextStyle(
                                fontFamily: 'IM_Fell_Great_Primer',
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 25.0
                                        : 15.0,
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
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   style: ElevatedButton.styleFrom(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 10, vertical: 0),
                            //     textStyle: TextStyle(
                            //       fontSize:
                            //           MediaQuery.of(context).size.width > 600
                            //               ? 20.0
                            //               : 12.0,
                            //       fontFamily: 'IM_FELL_English_SC',
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            //   child: const Text("Artists"),
                            // ),
                            // BlocBuilder to Display Artworks Below Search Input
                            BlocBuilder<ArtworkBloc, ArtworkState>(
                              builder: (context, state) {
                                if (state.isLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state.errorMessage != null) {
                                  return const Center(
                                      child: Text("No artwork available"));
                                } else {
                                  List<dynamic> displayedArtworks = [];

                                  if (state.artworks.isNotEmpty) {
                                    final random = Random();
                                    displayedArtworks = (state.artworks
                                          ..shuffle())
                                        .take(2)
                                        .toList();
                                  }
                                  return Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      for (int i = 0; i < 2; i++)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Column(
                                            children: [
                                              LayoutBuilder(
                                                builder:
                                                    (context, constraints) {
                                                  final screenWidth =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;
                                                  final imageHeight =
                                                      screenWidth > 600
                                                          ? 170.0
                                                          : 120.0;
                                                  final imageWidth =
                                                      screenWidth > 600
                                                          ? 300.0
                                                          : 140.0;

                                                  // Ensure artwork has an image before displaying
                                                  final imageUrl = displayedArtworks
                                                          .isNotEmpty
                                                      ? displayedArtworks[i]
                                                              .images ??
                                                          'assets/images/placeholder.png'
                                                      : (i == 0
                                                          ? 'assets/images/hel.png'
                                                          : 'assets/images/helen.png');

                                                  return imageUrl
                                                          .startsWith('http')
                                                      ? Image.network(
                                                          imageUrl,
                                                          height: imageHeight,
                                                          width: imageWidth,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          imageUrl,
                                                          height: imageHeight,
                                                          width: imageWidth,
                                                          fit: BoxFit.cover,
                                                        );
                                                },
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                displayedArtworks.isNotEmpty
                                                    ? '"${displayedArtworks[i].title}"'
                                                    : '"Deities of Nepal II"',
                                                style: TextStyle(
                                                  fontFamily: 'IM_Fell_DW_Pica',
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width >
                                                              600
                                                          ? 15.0
                                                          : 11.0,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<ArtworkBloc>(context).add(
                                  NavigateToArtists(
                                    context: context,
                                    destination: const ArtistsView(),
                                  ),
                                );
                              },
                              child: Text(
                                "view Artists",
                                style: TextStyle(
                                  fontFamily: 'IM_Fell_DW_Pica_SC',
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 20.0
                                          : 14.0,
                                  // color: state.isDarkMode
                                  //     ? Colors.white
                                  //     : Colors.black,
                                ),
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
