// ignore_for_file: prefer_const_constructors
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:al_downloader/al_downloader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
//import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BoreHoleChartScreen extends StatefulWidget {
  const BoreHoleChartScreen({super.key});

  @override
  State<BoreHoleChartScreen> createState() => _BoreHoleChartScreenState();
}

class _BoreHoleChartScreenState extends State<BoreHoleChartScreen> {
  int currentFetch = 0;
  var loadingPercentage = 0;
  late final WebViewController controller;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void initializeScreenOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Permission.storage.request();
  }

  int getRandomIntInRange(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  @override
  void initState() {
    super.initState();
    ALDownloader.initialize();
    ALDownloader.configurePrint(enabled: true, frequentEnabled: false);

    initializeScreenOrientation();

    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (UrlChange url) {
          if (url.toString().endsWith('png')) {
            debugPrint('[URL]  ::  ${url.toString().endsWith('png')}');

            ALDownloader.download(url.toString(),
                directoryPath: '/data/user/0/com.your.app.package/files/',
                fileName: getRandomIntInRange(100, 11000).toString(),
                downloaderHandlerInterface:
                    ALDownloaderHandlerInterface(progressHandler: (progress) {
                  debugPrint(
                      'ALDownloader | download progress = $progress, url = $url\n');
                }, succeededHandler: () {
                  debugPrint('ALDownloader | download succeeded, url = $url\n');
                }, failedHandler: () {
                  debugPrint('ALDownloader | download failed, url = $url\n');
                }, pausedHandler: () {
                  debugPrint('ALDownloader | download paused, url = $url\n');
                }));
          }
        },
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(
            () {
              loadingPercentage = 100;
            },
          );

          //     controller.runJavaScript("""
          // var meta = document.createElement('meta');
          // meta.name = 'viewport';
          // meta.content = 'width=1024px, initial-scale=1';
          // document.getElementsByTagName('head')[0].appendChild(meta);
          // """);
        },
      ))
      ..loadRequest(
        Uri.parse("https://geotek.com.ng/handpump03RR.php"),
        // "https://geotek.com.ng/demo/accelerometer_visualize_styled_SIM_Test.php"),
      )
      // ..setUserAgent(
      //     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537')
      // ..runJavaScript(
      //     "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=1024px, initial-scale=' + (document.documentElement.clientWidth / 1024));")
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.reload();
        },
        child: Icon(Icons.refresh),
        backgroundColor: AppStyles.bgPrimary,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ),
      ),
    );
  }
}
