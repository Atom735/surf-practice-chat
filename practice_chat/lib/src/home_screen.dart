import 'package:flutter/material.dart';

class ScreenBackgroundWidget extends StatelessWidget {
  const ScreenBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Image.asset(
        'assets/images/bg.png',
        fit: BoxFit.cover,
      );
}

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Stack(
          fit: StackFit.expand,
          children: const [
            ScreenBackgroundWidget(),
          ],
        ),
      );
}
