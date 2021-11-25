part of '../developer_part.dart';

/// The widget displays the app version and navigates to the [EnvironmentManage] screen.
class DeveloperAppVersionInfo extends StatefulWidget {
  /// The app version text style.
  final TextStyle? testStyle;

  /// Creates the [DeveloperAppVersionInfo] that displays the app version
  /// and navigates to the [EnvironmentManage] screen.
  const DeveloperAppVersionInfo({Key? key, this.testStyle}) : super(key: key);

  @override
  _DeveloperAppVersionInfoState createState() =>
      _DeveloperAppVersionInfoState();
}

class _DeveloperAppVersionInfoState extends State<DeveloperAppVersionInfo> {
  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _navigateToDeveloperMenu,
      onTap: () {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - lastTap < 500) {
          consecutiveTaps++;
          if (consecutiveTaps > 3) {
            _navigateToDeveloperMenu();
          }
        } else {
          consecutiveTaps = 0;
        }
        lastTap = now;
      },
      child: AppVersionInfo(
        testStyle: widget.testStyle,
      ),
    );
  }

  void _navigateToDeveloperMenu() => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (_) => const EnvironmentManage(),
        ),
      );
}

/// The widget displays the app version.
class AppVersionInfo extends StatelessWidget {
  /// The app version text style.
  final TextStyle? testStyle;

  /// Creates the [AppVersionInfo] that displays the app version.
  const AppVersionInfo({Key? key, this.testStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: snapshot.hasData
            ? Text(
                'ver. ${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                style: testStyle ??
                    const TextStyle(
                      fontSize: 14,
                      height: 2.14,
                    ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
