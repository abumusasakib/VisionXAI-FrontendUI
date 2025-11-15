import 'package:mason/mason.dart';

void run(HookContext context) {
  var name = context.vars['name'];
  context.logger.info('feature name is: $name');
}
