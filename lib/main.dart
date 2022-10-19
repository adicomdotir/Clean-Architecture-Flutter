import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/core/utils/theme.dart';
import 'package:clean_architecture_flutter/core/utils/router.dart';
import 'package:flutter/material.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // _setupLogging();
  runApp(const CleanArchitectureWithBloc());
}

class CleanArchitectureWithBloc extends StatelessWidget {
  const CleanArchitectureWithBloc({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'clean architecture with bloc',
      theme: CustomTheme.mainTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: LOGIN_ROUTE,
    );
  }
}

void _setupLogging() {
  // Logger.root.level = Level.ALL;
  // Logger.root.onRecord.listen((rec) {
  //   print('${rec.level.name}: ${rec.time}: ${rec.message}');
  // });
}
