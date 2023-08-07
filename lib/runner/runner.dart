abstract class RunnerConfig {
  String appPath();
}

abstract class Runner {
  void setup(RunnerConfig config);
  Future<bool> run();
  Future<bool> isRunning();
  String? errorMessage();
  Future<bool> reload();
  Future<bool> stop();
}
