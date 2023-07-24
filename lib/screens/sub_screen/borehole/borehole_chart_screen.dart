import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/sidebar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BoreHoleChartScreen extends StatefulWidget {
  const BoreHoleChartScreen({super.key});

  @override
  State<BoreHoleChartScreen> createState() => _BoreHoleChartScreenState();
}

class _BoreHoleChartScreenState extends State<BoreHoleChartScreen> {
  Timer? chartInterval;
  int currentFetch = 0;
  bool? _webviewAvailable;
  var loadingPercentage = 0;
  late final WebViewController controller;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleRefresh() async {
    chartInterval = Timer.periodic(const Duration(seconds: 5), (timer) {
      // setState(() {
      //   currentFetch += 1;
      // });
      // debugPrint('[EXECUTING-INTERVAL] :: $currentFetch');

      // controller.reload();
    });
  }

  @override
  void initState() {
    super.initState();
    WebviewWindow.isWebviewAvailable().then((value) {
      setState(() {
        _webviewAvailable = value;
      });
    });

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
      // body: Center(
      //   child: CustomButton(
      //     text: 'Login',
      //     width: double.maxFinite,
      //     // width: 20.0.hp,
      //     height: 6.0.hp,
      //     onTapHandler: () async {
      //       if (_webviewAvailable != true) {
      //         return null;
      //       } else {
      //         final webview = await WebviewWindow.create(
      //           configuration: CreateConfiguration(
      //             userDataFolderWindows: await _getWebViewPath(),
      //             titleBarTopPadding: Platform.isMacOS ? 20 : 0,
      //           ),
      //         );
      //         webview
      //           ..registerJavaScriptMessageHandler("test", (name, body) {
      //             debugPrint('on javaScipt message: $name $body');
      //           })
      //           ..setApplicationNameForUserAgent("WebviewExample/1.0.0")
      //           ..setPromptHandler((prompt, defaultText) {
      //             if (prompt == "test") {
      //               return "Hello World!";
      //             } else if (prompt == "init") {
      //               return "initial prompt";
      //             }
      //             return "";
      //           })
      //           ..addScriptToExecuteOnDocumentCreated("""
      //           const mixinContext = {
      //             platform: 'Desktop',
      //             conversation_id: 'conversationId',
      //             immersive: false,
      //             app_version: '1.0.0',
      //             appearance: 'dark',
      //           }
      //           window.MixinContext = {
      //             getContext: function() {
      //               return JSON.stringify(mixinContext)
      //             }
      //           }
      //         """)
      //           ..launch("https://geotek.com.ng/handpump03RR.php");
      //       }
      //     },
      //     fontSize: constructFontSize(context, 18),
      //     // fontSize: 12.0.sp,
      //     borderRadius: 40,
      //     fontColor: Colors.white,
      //     fontWeight: FontWeight.bold,
      //     backgroundColor: AppStyles.bgPrimary,
      //   ),
      // ),
    );
  }
}

// Future<String> _getWebViewPath() async {
//   final document = await getApplicationDocumentsDirectory();
//   return p.join(
//     document.path,
//     'desktop_webview_window',
//   );
// }
