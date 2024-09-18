import 'package:dartz/dartz.dart';
import 'package:diary/core/error/failure.dart';
import 'package:diary/features/secret_entry_code/data/datasources/secret_code_local_data_source.dart';
import 'package:diary/features/secret_entry_code/data/repositories/secret_code_repository.dart';

class SecretCodeRepository extends AbstractSecretCodeRepository {
  final SecretCodeLocalDataSource localDataSource;

  SecretCodeRepository({required this.localDataSource});

  @override
  Future<Either<Failure, void>> removeSecretCode() async {
    try {
      return Right(await localDataSource.removePassword());
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> setSecretCode(String secretCode) async {
    try {
      return Right(await localDataSource.passwordToCache(secretCode));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> validateSecretCode(String secretCode) async {
    try {
      final String? cachedPassword =
          await localDataSource.getPasswordFromCache();

      return Right(cachedPassword == secretCode ? true : false);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, String?>> getSecretCode() async {
    try {
      final String? cachedPassword =
          await localDataSource.getPasswordFromCache();

      return Right(cachedPassword);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }
}
