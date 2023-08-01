import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/error/exception.dart';

void main() {

  test('Test ServerException constructor', () {
    // Arrange
    const code = 500;
    const message = 'Server error message';
    final trace = StackTrace.current;

    // Act
    final exception = ServerException(code: code, message: message, trace: trace);

    // Assert
    expect(exception.code, code);
    expect(exception.message, message);
    expect(exception.trace, trace);
  });

  test('Test CacheException constructor', () {
    // Arrange
    const message = 'Cache error message';
    final trace = StackTrace.current;

    // Act
    final exception = CacheException(message: message, trace: trace);

    // Assert
    expect(exception.code, -200);
    expect(exception.message, message);
    expect(exception.trace, trace);
  });

  test('Test ParseException constructor', () {
    // Arrange
    const message = 'Parse error message';
    final trace = StackTrace.current;

    // Act
    final exception = ParseException(message: message, trace: trace);

    // Assert
    expect(exception.code, -300);
    expect(exception.message, message);
    expect(exception.trace, trace);
  });

  test('Test NoElementException constructor', () {
    // Arrange
    const message = 'No element error message';
    final trace = StackTrace.current;

    // Act
    final exception = NoElementException(message: message, trace: trace);

    // Assert
    expect(exception.code, -300);
    expect(exception.message, message);
    expect(exception.trace, trace);
  });

  test('Test ValidationException constructor', () {
    // Arrange
    const message = 'Validation error message';
    final trace = StackTrace.current;

    // Act
    final exception = ValidationException(message: message, trace: trace);

    // Assert
    expect(exception.code, -300);
    expect(exception.message, message);
    expect(exception.trace, trace);
  });

  test('Test ConnectionException constructor', () {
    // Arrange
    const message = 'Connection error message';
    final trace = StackTrace.current;

    // Act
    final exception = ConnectionException(message: message, trace: trace);

    // Assert
    expect(exception.code, -300);
    expect(exception.message, message);
    expect(exception.trace, trace);
  });
}

