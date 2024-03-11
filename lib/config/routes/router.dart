import 'package:catbreeds/config/routes/imports.dart';

String get initRoute => AppRoutes.splash;

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case AppRoutes.splash:
      return _buildRoute(
        settings: settings,
        builder: ChangeNotifierProvider(
          create: (_) => SplashProvider(),
          child: const SplashScreen(),
        ),
      );

    default:
      return _errorRoute();
  }
}

MaterialPageRoute _buildRoute({
  required RouteSettings settings,
  required Widget builder,
}) {
  return MaterialPageRoute(
    settings: settings,
    maintainState: true,
    builder: (_) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.primary,
      ),
      child: builder,
    ),
  );
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          title: const Text(
            AppStrings.pathError,
          ),
        ),
        body: const Center(
          child: Text(
            AppStrings.pathError,
            style: TextStyle(color: AppColors.white),
          ),
        ),
      );
    },
  );
}
