import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/home_screen.dart';
import 'src/widgets/w_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const AppWidget());
}
