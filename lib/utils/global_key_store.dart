import 'package:flutter/material.dart';

class GlobalContext {
  static BuildContext? context;

  static setContext(BuildContext ctx) {
    context = ctx;
  }

  static BuildContext? get get => context;
}
