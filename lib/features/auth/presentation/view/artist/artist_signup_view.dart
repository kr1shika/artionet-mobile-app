import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/auth/presentation/view/buyers/login_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist_signup/artist_register_bloc.dart';

class ArtistSignupView extends StatefulWidget {
  const ArtistSignupView({super.key});

  @override
  State<ArtistSignupView> createState() => _ArtistSignupView();
}

class _ArtistSignupView extends State<ArtistSignupView> {
  final _key1 = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _roleController = TextEditingController(text: 'artist');
  final _passwordController = TextEditingController();
  final _artistnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    const SizedBox(height: 130),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 110,
                      height: 110,
                    ),
                    const SizedBox(height: 5),
                    // Signup Text
                    const Text(
                      "Sign up to artionet",
                      style: TextStyle(
                        fontFamily: 'IM_Fell_DW_Pica_SC',
                        fontSize: 33,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 21),

                    Form(
                        key: _key1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 41.0, right: 8.0), // Add spacing
                                    child: TextFormField(
                                      controller: _fullnameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your full name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 12.0),
                                        hintText: "Full Name",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.8),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'IM_FELL_English_SC',
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 61, 57, 57),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 41.0, left: 8.0), // Add spacing
                                    child: TextFormField(
                                      controller: _artistnameController,
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Please enter Contact Number';
                                      //   }
                                      //   return null;
                                      // },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 12.0),
                                        hintText: "Artist Name [Optional]",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.8),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'IM_FELL_English_SC',
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 61, 57, 57),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 41.0),
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 12.0),
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'IM_FELL_English_SC',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 61, 57, 57),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 41.0),
                              child: TextFormField(
                                controller: _contactController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Contact Number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 12.0),
                                  hintText: "Phone Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'IM_FELL_English_SC',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 61, 57, 57),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 41.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 12.0),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'IM_FELL_English_SC',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 61, 57, 57),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            ElevatedButton(
                              onPressed: () {
                                if (_key1.currentState!.validate()) {
                                  context.read<ArtistRegisterBloc>().add(
                                        RegisterUser(
                                            context: context,
                                            full_name: _fullnameController.text,
                                            email: _emailController.text,
                                            contact_no: _contactController.text,
                                            role: _roleController.text,
                                            password: _passwordController.text,
                                            artistname:
                                                _artistnameController.text),
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 42,
                                  vertical: 4,
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 27, 29, 30),
                                foregroundColor: const Color(0xFFFFFFF7),
                                // textStyle: const TextStyle( fontFamily:'IM_Fell_DW_Pica_SC',),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'SIGN UP',
                                style: TextStyle(
                                    fontFamily: 'IM_FELL_Great_Primer',
                                    fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 6),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ArtistRegisterBloc>().add(
                                      NavigateScreenEvent(
                                        destination: const LoginView(),
                                        context: context,
                                      ),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide.none),
                              ),
                              child: const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontFamily: 'Inknut_Antiqua',
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ))
                    // Input Fields
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
