import 'package:store/core/utils/result.dart';

// abstract class BaseRepository {
//   Future<Result<T>> execute<T>(Future<T> Function() computation) async {
//     try {
//       return await computation();
//     } catch (error, stackTrace) {
//       ErrorHandler.handleError(error, stackTrace);
//       rethrow;
//     }
//   }

//   T handleDataParsing<T>(T Function() computation) {
//     try {
//       return computation();
//     } catch (error, stackTrace) {
//       throw DataParsingException(
//         'Failed to parse data: $error',
//         stackTrace,
//       );
//     }
//   }
// }
