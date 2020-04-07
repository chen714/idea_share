import 'package:flutter_test/flutter_test.dart';
import 'package:idea_share/views/preAuth/login_screen.dart';

void main() {
  test('Check for empty password field', () {
    var result = PasswordFieldValidator.validatePassword('');
    expect(result, 'Please provide a password');
  });
  test('Check for filled password field', () {
    var result = PasswordFieldValidator.validatePassword('sfhvsRsa,.*&');
    expect(result, null);
  });
  test('Check max length', () {
    var result = PasswordFieldValidator.validatePassword(
        '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890');
    expect(result, 'Passowrd too long');
  });
}
