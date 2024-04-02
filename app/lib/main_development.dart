import 'package:flutter/widgets.dart';

import 'app/waste_not_app.dart';
import 'boot/bootstrap.dart';
import 'boot/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  bootstrap(() => const WasteNotApp());
}
