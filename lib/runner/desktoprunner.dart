import 'dart:io';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import 'package:sultanpos/runner/runner.dart';
import 'package:yaml_writer/yaml_writer.dart';

enum DesktopDatabaseType implements Comparable<DesktopDatabaseType> {
  postgres('POSTGRES'),
  sqlite('SQLITE');

  final String value;
  const DesktopDatabaseType(this.value);

  factory DesktopDatabaseType.fromValue(String value) {
    return value == "POSTGRES" ? postgres : sqlite;
  }

  @override
  int compareTo(DesktopDatabaseType other) {
    return 0;
  }
}

class DesktopRunnerConfig implements RunnerConfig {
  final String applicationPath;
  final String configFilePath;
  final DesktopDatabaseType databaseType;
  final String databaseHost;
  final String databaseUser;
  final String databasePassword;
  final int databasePort;
  final String databaseName;
  final bool databaseDebug;
  final String listenAddress;
  final int listenPort;
  final String jwtKey;
  final String logLevel;
  DesktopRunnerConfig({
    required this.applicationPath,
    required this.configFilePath,
    this.databaseType = DesktopDatabaseType.sqlite,
    this.databaseHost = "",
    this.databaseUser = "",
    this.databasePassword = "",
    this.databasePort = 0,
    required this.databaseName,
    this.databaseDebug = false,
    this.listenAddress = "0.0.0.0",
    this.listenPort = 6789,
    this.jwtKey = "",
    this.logLevel = "debug",
  });

  factory DesktopRunnerConfig.fromYamlString(String applicationPath, String configFilePath, String yamlString) {
    final yamlDoc = loadYaml(yamlString);
    final dbTypeStr = yamlDoc["DATABASE_TYPE"] ?? "SQLITE";
    return DesktopRunnerConfig(
      configFilePath: configFilePath,
      applicationPath: applicationPath,
      databaseName: yamlDoc["DATABASE_NAME"] ?? "sultanpos",
      databaseDebug: yamlDoc["DATABASE_DEBUG"] ?? false,
      databaseHost: yamlDoc["DATABASE_HOST"] ?? "",
      databasePassword: yamlDoc["DATABASE_PASSWORD"] ?? "",
      databasePort: yamlDoc["DATABASE_PORT"] ?? 5432,
      databaseType: DesktopDatabaseType.fromValue(dbTypeStr),
      databaseUser: yamlDoc["DATABASE_USER"] ?? "",
      jwtKey: yamlDoc["JWT_KEY"] ?? "",
      listenAddress: yamlDoc["SERVER_ADDRESS"] ?? "0.0.0.0",
      listenPort: yamlDoc["SERVER_PORT"] ?? 6789,
      logLevel: yamlDoc["LOG_LEVEL"] ?? "error",
    );
  }

  @override
  String appPath() {
    return applicationPath;
  }

  DesktopRunnerConfig copyWith({
    String? applicationPath,
    String? configFilePath,
    DesktopDatabaseType? databaseType,
    String? databaseHost,
    int? databasePort,
    String? databaseUser,
    String? databasePassword,
    String? databaseName,
    bool? databaseDebug,
    String? listenAddress,
    int? listenPort,
    String? jwtKey,
    String? logLevel,
  }) {
    return DesktopRunnerConfig(
      applicationPath: applicationPath ?? this.applicationPath,
      configFilePath: configFilePath ?? this.configFilePath,
      databaseType: databaseType ?? this.databaseType,
      databaseHost: databaseHost ?? this.databaseHost,
      databasePort: databasePort ?? this.databasePort,
      databaseUser: databaseUser ?? this.databaseUser,
      databasePassword: databasePassword ?? this.databasePassword,
      databaseName: databaseName ?? this.databaseName,
      databaseDebug: databaseDebug ?? this.databaseDebug,
      listenAddress: listenAddress ?? this.listenAddress,
      listenPort: listenPort ?? this.listenPort,
      jwtKey: jwtKey ?? this.jwtKey,
      logLevel: logLevel ?? this.logLevel,
    );
  }

  writeToFile(String path) async {
    final doc = YAMLWriter().write({
      'MIGRATION_FOLDER': "/migration/sql",
      'DATABASE_TYPE': databaseType.value,
      'DATABASE_HOST': databaseHost,
      'DATABASE_PORT': databasePort,
      'DATABASE_USER': databaseUser,
      'DATABASE_PASSWORD': databasePassword,
      'DATABASE_NAME': databaseName,
      'DATABASE_DEBUG': databaseDebug,
      'SERVER_ADDRESS': listenAddress,
      'SERVER_PORT': listenPort,
      'JWT_KEY': jwtKey,
      'LOG_LEVEL': logLevel,
    });
    return doc;
  }
}

class DesktopRunner extends Runner {
  late RunnerConfig config;
  String? lastError;
  Future<ProcessResult>? result;

  @override
  String? errorMessage() {
    return lastError ?? '';
  }

  @override
  Future<bool> isRunning() async {
    return false;
  }

  @override
  Future<bool> run() async {
    final result = await Process.start(config.appPath(), ["server"],
        environment: {},
        workingDirectory: dirname(config.appPath()),
        runInShell: false,
        mode: ProcessStartMode.detached);
    return result.pid > 0;
  }

  @override
  void setup(RunnerConfig config) {
    this.config = config;
  }

  @override
  Future<bool> reload() async {
    final result = Process.runSync(config.appPath(), ["reload"], runInShell: true);
    return result.exitCode == 0;
  }

  @override
  Future<bool> stop() async {
    final result = Process.runSync(config.appPath(), ["stop"], runInShell: true);
    return result.exitCode == 0;
  }
}
