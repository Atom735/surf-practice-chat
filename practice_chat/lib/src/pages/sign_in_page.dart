import 'package:flutter/material.dart';

import '../router/i_router.dart';
import '../router/route_info.dart';

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

  void handleSubmit([_]) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.7)
          : Colors.white54,
      context: context,
      builder: (context) => const _SignInLoading(),
    );
  }

  @override
  void dispose() {
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
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Username or email address',
                ),
                autofocus: true,
                restorationId: 'username',
                textInputAction: TextInputAction.next,
                focusNode: fnLogin,
                onFieldSubmitted: (_) => fnPassword.requestFocus(),
              ),
              const SizedBox(height: 32),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Password',
                ),
                restorationId: 'password',
                textInputAction: TextInputAction.done,
                onFieldSubmitted: handleSubmit,
                focusNode: fnPassword,
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
                onPressed: IAppRouter.of(context).goToSignUp,
                label: const Text('Create account'),
              ),
              const Spacer(flex: 7),
            ],
          ),
        ),
      );
}

class _SignInLoading extends StatefulWidget {
  const _SignInLoading({Key? key}) : super(key: key);

  @override
  State<_SignInLoading> createState() => _SignInLoadingState();
}

class _SignInLoadingState extends State<_SignInLoading> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((_) {
      IAppRouter.of(context).goToHome();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) =>
      const CircularProgressIndicator.adaptive();
}
