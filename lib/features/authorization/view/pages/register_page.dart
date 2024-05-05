import 'package:auto_route/annotations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/features/authorization/view/pages/widgets/authorization_input_widget.dart';
import 'package:yahay/features/authorization/view/pages/widgets/other_authorization_button_widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  final TextEditingController _userNameController = TextEditingController(text: '');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              AuthorizationInputWidget(
                title: Constants.email,
                controller: _emailController,
                hintText: Constants.enterEmail,
              ),
              const SizedBox(height: 10),
              AuthorizationInputWidget(
                title: Constants.username,
                controller: _userNameController,
                hintText: "@${Constants.username}",
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  AuthorizationInputWidget(
                    title: Constants.password,
                    controller: _passwordController,
                    hintText: Constants.enterPassword,
                  ),
                  Positioned(
                    right: 0,
                    top: 30,
                    child: IconButton(
                      onPressed: () => [],
                      icon: const Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
                  ),
                  onPressed: () => [],
                  child: Center(
                    child: Text(
                      Constants.signUp,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      height: 0,
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    Constants.orSignUpWith,
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Divider(
                      height: 0,
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: OtherAuthorizationButtonWidget(
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                      ),
                      text: 'Google',
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: OtherAuthorizationButtonWidget(
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                      text: 'Facebook',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  children: [
                    const TextSpan(text: Constants.haveAnAccount),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => [],
                      text: Constants.signIn,
                      style: const TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
