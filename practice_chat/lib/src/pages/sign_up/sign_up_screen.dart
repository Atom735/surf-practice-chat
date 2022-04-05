import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'sign_up_wm_factory.dart';
import 'sign_up_wm_interface.dart';

class SignUpScreen extends ElementaryWidget<ISignUpWidgetModel> {
  const SignUpScreen({
    Key? key,
    WidgetModelFactory wmFactory = signInWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISignUpWidgetModel wm) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 40),
              Expanded(
                flex: 50,
                child: FittedBox(
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_add,
                        size: wm.theme.typography.englishLike.headline5!
                                .fontSize! *
                            4,
                      ),
                      Text(
                        'Create new account in\nFlutter Chat',
                        textAlign: TextAlign.center,
                        style:
                            wm.theme.typography.englishLike.headline5!.copyWith(
                          color: wm.theme.colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 7),
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
              const Spacer(flex: 3),
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
              const Spacer(flex: 2),
              ValueListenableBuilder<String?>(
                valueListenable: wm.errorOther,
                builder: (context, error, child) => error == null
                    ? const SizedBox()
                    : Text(
                        error,
                        style: TextStyle(color: wm.theme.colorScheme.error),
                        maxLines: 5,
                        overflow: TextOverflow.fade,
                      ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(128, 32)),
                ),
                onPressed: wm.handleSubmit,
                icon: const Icon(Icons.done),
                label: const Text('Create account'),
              ),
              const Spacer(),
              OutlinedButton.icon(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(128, 32)),
                ),
                onPressed: wm.handleSignIn,
                icon: const Icon(Icons.login),
                label: const Text('Sign in'),
              ),
              const Spacer(flex: 40),
            ],
          ),
        ),
      );
}
