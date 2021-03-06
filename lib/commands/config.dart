import 'package:args/command_runner.dart';
import 'package:io/ansi.dart';
import 'package:fvm/utils/config_utils.dart';
import 'package:fvm/utils/logger.dart';

/// Config fvm options.
class ConfigCommand extends Command {
  @override
  String get name => 'config';

  @override
  String get description => 'Config fvm options';

  /// Constructor
  ConfigCommand() {
    argParser
      ..addOption('cache-path',
          abbr: 'c', help: 'Path to store Flutter cached versions')
      ..addOption('git-remote',
          abbr: 'r', help: 'Third-party flutter git sources')
      ..addFlag('ls', help: 'Lists all config options');
  }

  @override
  Future<void> run() async {
    final path = argResults['cache-path'] as String;
    if (path != null) {
      ConfigUtils().configFlutterStoredPath(path);
    }

    final gitRemoteUrl = argResults['git-remote'] as String;
    if (gitRemoteUrl != null) {
      ConfigUtils().configGitRemoteUrl(gitRemoteUrl);
    }

    if (argResults['ls'] != null) {
      final configOptions = ConfigUtils().displayAllConfig();
      if (configOptions.isNotEmpty) {
        logger.stdout(green.wrap(configOptions));
      } else {
        throw Exception('No configuration has been set');
      }
    }
  }
}
