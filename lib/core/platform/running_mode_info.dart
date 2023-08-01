import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kDebugMode, kProfileMode, kReleaseMode;
import 'dart:io' show Platform;

class RunningModeInfo {
  RunningModeInfo._();

  static RunningType runningType() {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return RunningType.test;
    }
    if (kDebugMode) {
      return RunningType.debug;
    }
    if (kProfileMode) {
      return RunningType.profile;
    }
    if (kReleaseMode) {
      return RunningType.release;
    }
    return RunningType.debug;
  }
}
enum RunningType { debug, profile, release, test }
extension RunningTypeExt on RunningType {
  bool get isDebug => this == RunningType.debug;

  bool get isProfile => this == RunningType.profile;

  bool get isRelease => this == RunningType.release;

  bool get isTest => this == RunningType.test;
}
