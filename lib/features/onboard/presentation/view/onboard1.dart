import 'package:flutter/material.dart';

class OnboardScreens extends StatefulWidget {
  const OnboardScreens({super.key});

  @override
  State<OnboardScreens> createState() => _OnboardScreensState();
}

class _OnboardScreensState extends State<OnboardScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF7),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildOnboardFirst(context),
              _buildOnboardSecond(context),
              _buildOnboardFinal(context),
            ],
          ),
          // "Skip" button on the first slide
          if (_currentPage == 0)
            Positioned(
              top: 35,
              right: 20,
              child: TextButton(
                onPressed: _skipOnboarding,
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontFamily: 'IM_FELL_DW_Pica',
                    color: Colors.black,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          // "Next" button for first two slides
          if (_currentPage < 2)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextButton(
                  onPressed: _goToNextPage,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontFamily: 'IM_FELL_Great_Primer',
                      color: Colors.black,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 16 : 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index ? Colors.black : Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardFirst(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/pictureonboard.png',
                width: 309,
                height: 130,
              ),
              const SizedBox(height: 18),
              const Divider(
                color: Colors.black54,
                thickness: 0.7,
                indent: 90.0,
                endIndent: 90.0,
              ),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
                child: Text(
                  "Discover Arts and Artists",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'IM_FELL_DW_Pica',
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOnboardSecond(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/plant.png',
                width: 120,
                height: 110,
              ),
              const SizedBox(height: 8),
              const Divider(
                color: Colors.black54,
                thickness: 0.5,
                indent: 90.0,
                endIndent: 90.0,
              ),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
                child: Text(
                  "Connect, Learn and Collect",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'IM_FELL_DW_Pica',
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOnboardFinal(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 115,
                height: 115,
              ),
              const SizedBox(height: 2),
              const Text(
                "Artionet",
                style: TextStyle(
                  fontFamily: 'IM_FELL_DW_Pica_SC',
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 59.0),
                child: Text(
                  "Discover artworks, artist and ongoing exhibitions with Artionet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'IM_FELL_English_SC',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Image.asset(
                'assets/images/crescent.png',
                width: 254,
                height: 100,
              ),
              const SizedBox(height: 0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 1,
                  ),
                  backgroundColor: const Color.fromARGB(255, 27, 29, 30),
                  foregroundColor: const Color(0xFFFFFFF7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 43,
                    vertical: 1,
                  ),
                  backgroundColor: const Color.fromARGB(255, 27, 29, 30),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/artistonboard');
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  child: Text(
                    "Find out what Artionet offers artists.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'IM_FELL_DW_Pica',
                      color: Colors.black,
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
