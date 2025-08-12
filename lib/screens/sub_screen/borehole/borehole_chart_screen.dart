// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BoreHoleChartScreen extends StatefulWidget {
  const BoreHoleChartScreen({super.key});

  @override
  State<BoreHoleChartScreen> createState() => _BoreHoleChartScreenState();
}

class _BoreHoleChartScreenState extends State<BoreHoleChartScreen> {
  bool isLoading = false;

  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log('[PAGE_LOADING]');
            if (mounted && !isLoading) {
              setState(() {
                isLoading = true;
              });
            }
          },
          onPageStarted: (String url) {
            log('[PAGE_STARTED]');
            if (mounted) {
              setState(() {
                isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            log('[PAGE_FINISHED] :: $url');

            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://geotekwater.com/gcc/display.php'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.reload();
          },
          child: Icon(Icons.refresh),
        ),
        body: SafeArea(
          child: Column(
            children: [
              isLoading == true
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Expanded(
                      child: WebViewWidget(
                        controller: controller,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
