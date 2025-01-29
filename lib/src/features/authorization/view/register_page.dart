import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/authorization/bloc/auth_bloc.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';

import 'widgets/authorization_input_widget.dart';
import 'widgets/other_authorization_button_widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  final TextEditingController _userNameController = TextEditingController(text: '');
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = DependenciesScope.of(context, listen: false).authBloc;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = DependenciesScope.of(context, listen: false);
    return BlocConsumer<AuthBloc, AuthStates>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthorizedStateOnAuthStates) {
            AutoRouter.of(context).replaceAll([const HomeRoute()]);
          }
        },
        builder: (context, state) {
          final authState = state.authStateModel;
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _registerForm,
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
                            top: 25,
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
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            backgroundColor: const WidgetStatePropertyAll(Colors.blueAccent),
                          ),
                          onPressed: () => _authBloc.add(
                            AuthEvents.registerEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              userName: _userNameController.text,
                              initChatsBloc: () {
                                dependencies.initChatBlocAfterAuthorization();
                              },
                              initDioOptions: () async {
                                await dependencies.dioSettings.initOptions();
                              },
                            ),
                          ),
                          child: Center(
                            child: (authState.loadingRegister)
                                ? const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
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
                                    dependencies.initChatBlocAfterAuthorization();
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
                                    dependencies.initChatBlocAfterAuthorization();
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
                            const TextSpan(text: Constants.haveAnAccount),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => AutoRouter.of(context).replace(const LoginRoute()),
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
            ),
          );
        });
  }
}
