import 'dart:developer';

import 'package:flutter/foundation.dart';

void debugLog<T>(T value) {
  if (kDebugMode) {
    log("[DEBUG]==> $value");
  }
}
