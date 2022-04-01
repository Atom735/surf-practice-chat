import 'package:flutter/material.dart';

class DebuggerWidget extends StatelessWidget {
  const DebuggerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton.small(
          onPressed: () {},
        ),
      );
}
