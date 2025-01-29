import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/authorization/bloc/auth_bloc.dart';
import 'package:yahay/src/features/authorization/rives/animated_login_character.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';

import 'widgets/authorization_input_widget.dart';
import 'widgets/other_authorization_button_widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final TextEditingController _emailOrUserNameController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  late final AuthBloc _authBloc;
  final AnimatedLoginCharacter _animatedLoginCharacter = AnimatedLoginCharacter();

  @override
  void initState() {
    super.initState();
    _authBloc = DependenciesScope.of(context, listen: false).authBloc;
    _loadLoginArt();
  }

  void _loadLoginArt() async {
    await _animatedLoginCharacter.loadLoginArt();
    setState(() {});
  }

  @override
  void dispose() {
    _emailOrUserNameController.dispose();
    _passwordController.dispose();
    _animatedLoginCharacter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = DependenciesScope.of(context, listen: false);
    return BlocConsumer<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state is AuthorizedStateOnAuthStates) {
            AutoRouter.of(context).replaceAll([const HomeRoute()]);
          }
          if (state.authStateModel.showPassword) {
            _animatedLoginCharacter.handsUp(false);
          } else {
            _animatedLoginCharacter.handsUp(true);
          }
        },
        bloc: _authBloc,
        builder: (context, state) {
          final authStateModel = state.authStateModel;
          return Scaffold(
            backgroundColor: HexColor("#d6e2ea"),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _loginForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 650 was solved before putting value
                      if (MediaQuery.of(context).size.hashCode >=
                              Constants.minimumHeightForShowingRiveTextFieldAnim &&
                          _animatedLoginCharacter.artBoard != null)
                        SizedBox(
                          height: 200,
                          child: Rive(
                            artboard: _animatedLoginCharacter.artBoard!,
                          ),
                        ),
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
                            obscureText: _animatedLoginCharacter.isHandsUp,
                          ),
                          Positioned(
                            right: 0,
                            top: 25,
                            child: IconButton(
                              onPressed: () =>
                                  _authBloc.add(const AuthEvents.changePasswordVisibility()),
                              icon: Icon(
                                (authStateModel.showPassword)
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
                          onPressed: () => _authBloc.add(
                            AuthEvents.loginEvent(
                              emailOrUserName: _emailOrUserNameController.text,
                              password: _passwordController.text,
                              initChatsBloc: () {
                                dependencies.initChatBlocAfterAuthorization();
                              },
                              initDioOptions: () async {
                                await dependencies.dioSettings.initOptions();
                              },
                            ),
                          ),
                          child: Center(
                            child: (authStateModel.loadingLogin)
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
                              onTap: () => _authBloc.add(
                                AuthEvents.googleAuth(
                                  initChatsBloc: () {
                                    dependencies
                                        .initChatBlocAfterAuthorization();
                                  },
                                  initDioOptions: () async {
                                    await dependencies.dioSettings.initOptions();
                                  },
                                ),
                              ),
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
                              onTap: () => _authBloc.add(
                                AuthEvents.facebookAuth(
                                  initChatsBloc: () {
                                    dependencies
                                        .initChatBlocAfterAuthorization();
                                  },
                                  initDioOptions: () async {
                                    await dependencies.dioSettings.initOptions();
                                  },
                                ),
                              ),
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
