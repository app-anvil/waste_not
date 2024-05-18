import 'package:flutter/widgets.dart';

import 'app/waste_not_app.dart';
import 'boot/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(() => const WasteNotApp());
}
