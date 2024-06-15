import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/authorization/view/bloc/auth_events.dart';
import 'package:yahay/features/authorization/view/bloc/auth_states.dart';
import 'package:yahay/injections/injections.dart';

import 'widgets/authorization_input_widget.dart';
import 'widgets/other_authorization_button_widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailOrUserNameController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  late final StreamSubscription _streamSubscription;
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = snoopy<AuthBloc>();
    _streamSubscription = _authBloc.states.listen((event) {
      if (event is AuthorizedState) {
        AutoRouter.of(context).replaceAll([const HomeRoute()]);
      }
    });
  }

  @override
  void dispose() {
    _emailOrUserNameController.dispose();
    _passwordController.dispose();
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    _streamSubscription.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthStates>(
        stream: _authBloc.states,
        builder: (context, snapshot) {
          final authState = snapshot.data;
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: authState?.authStateModel.loginForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sign In",
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthorizationInputWidget(
                        title: "${Constants.email} or @${Constants.username}",
                        controller: _emailOrUserNameController,
                        hintText: Constants.enterEmailOrUserName,
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
                            top: 25,
                            child: IconButton(
                              onPressed: () => _authBloc.events.add(ChangePasswordVisibility()),
                              icon: Icon(
                                (authState?.authStateModel.showPassword ?? false)
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
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
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            backgroundColor: const WidgetStatePropertyAll(Colors.blueAccent),
                          ),
                          onPressed: () => _authBloc.events.add(
                            LoginEvent(
                                emailOrUserName: _emailOrUserNameController.text,
                                password: _passwordController.text),
                          ),
                          child: Center(
                            child: (authState?.authStateModel.loadingLogin ?? false)
                                ? const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    Constants.signIn,
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
                            Constants.orSignInWith,
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
                      Row(
                        children: [
                          Expanded(
                            child: OtherAuthorizationButtonWidget(
                              icon: const FaIcon(
                                FontAwesomeIcons.google,
                              ),
                              text: 'Google',
                              onTap: () => _authBloc.events.add(GoogleAuth()),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: OtherAuthorizationButtonWidget(
                              icon: const FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue,
                              ),
                              text: 'Facebook',
                              onTap: () => _authBloc.events.add(FacebookAuth()),
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
                            const TextSpan(text: Constants.doNotHaveAnAccount),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => AutoRouter.of(context).replace(const RegisterRoute()),
                              text: Constants.signUp,
                              style: const TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
