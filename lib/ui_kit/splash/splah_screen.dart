part of '../ui_kit.dart';

///Application splash screen
class AppSplashScreen extends StatelessWidget {
  ///Creates [AppSplashScreen]
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
