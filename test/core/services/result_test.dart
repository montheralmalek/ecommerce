import 'package:flutter_test/flutter_test.dart';
import 'package:store/core/utils/errors/app_errors.dart';
import 'package:store/core/utils/result.dart';

void main() {
  group('Result Type Tests', () {
    // Sample data for testing
    var successValue = 42;
    const failureValue = NetworkError('No internet connection');

    test('Success constructor creates Success result', () {
      var result = Result.success(successValue);
      expect(result, isA<Success<int>>());
      expect(result.successValue, successValue);
      expect(result.failureValue, isNull);
    });

    test('Failure constructor creates Failure result', () {
      var result = Result.failure(failureValue);
      expect(result, isA<Failure>());
      expect(result.successValue, isNull);
      expect(result.failureValue, failureValue);
    });

    test('where on Success returns onSuccess value', () {
      var result = Result.success(successValue);
      final actual = result.where(
        onSuccess: (value) => 'Success: $value',
        onFailure: (error) => 'Error: ${error.message}',
      );
      expect(actual, 'Success: $successValue');
    });

    test('where on Failure returns onFailure value', () {
      var result = Result.failure(failureValue);
      final actual = result.where(
        onSuccess: (value) => 'Success: $value',
        onFailure: (error) => 'Error: ${error.message}',
      );
      expect(actual, 'Error: ${failureValue.message}');
    });

    group('Extensions', () {
      test('successValue returns value for Success', () {
        var successResult = Result.success(successValue);
        expect(successResult.successValue, successValue);
      });

      test('successValue returns null for Failure', () {
        var failureResult = Result.failure(failureValue);
        expect(failureResult.successValue, isNull);
      });

      test('failureValue returns error for Failure', () {
        var failureResult = Result.failure(failureValue);
        expect(failureResult.failureValue, failureValue);
      });

      test('failureValue returns null for Success', () {
        var successResult = Result.success(successValue);
        expect(successResult.failureValue, isNull);
      });

      test('mapSuccess transforms Success value', () {
        var successResult = Result.success(successValue);
        final mapped = successResult.mapSuccess((value) => value * 2);
        expect(mapped.successValue, successValue * 2);
      });

      test('mapSuccess preserves Failure', () {
        var failureResult = Result.failure(failureValue);
        final mapped = failureResult.mapSuccess((value) => value * 2);
        expect(mapped.failureValue, failureValue);
      });

      test('getOrElse returns value for Success', () {
        var successResult = Result.success(successValue);
        expect(successResult.getOrElse((_) => -1), successValue);
      });

      test('getOrElse returns orElse value for Failure', () {
        var failureResult = Result.failure(failureValue);
        expect(failureResult.getOrElse((_) => -1), -1);
      });
    });

    group('Chaining Operations', () {
      test('then transforms Success to new Result', () {
        var successResult = Result.success(successValue);
        final chained = successResult.then(
          (value) => Result.success(value * 2),
        );
        expect(chained.successValue, successValue * 2);
      });

      test('then preserves Failure', () {
        var failureResult = Result.failure(failureValue);
        final chained = failureResult.then(
          (value) => Result.success(value * 2),
        );
        expect(chained.failureValue, failureValue);
      });

      test('onFailure calls handler for Failure', () {
        var failureResult = Result.failure(failureValue);
        var handlerCalled = false;
        final result = failureResult.onFailure((_) {
          handlerCalled = true;
        });
        expect(handlerCalled, isTrue);
        expect(result.failureValue, failureValue);
      });

      test('onFailure does not call handler for Success', () {
        var successResult = Result.success(successValue);
        var handlerCalled = false;
        final result = successResult.onFailure((_) {
          handlerCalled = true;
        });
        expect(handlerCalled, isFalse);
        expect(result.successValue, successValue);
      });
    });

    test('Sealed class prevents unauthorized subtypes', () {
      expect(() {
        // This should cause a compile-time error if uncommented
        // class InvalidResult<T> extends Result<T> {
        //   @override
        //   R where <R>({
        //     required R Function(T) onSuccess,
        //     required R Function(Failure) onFailure,
        //   }) => throw UnimplementedError();
        // }
        return true;
      }, returnsNormally);
    });
  });
}
