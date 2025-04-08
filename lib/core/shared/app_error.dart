import '../utils/constants/error_message.dart';

class AppError {
  final String message;
  final int code;

  AppError._defaultError(this.message) : code = 999;

  AppError._notFound(this.message) : code = 404;

  AppError._timeout(this.message) : code = 408;

  AppError._relatedData(this.message) : code = 409;

  AppError._databaseException(this.message) : code = 500;

  AppError.customMessage(this.message) : code = 999;

  static AppError defaultError() {
    return AppError._defaultError(ErrorMessage.defaultError);
  }

  static AppError notFound() {
    return AppError._notFound(ErrorMessage.notFound);
  }

  static AppError timeout() {
    return AppError._timeout(ErrorMessage.timeout);
  }

  static AppError relatedData() {
    return AppError._relatedData(ErrorMessage.relatedData);
  }

  static AppError databaseException(Object error) {
    // Handle unique constraint error (e.g., duplicate )
    // if (error is DatabaseException && error.isUniqueConstraintError()) {
    //   return AppError._databaseException(ErrorMessage.uniqueConstraintError);
    // } else if (error is DatabaseException && error.isNotNullConstraintError()) {
    //   // Handle the case where a not-null constraint is violated
    //   return AppError._databaseException(ErrorMessage.notNullConstraintError);
    // }
    return AppError._databaseException(ErrorMessage.databaseException);
  }
}
