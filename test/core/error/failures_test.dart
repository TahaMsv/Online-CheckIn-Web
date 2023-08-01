import 'package:flutter_test/flutter_test.dart';
import 'package:online_check_in/core/error/exception.dart';
import 'package:online_check_in/core/error/failures.dart';

void main() {
  test('Test ServerFailure constructor', () {
    // Arrange
    const code = 500;
    const msg = 'Server failure message';
    const traceMsg = 'Server failure trace message';

    // Act
    final failure = ServerFailure(code: code, msg: msg, traceMsg: traceMsg);

    // Assert
    expect(failure.code, code);
    expect(failure.msg, msg);
    expect(failure.traceMsg, traceMsg);
  });

  test('Test ServerFailure fromAppException factory', () {
    // Arrange
    const message = 'Cache error message';
    final trace = StackTrace.current;

    // Act
    final appException = CacheException(message: message, trace: trace);
    // Act
    final failure = ServerFailure.fromAppException(appException);

    // Assert
    expect(failure.code, appException.code);
    expect(failure.msg, appException.message);
    expect(failure.traceMsg, appException.traceMsg);
  });

  test('Test CacheFailure constructor', () {
    // Arrange
    const code = 404;
    const msg = 'Cache failure message';
    const traceMsg = 'Cache failure trace message';

    // Act
    final failure = CacheFailure(code: code, msg: msg, traceMsg: traceMsg);

    // Assert
    expect(failure.code, code);
    expect(failure.msg, msg);
    expect(failure.traceMsg, traceMsg);
  });

  test('Test CacheFailure fromAppException factory', () {
    // Arrange
    const code = 500;
    const message = 'Server error message';
    final trace = StackTrace.current;

    // Act
    final appException = ServerException(code: code, message: message, trace: trace);

    // Act
    final failure = CacheFailure.fromAppException(appException);

    // Assert
    expect(failure.code, appException.code);
    expect(failure.msg, appException.message);
    expect(failure.traceMsg, appException.traceMsg);
  });

  // Add tests for other failure classes (ValidationFailure, NoElementFailure, ConnectionFailure) if needed
}


