import 'package:flutter/material.dart';

import 'app.dart';
import 'state/app_state.dart';

void main() {
  runApp(
    AppStateScope(
      controller: AppController(),
      child: const ViatoleaPrototypeApp(),
    ),
  );
}
