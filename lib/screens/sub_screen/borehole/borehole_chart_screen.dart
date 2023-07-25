// ignore_for_file: prefer_const_constructors
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  }

  @override
  void initState() {
    super.initState();
    initializeScreenOrientation();

    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
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
          setState(() {
            loadingPercentage = 100;
          });

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
