import 'package:wepark/data/model/diff_time_funcion.dart';
import 'package:wepark/data/model/entities/entities.dart';

class ActionDataSourceLocal {
  Future<void> saveElementEntity(ElementEntity elementEntity) {}

  Future<ElementEntity> loadElement() {}

  Future<void> saveElementEntities(List<ElementEntity> elementEntity) {}

  Future<List<ElementEntity>> loadElements() {}

  Future<void> saveDiffTimePark(DiffTimeFunction diffTimeFunction) {}

  Future<DiffTimeFunction> loadDiffTimePark() {}
}

class ActionDataSourceRemote {
  Future<List<ElementEntity>> findParking(ActionEntity actionEntity) {}

  Future<void> markPark(ActionEntity actionEntity) {}
}
