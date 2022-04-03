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
      context: context,
      builder: (context) => const _SignInLoading(),
    );
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
                child: FlutterLogo(
                  size: 512,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Sign in to Flutter Chat',
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
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(128, 32)),
                ),
                onPressed: handleSubmit,
                child: const Text('Sign in'),
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
      final router = IAppRouter.of(context);
      Navigator.pop(context);
      router.goToHome();
    });
  }

  @override
  Widget build(BuildContext context) =>
      const CircularProgressIndicator.adaptive();
}
