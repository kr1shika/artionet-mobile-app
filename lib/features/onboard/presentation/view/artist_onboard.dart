import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist_signup/artist_register_bloc.dart';
import 'package:tryproject/features/onboard/presentation/view_model/buyer_onboard/artist_onboard_cubit.dart';

// class OnboardingScreen_Artist extends StatefulWidget {
//   const OnboardingScreen_Artist({super.key});

//   @override
//   State<OnboardingScreen_Artist> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen_Artist> {
//   final PageController _pageController = PageController();
//   late ArtistRegisterBloc _registerBloc;

//   int _currentPage = 0;

//     @override
//   void initState() {
//     super.initState();
//     _registerBloc = GetIt.I<ArtistRegisterBloc>();
//   }

//   final List<Widget> _pages = [
//     const OnboardingPage(
//       imagePath: 'assets/images/logo.png',
//       title: "Artionet for artists",
//       description:
//           "With Artionet you can set up your artist page to share your story and art journey.",
//     ),
//     const OnboardingPage(
//       imagePath: 'assets/images/flower.png',
//       title: null,
//       description:
//           "Upload your creations with titles, descriptions, and prices to build your online portfolio.",
//     ),
//     const OnboardingPage(
//       imagePath: 'assets/images/deer.png',
//       title: null,
//       description:
//           "Communicate directly with buyers and receive feedback. Connect with people who value art as much as you do.",
//     ),
//   ];

//   @override
//   void dispose() {
//     _registerBloc.close(); // Dispose of the bloc
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _goToNextPage() {
//     if (_currentPage < _pages.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BlocProvider.value(
//             value: _registerBloc,
//             child: const ArtistSignupView(),
//           ),
//         ),
//       );
//     }
//   }

//   void _skipToLastPage() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: _registerBloc,
//           child: const ArtistSignupView(),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFF7),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             PageView(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentPage = index;
//                 });
//               },
//               children: _pages,
//             ),
//             Positioned(
//               top: 16,
//               right: 16,
//               child: GestureDetector(
//                 onTap: _skipToLastPage,
//                 child: const Text(
//                   "Skip",
//                   style: TextStyle(
//                     fontFamily: 'IM_FELL_DW_Pica',
//                     fontSize: 16,
//                     color: Colors.black,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 30,
//               left: 0,
//               right: 0,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   GestureDetector(
//                     onTap: _goToNextPage,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 100,
//                         vertical: 12,
//                       ),
//                       child: Text(
//                         _currentPage == _pages.length - 1 ? "Finish" : "Next",
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontFamily: 'IM_FELL_DW_Pica',
//                           color: Colors.black,
//                           fontSize: 20,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: 24,
//               left: 0,
//               right: 0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(3, (index) {
//                   return AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     height: 8,
//                     width: _currentPage == index ? 16 : 8,
//                     decoration: BoxDecoration(
//                       color:
//                           _currentPage == index ? Colors.black : Colors.black54,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OnboardingPage extends StatelessWidget {
//   final String imagePath;
//   final String? title;
//   final String description;

//   const OnboardingPage({
//     super.key,
//     required this.imagePath,
//     this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset(
//           imagePath,
//           width: 110,
//           height: 110,
//         ),
//         if (title != null) ...[
//           const SizedBox(height: 10),
//           Text(
//             title!,
//             style: const TextStyle(
//               fontFamily: 'IM_FELL_DW_Pica_SC',
//               fontSize: 25,
//               color: Colors.black,
//             ),
//           ),
//         ],
//         const SizedBox(height: 10),
//         const Divider(
//           color: Colors.black54,
//           thickness: 0.7,
//           indent: 90.0,
//           endIndent: 90.0,
//         ),
//         const SizedBox(height: 10),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40.0),
//           child: Text(
//             description,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontFamily: 'IM_FELL_DW_Pica',
//               fontSize: 25,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class OnboardingScreen_Artist extends StatelessWidget {
  const OnboardingScreen_Artist({super.key});

  @override
  Widget build(BuildContext context) {
    final registerBloc = GetIt.I<ArtistRegisterBloc>();
    final pageController = PageController();

    return BlocProvider(
      create: (_) => OnboardingCubit(pageController),
      child: OnboardingView(
          registerBloc: registerBloc, pageController: pageController),
    );
  }
}

class OnboardingView extends StatelessWidget {
  final ArtistRegisterBloc registerBloc;
  final PageController pageController;

  const OnboardingView({
    super.key,
    required this.registerBloc,
    required this.pageController,
  });

  final List<Widget> _pages = const [
    OnboardingPage(
      imagePath: 'assets/images/logo.png',
      title: "Artionet for artists",
      description:
          "With Artionet you can set up your artist page to share your story and art journey.",
    ),
    OnboardingPage(
      imagePath: 'assets/images/flower.png',
      title: null,
      description:
          "Upload your creations with titles, descriptions, and prices to build your online portfolio.",
    ),
    OnboardingPage(
      imagePath: 'assets/images/deer.png',
      title: null,
      description:
          "Communicate directly with buyers and receive feedback. Connect with people who value art as much as you do.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF7),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: cubit.emit,
              children: _pages,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => cubit.skipToLastPage(context, registerBloc),
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
                  GestureDetector(
                    onTap: () {
                      if (cubit.state == _pages.length - 1) {
                        cubit.navigateToSignup(context, registerBloc);
                      } else {
                        cubit.goToNextPage();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 12,
                      ),
                      child: Text(
                        cubit.state == _pages.length - 1 ? "Finish" : "Next",
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
              child: BlocBuilder<OnboardingCubit, int>(
                builder: (context, currentPage) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: currentPage == index ? 16 : 8,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? Colors.black
                              : Colors.black54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  );
                },
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
