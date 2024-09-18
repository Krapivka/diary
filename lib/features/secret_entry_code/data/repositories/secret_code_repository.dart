import 'package:diary/core/error/failure.dart';

import 'package:dartz/dartz.dart';

abstract class AbstractSecretCodeRepository {
  Future<Either<Failure, void>> setSecretCode(String secretCode);
  Future<Either<Failure, String?>> getSecretCode();
  Future<Either<Failure, void>> removeSecretCode();
  Future<Either<Failure, bool>> validateSecretCode(String secretCode);
}
