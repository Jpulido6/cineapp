



import 'package:cineapp/infrastructure/datasource/isar_datasource.dart';
import 'package:cineapp/infrastructure/repository/local_storage_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final LocalStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImp(IsarDatasource());
});