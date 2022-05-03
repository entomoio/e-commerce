import 'package:flutter_test/flutter_test.dart';
import 'package:localization_ecommerce/src/features/authentication/presentation/sign_in/string_validators.dart';

void main() {
  group('string', () {
    test(
      'non empty string',
      () {
        final validator = NonEmptyStringValidator();
        expect(validator.isValid('test'), true);
      },
    );
    test(
      'empty string',
      () {
        final validator = NonEmptyStringValidator();
        expect(validator.isValid(''), false);
      },
    );
    test(
      'null string',
      () {
        final validator = NonEmptyStringValidator();
        expect(validator.isValid(null), false);
      },
    );
  });
  group('email', () {
    test(
      'empty email',
      () {
        final validator = EmailSubmitRegexValidator();
        expect(validator.isValid(''), false);
      },
    );
    test(
      'invalid email',
      () {
        final validator = EmailSubmitRegexValidator();
        expect(validator.isValid('a@a.c'), false);
      },
    );
    test(
      'valid email',
      () {
        final validator = EmailSubmitRegexValidator();
        expect(validator.isValid('a@a.co'), false);
      },
    );
  });
}
