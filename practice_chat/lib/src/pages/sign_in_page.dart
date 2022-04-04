import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../interfaces/i_app_services.dart';
import '../interfaces/i_auth_service.dart';
import '../mock/mock_auth_service.dart';
import '../interfaces/i_app_router.dart';
import '../common/route_info.dart';

class SignInPage extends MaterialPage {
  SignInPage()
      : super(
          child: const SignInScreenWidget(),
          name: const SignInRouteInfo().path,
          restorationId: const SignInRouteInfo().path,
        );
}

class SignInScreenWidget extends StatefulWidget {
  const SignInScreenWidget({Key? key}) : super(key: key);

  @override
  State<SignInScreenWidget> createState() => _SignInScreenWidgetState();
}

class _SignInScreenWidgetState extends State<SignInScreenWidget> {
  final fnLogin = FocusNode();
  final fnPassword = FocusNode();
  final vnLoginError = ValueNotifier<String?>(null);
  final vnPasswordError = ValueNotifier<String?>(null);
  final tecLogin = TextEditingController();
  final tecPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    tecLogin.addListener(() => vnLoginError.value = null);
    tecPassword.addListener(() => vnPasswordError.value = null);
  }

  void handleSubmit([_]) {
    () async {
      try {
        final key = await context
            .read<IAppServices>()
            .auth
            .signIn(tecLogin.text, tecPassword.text);

        context.read<IAppServices>().router.goToHome();
      } on AuthErrorUnregisteredUser {
        vnLoginError.value = 'unregistred user';
        fnLogin.requestFocus();
      } on AuthErrorIncorrectPassword {
        vnPasswordError.value = 'incorrect password';
        fnPassword.requestFocus();
      } finally {
        Navigator.pop(context);
      }
    }();
    showDialog(
      barrierDismissible: false,
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.7)
          : Colors.white54,
      context: context,
      builder: (context) => const CircularProgressIndicator.adaptive(),
    );
  }

  @override
  void dispose() {
    tecLogin.dispose();
    tecPassword.dispose();
    fnLogin.dispose();
    fnPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 4),
              const Expanded(
                flex: 3,
                child: FittedBox(
                  child: Icon(
                    Icons.login,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Sign in to\nFlutter Chat',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .typography
                    .englishLike
                    .headline5!
                    .copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 64),
              ValueListenableBuilder<String?>(
                valueListenable: vnLoginError,
                builder: (context, error, child) => TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Username or email address',
                    errorText: error,
                  ),
                  autofocus: true,
                  restorationId: 'username',
                  textInputAction: TextInputAction.next,
                  focusNode: fnLogin,
                  controller: tecLogin,
                  onFieldSubmitted: (_) => fnPassword.requestFocus(),
                ),
              ),
              const SizedBox(height: 32),
              ValueListenableBuilder<String?>(
                valueListenable: vnPasswordError,
                builder: (context, error, child) => TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    errorText: error,
                  ),
                  restorationId: 'password',
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: handleSubmit,
                  focusNode: fnPassword,
                  controller: tecPassword,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(128, 32)),
                ),
                icon: const Icon(Icons.done),
                onPressed: handleSubmit,
                label: const Text('Sign in'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(128, 32)),
                ),
                icon: const Icon(Icons.person_add),
                onPressed: context.read<IAppServices>().router.goToSignUp,
                label: const Text('Create account'),
              ),
              const Spacer(flex: 7),
            ],
          ),
        ),
      );
}
