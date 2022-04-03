import 'package:flutter/material.dart';

import '../router/i_router.dart';
import '../router/route_info.dart';

class SignUpPage extends MaterialPage {
  SignUpPage()
      : super(
          child: const SignUpScreenWidget(),
          name: const SignUpRouteInfo().path,
          restorationId: const SignUpRouteInfo().path,
        );
}

class SignUpScreenWidget extends StatefulWidget {
  const SignUpScreenWidget({Key? key}) : super(key: key);

  @override
  State<SignUpScreenWidget> createState() => _SignUpScreenWidgetState();
}

class _SignUpScreenWidgetState extends State<SignUpScreenWidget> {
  final fnLogin = FocusNode();
  final fnPassword = FocusNode();

  void handleSubmit([_]) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.7)
          : Colors.white54,
      context: context,
      builder: (context) => const _SignUpLoading(),
    );
  }

  void handleSignUp() {}

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
                'Create new account in Flutter Chat',
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
                child: const Text('Create account'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(128, 32)),
                ),
                onPressed: IAppRouter.of(context).goBack,
                icon: const Icon(Icons.chevron_left),
                label: const Text('Go back'),
              ),
              const Spacer(flex: 7),
            ],
          ),
        ),
      );
}

class _SignUpLoading extends StatefulWidget {
  const _SignUpLoading({Key? key}) : super(key: key);

  @override
  State<_SignUpLoading> createState() => _SignUpLoadingState();
}

class _SignUpLoadingState extends State<_SignUpLoading> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((_) {
      final router = IAppRouter.of(context);
      Navigator.pop(context);
      router.goToSignIn();
    });
  }

  @override
  Widget build(BuildContext context) =>
      const CircularProgressIndicator.adaptive();
}
