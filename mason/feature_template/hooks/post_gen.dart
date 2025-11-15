import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  var command = 'fvm';

  // Arguments for the command
  var arguments = ['flutter', 'pub', 'run', 'build_runner', 'build', '-d'];

  final progress = context.logger.progress("running build_runner");
  // Execute the command
  var result = await Process.run(command, arguments);
  progress.complete();

  final progressFMT =
      context.logger.progress("running dart format and fix apply");
  // Execute the command
  result = await Process.run(command, ['dart', 'format', '--fix', 'lib']);
  await Process.run(command, ['dart', 'fix', '--apply', 'lib']);

  progressFMT.complete();
}
