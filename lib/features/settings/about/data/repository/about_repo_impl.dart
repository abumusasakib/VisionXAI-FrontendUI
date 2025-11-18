import 'dart:developer' as developer;

import '../../domain/entity/about_entity.dart';
import '../../domain/repository/about_repo.dart';
import '../datasource/about_local_data_source.dart';
import '../mapper/about_mapper.dart';
import '../model/about_model.dart';

class AboutRepoImpl implements AboutRepo {
  final AboutLocalDataSource _local;
  final AboutMapper _mapper;

  AboutRepoImpl(this._local, this._mapper);

  @override
  Future<AboutEntity> loadAppInfo() async {
    final AboutModel model = await _local.fetchAppInfo();
    try {
      developer.log('AboutModel loaded: ${model.toJson()}',
          name: 'AboutRepoImpl');
    } catch (_) {}
    return _mapper.modelToEntity(model);
  }
}
