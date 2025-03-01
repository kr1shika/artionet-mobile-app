// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:tryproject/features/auth/presentation/view_model/artist_signup/artist_register_bloc.dart';
// import 'package:tryproject/features/onboard/presentation/view_model/buyer_onboard/artist_onboard_cubit.dart';

// class OnboardingScreen_Artist extends StatelessWidget {
//   const OnboardingScreen_Artist({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final registerBloc = GetIt.I<ArtistRegisterBloc>();
//     final pageController = PageController();

//     return BlocProvider(
//       create: (_) => OnboardingCubit(pageController),
//       child: OnboardingView(
//           registerBloc: registerBloc, pageController: pageController),
//     );
//   }
// }

// class OnboardingView extends StatelessWidget {
//   final ArtistRegisterBloc registerBloc;
//   final PageController pageController;

//   const OnboardingView({
//     super.key,
//     required this.registerBloc,
//     required this.pageController,
//   });

//   final List<Widget> _pages = const [
//     OnboardingPage(
//         imagePath: 'assets/images/logo.png',
//         title: "Artionet for artists",
//         additionalImagePath: 'assets/images/paintings.png', // Add this line

//         description:
//             " With Artionet you can set up your artist page to share your story and art journey. "),
//     OnboardingPage(
//       imagePath: 'assets/images/flower.png',
//       title: null,
//       description:
//           "Upload your creations with titles, descriptions, and prices to build your online portfolio.",
//     ),
//     OnboardingPage(
//       imagePath: 'assets/images/deer.png',
//       title: null,
//       description:
//           "Communicate directly with buyers and receive feedback. Connect with people who value art as much as you do.",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<OnboardingCubit>();

//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFF7),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             PageView(
//               controller: pageController,
//               onPageChanged: cubit.emit,
//               children: _pages,
//             ),
//             Positioned(
//               top: 16,
//               right: 16,
//               child: GestureDetector(
//                 onTap: () => cubit.skipToLastPage(context, registerBloc),
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
//                   GestureDetector(
//                     onTap: () {
//                       if (cubit.state == _pages.length - 1) {
//                         cubit.navigateToSignup(context, registerBloc);
//                       } else {
//                         cubit.goToNextPage();
//                       }
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 100,
//                         vertical: 12,
//                       ),
//                       child: Text(
//                         cubit.state == _pages.length - 1 ? "Finish" : "Next",
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
//               child: BlocBuilder<OnboardingCubit, int>(
//                 builder: (context, currentPage) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(3, (index) {
//                       return AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         margin: const EdgeInsets.symmetric(horizontal: 4),
//                         height: 8,
//                         width: currentPage == index ? 16 : 8,
//                         decoration: BoxDecoration(
//                           color: currentPage == index
//                               ? Colors.black
//                               : Colors.black54,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       );
//                     }),
//                   );
//                 },
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
//   final String? additionalImagePath; // New optional parameter

//   const OnboardingPage({
//     super.key,
//     required this.imagePath,
//     this.additionalImagePath,
//     this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const SizedBox(height: 0),
//         Image.asset(
//           imagePath,
//           width: 70,
//           height: 70,
//         ),
//         if (title != null) ...[
//           const SizedBox(height: 0),
//           Text(
//             title!,
//             style: const TextStyle(
//               fontFamily: 'IM_FELL_DW_Pica_SC',
//               fontSize: 32,
//               color: Colors.black,
//             ),
//           ),
//         ],
//         const SizedBox(height: 20),
//         const Divider(
//           color: Colors.black54,
//           thickness: 0.7,
//           indent: 120.0,
//           endIndent: 120.0,
//         ),
//         const SizedBox(height: 26),
//         if (additionalImagePath != null)
//           Image.asset(
//             additionalImagePath!,
//             width: 370,
//             height: 120,
//           ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50.0),
//           child: Text(
//             description,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontFamily: 'IM_Fell_Double_Pica',
//               fontSize: 22,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
