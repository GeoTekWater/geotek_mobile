import 'dart:async';

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
  Timer? chartInterval;
  int currentFetch = 0;
  var loadingPercentage = 0;
  late final WebViewController controller;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleRefresh() async {
    chartInterval = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        currentFetch += 1;
      });
      debugPrint('[EXECUTING-INTERVAL] :: $currentFetch');

      controller.reload();
    });
  }

  @override
  void initState() {
    super.initState();
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
        },
      ))
      ..loadRequest(
        Uri.parse(
            "https://geotek.com.ng/demo/accelerometer_visualize_styled_SIM_Test.php"),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    _handleRefresh();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    chartInterval!.cancel();
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
