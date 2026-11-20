import 'package:flutter/material.dart';
import 'app.dart';

export 'app.dart';
export 'core/constants/app_constants.dart';
export 'core/theme/app_theme.dart';
export 'features/element_details/screens/detail_page.dart';
export 'features/periodic_table/screens/table_page.dart';
export 'features/periodic_table/widgets/element_tile.dart';
export 'features/periodic_table/widgets/empty_tile.dart';
export 'models/element_data.dart';
export 'services/element_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ElementsApp());
}
