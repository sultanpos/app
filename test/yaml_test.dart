import 'dart:math';

import 'package:sultanpos/runner/desktoprunner.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

void main() {
  test(
    "desktop runner yaml",
    () async {
      /*final config = DesktopRunnerConfig(applicationPath: "/home/apin/application", databaseName: "sultanpos");
      final yamlString = await config.writeToFile("");
      print(yamlString);*/

      final yamlString = '''
DATABASE_TYPE: POSTGRES
MIGRATION_FOLDER: /migration/sql
DATABASE_HOST: 127.0.0.1
DATABASE_PORT: 4444
DATABASE_USER: admin
DATABASE_PASSWORD: admin
DATABASE_NAME: pagipagi
DATABASE_DEBUG: false
SERVER_ADDRESS: localhost
SERVER_PORT: 4678
''';

      final config = DesktopRunnerConfig.fromYamlString(yamlString);
      expect(config.databaseHost, '127.0.0.1');
      expect(config.databasePort, 4444);
      expect(config.databaseUser, 'admin');
      expect(config.databasePassword, 'admin');
      expect(config.listenAddress, "localhost");
      expect(config.listenPort, 4678);

      final yamlEdit = YamlEditor(yamlString);
      yamlEdit.update(['DATABASE_HOST'], '192.168.0.1');
      print(yamlEdit.toString());
    },
  );
}
