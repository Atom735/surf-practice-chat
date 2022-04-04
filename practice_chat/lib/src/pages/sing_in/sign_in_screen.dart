import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'sign_in_wm_factory.dart';
import 'sign_in_wm_interface.dart';

class SignInScreen extends ElementaryWidget<ISignInWidgetModel> {
  const SignInScreen({
    Key? key,
    WidgetModelFactory wmFactory = signInWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISignInWidgetModel wm) => Scaffold(
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
                style: wm.theme.typography.englishLike.headline5!.copyWith(
                  color: wm.theme.colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 64),
              ValueListenableBuilder<String?>(
                valueListenable: wm.errorLogin,
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
                  focusNode: wm.focusLogin,
                  controller: wm.controllerLogin,
                  onFieldSubmitted: wm.handleLoginDone,
                ),
              ),
              const SizedBox(height: 32),
              ValueListenableBuilder<String?>(
                valueListenable: wm.errorPassword,
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
                  focusNode: wm.focusPassword,
                  controller: wm.controllerPassword,
                  onFieldSubmitted: wm.handleSubmit,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(128, 32)),
                ),
                icon: const Icon(Icons.done),
                onPressed: wm.handleSubmit,
                label: const Text('Sign in'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(128, 32)),
                ),
                icon: const Icon(Icons.person_add),
                onPressed: wm.handleSignUp,
                label: const Text('Create account'),
              ),
              const Spacer(flex: 7),
            ],
          ),
        ),
      );
}
