import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'bootstrap.dart';
import 'injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  bootstrap(() => const App());
}
