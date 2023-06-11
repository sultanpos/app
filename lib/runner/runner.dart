abstract class RunnerConfig {
  String rootPath();
}

abstract class Runner {
  void setup(RunnerConfig config);
  bool run();
  bool isRunning();
  String errorMessage();
  bool restart();
}
