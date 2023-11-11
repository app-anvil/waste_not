import 'package:app/app/app.dart';
import 'package:app/bootstrap.dart';
import 'package:app/injection.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  bootstrap(() => const App());
}
