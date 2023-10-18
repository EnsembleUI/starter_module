import 'dart:ui';
import 'dart:developer';
import 'package:ensemble/action/call_external_method.dart';
import 'package:ensemble/ensemble_app.dart';
import 'package:ensemble/framework/error_handling.dart';
import 'package:ensemble/framework/widget/error_screen.dart';
import 'package:ensemble/host_platform_manager.dart';
import 'package:ensemble/page_model.dart';
import 'package:flutter/material.dart';
import 'package:starter_module/generated/ensemble_modules.dart';

/// this demonstrates an App running exclusively with Ensemble
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initErrorHandler();
  EnsembleModules().init();
  HostPlatformManager().init();
  runApp(
    const EnsembleApp(
      externalMethods: {
        'sendDataToSwiftUI': sendDataToSwiftUI,
      },
    ),
  );
}

void sendDataToSwiftUI() {
  print('sendDataToSwiftUI called');
  HostPlatformManager().sendData({'title': 'Hello everyone'});
}

void initErrorHandler() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return ErrorScreen(errorDetails);
  };

  /// print errors on console and Chrome dev tool (for Web)
  FlutterError.onError = (details) {
    if (details.exception is EnsembleError) {
      debugPrint(details.exception.toString());
    } else {
      debugPrint(details.exception.toString());
    }
  };

  // async error
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint("Async Error: " + error.toString());
    return true;
  };
}
