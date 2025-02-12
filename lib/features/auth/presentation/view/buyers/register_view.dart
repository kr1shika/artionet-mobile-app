import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tryproject/features/auth/presentation/view/buyers/login_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _key = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _roleController = TextEditingController(text: 'buyer');
  final _passwordController = TextEditingController();

  checkCameraPermssion() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          //send image to server
          context.read<RegisterBloc>().add(
                LoadImage(file: _img!),
              );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
                    const SizedBox(height: 50),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 85,
                      height: 85,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Sign up to artionet",
                      style: TextStyle(
                        fontFamily: 'IM_Fell_DW_Pica_SC',
                        fontSize: 33,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Input Fields
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.grey[300],
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  ),
                                ),
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          checkCameraPermssion();
                                          _browseImage(ImageSource.camera);
                                          Navigator.pop(context);
                                          // Upload image it is not null
                                        },
                                        icon: const Icon(Icons.camera),
                                        label: const Text('Camera'),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          _browseImage(ImageSource.gallery);
                                        },
                                        icon: const Icon(Icons.image),
                                        label: const Text('Gallery'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 140,
                              width: 140,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: _img != null
                                    ? FileImage(_img!)
                                    : const AssetImage(
                                            'assets/images/profile.jpg')
                                        as ImageProvider,
                                // backgroundImage:
                                //     AssetImage('assets/images/profile.jpg')
                                //         as ImageProvider,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 41.0),
                            child: TextFormField(
                              controller: _fullnameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Full name.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 12.0),
                                hintText: "Full name",
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
                                hintText: "Contact Number",
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
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email.';
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
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please create a password.';
                                }
                                return null;
                              },
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
                              if (_key.currentState!.validate()) {
                                final registerState =
                                    context.read<RegisterBloc>().state;
                                final imageName = registerState.imageName;
                                context.read<RegisterBloc>().add(
                                      RegisterUser(
                                        context: context,
                                        full_name: _fullnameController.text,
                                        email: _emailController.text,
                                        contact_no: _contactController.text,
                                        role: _roleController.text,
                                        password: _passwordController.text,
                                        profilepic: imageName,
                                      ),
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
                          const SizedBox(height: 6),
                          ElevatedButton(
                            key: const ValueKey('_loginBloc'),
                            onPressed: () {
                              context.read<RegisterBloc>().add(
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
