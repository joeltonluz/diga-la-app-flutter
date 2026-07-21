import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/pictogram_repository_impl.dart';
import '../domain/repositories/pictogram_repository.dart';

final pictogramRepositoryProvider = Provider<PictogramRepository>((ref) {
  return PictogramRepositoryImpl();
});
