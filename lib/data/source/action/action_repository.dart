import 'package:wepark/data/model/diff_time_funcion.dart';
import 'package:wepark/data/source/action/action_data_source.dart';
import 'package:wepark/data/model/entities/entities.dart';

class ActionRepository {
  final ActionDataSourceLocal _local;
  final ActionDataSourceRemote _remote;

  ActionRepository(this._local, this._remote);

  Future<List<ElementEntity>> findParking(ActionEntity actionEntity) {
    return _remote
        .findParking(actionEntity)
        .then((elementEntities) => _local.saveElementEntities(elementEntities))
        .then((_) => _local.loadElements());
  }

  Future<void> saveElementEntity(ElementEntity elementEntity) {
    return _local.saveElementEntity(elementEntity);
  }

  Future<ElementEntity> loadCacheElement() {
    return _local.loadElement();
  }


  Future<Object> markPark(ActionEntity actionEntity) {
    return _remote.markPark(actionEntity);
  }

  Future<List<ElementEntity>> loadCacheElements(){
    return _local.loadElements();
  }

  Future<void> saveDiffTimePark(DiffTimeFunction diffTimeFunction) {
    return _local.saveDiffTimePark(diffTimeFunction);
  }

  Future<DiffTimeFunction> loadDiffTimePark() {
    return _local.loadDiffTimePark();
  }
}
