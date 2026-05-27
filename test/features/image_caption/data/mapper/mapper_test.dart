import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/image_caption/data/mapper/mapper.dart';

class FailingMapper extends MapperImpl<int, String> {
  @override
  String performMap(int from) {
    throw FormatException('Deliberate exception for $from');
  }
}

void main() {
  group('MapperImpl', () {
    test('run logs and rethrows exceptions', () {
      final mapper = FailingMapper();

      expect(
        () => mapper.map(42),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            'Deliberate exception for 42',
          ),
        ),
      );
    });
  });
}
