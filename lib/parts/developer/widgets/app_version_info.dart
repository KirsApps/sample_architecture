part of '../developer_part.dart';

/// The widget for display the [AppVersionInfo] and handling taps for the [LogScreen] open.
class DeveloperAppVersionInfo extends StatefulWidget {
  /// The text style of app version.
  final TextStyle? testStyle;

  /// Creates [DeveloperAppVersionInfo]
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

/// Widget for display app version
class AppVersionInfo extends StatelessWidget {
  /// The text style of app version.
  final TextStyle? testStyle;

  /// Creates [AppVersionInfo]
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
                      color: Colors.black12,
                    ),
              )
            : Container(),
      ),
    );
  }
}
