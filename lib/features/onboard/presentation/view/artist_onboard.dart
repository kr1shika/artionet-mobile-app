import 'package:flutter/material.dart';

class OnboardingScreen_Artist extends StatefulWidget {
  const OnboardingScreen_Artist({super.key});

  @override
  State<OnboardingScreen_Artist> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen_Artist> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      imagePath: 'assets/images/logo.png',
      title: "Artionet for artists",
      description:
          "With Artionet you can set up your artist page to share your story and art journey.",
    ),
    const OnboardingPage(
      imagePath: 'assets/images/flower.png',
      title: null,
      description:
          "Upload your creations with titles, descriptions, and prices to build your online portfolio.",
    ),
    const OnboardingPage(
      imagePath: 'assets/images/deer.png',
      title: null,
      description:
          "Communicate directly with buyers and receive feedback. Connect with people who value art as much as you do.",
    ),
  ];

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, '/artistSignupView');
    }
  }

  void _skipToLastPage() {
    Navigator.pushNamed(context, '/artistSignupView');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF7),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _pages,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: _skipToLastPage,
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontFamily: 'IM_FELL_DW_Pica',
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _goToNextPage,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 12,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? "Finish" : "Next",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'IM_FELL_DW_Pica',
                          color: Colors.black,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String? title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 110,
          height: 110,
        ),
        if (title != null) ...[
          const SizedBox(height: 10),
          Text(
            title!,
            style: const TextStyle(
              fontFamily: 'IM_FELL_DW_Pica_SC',
              fontSize: 25,
              color: Colors.black,
            ),
          ),
        ],
        const SizedBox(height: 10),
        const Divider(
          color: Colors.black54,
          thickness: 0.7,
          indent: 90.0,
          endIndent: 90.0,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'IM_FELL_DW_Pica',
              fontSize: 25,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
