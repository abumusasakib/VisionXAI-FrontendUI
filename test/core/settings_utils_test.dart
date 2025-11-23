import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/settings/core/utils/settings_utils.dart';

void main() {
  test('returns native name for en and bn', () {
    expect(getLanguageNameFromLocaleId('en'), 'English');
    expect(getLanguageNameFromLocaleId('bn'), 'বাংলা');
    expect(getLanguageNameFromLocaleId('en_US'), 'English');
    expect(getLanguageNameFromLocaleId(''), '');
  });
}
