import 'package:wepark/data/model/diff_time_funcion.dart';
import 'package:wepark/data/source/action/action_data_source.dart';
import 'package:wepark/data/model/entities/entities.dart';

class ActionLocalRepository implements ActionDataSourceLocal {
  ElementEntity _elementEntity;
  List<ElementEntity> _elementEntitiesCache;
  DiffTimeFunction _diffTimeFunctionCache;

  @override
  Future<void> saveDiffTimePark(DiffTimeFunction diffTimeFunction) async {
    _diffTimeFunctionCache = diffTimeFunction;
  }

  @override
  Future<DiffTimeFunction> loadDiffTimePark() async {
    return _diffTimeFunctionCache;
  }

  @override
  Future<List<ElementEntity>> loadElements() async{
    return _elementEntitiesCache;
  }

  @override
  Future<void> saveElementEntities(List<ElementEntity> elementEntity) async{
    _elementEntitiesCache = elementEntity;
  }

  @override
  Future<ElementEntity> loadElement() async{
    return _elementEntity;
  }

  @override
  Future<void> saveElementEntity(ElementEntity elementEntity) async{
    _elementEntity = elementEntity;
  }
}
