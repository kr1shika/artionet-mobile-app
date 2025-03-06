import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tryproject/features/auth/presentation/view/buyers/register_view.dart';
import 'package:tryproject/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:tryproject/features/auth/presentation/view_model/signup/register_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = GetIt.I<RegisterBloc>();
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
                    const SizedBox(height: 130),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 112,
                      height: 112,
                    ),
                    const SizedBox(height: 5),

                    // Login Text
                    const Text(
                      "Login to Artionet",
                      style: TextStyle(
                        fontFamily: 'IM_Fell_DW_Pica_SC',
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "welcome back",
                      style: TextStyle(
                        fontFamily: 'IM_Fell_DW_Pica_SC',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 23),

                    // Form Wrapper
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email Input Field
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 41.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width > 600
                                  ? 550.0
                                  : 400.0,
                              child: TextFormField(
                                key: const ValueKey('email'),
                                controller: _emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter the email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 11.0, horizontal: 12.0),
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'IM_FELL_English_SC',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 61, 57, 57),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Password Input Field
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 41.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width > 600
                                  ? 550.0
                                  : 400.0,
                              child: TextFormField(
                                key: const ValueKey('password'),
                                controller: _passwordController,
                                validator: ((value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 11.0, horizontal: 12.0),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'IM_FELL_English_SC',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 27, 29, 30),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Proceed Button
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(LoginUserEvent(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 3,
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 27, 29, 30),
                              foregroundColor: const Color(0xFFFFFFF7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'PROCEED',
                              style: TextStyle(
                                  fontFamily: 'IM_FELL_Great_Primer',
                                  fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Register Button
                          ElevatedButton(
                            key: const ValueKey('registerButton'),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: _registerBloc,
                                    child: const RegisterView(),
                                  ),
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
                              "Don,t have an account?",
                              style: TextStyle(
                                fontFamily: 'Inknut_Antiqua',
                                color: Colors.black,
                                fontSize: 12,
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
