import 'dart:io';

import 'package:sultanpos/runner/runner.dart';

class DesktopRunner extends Runner {
  late RunnerConfig config;
  String? lastError;
  late Process process;

  @override
  String errorMessage() {
    return lastError ?? '';
  }

  @override
  bool isRunning() {
    // TODO: implement isRunning
    throw UnimplementedError();
  }

  @override
  bool run() {
    // TODO: implement run
    throw UnimplementedError();
  }

  @override
  void setup(RunnerConfig config) {
    this.config = config;
  }

  @override
  bool restart() {
    // TODO: implement restart
    throw UnimplementedError();
  }
}
