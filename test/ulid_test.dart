import 'package:test/test.dart';
import 'package:ulid/ulid.dart';

main() {
  test('ulid', () {
    final ulid0 = Ulid().toCanonical();
    final ulid1 = Ulid().toCanonical();
    expect(ulid0 != ulid1, isTrue);
  });
}
