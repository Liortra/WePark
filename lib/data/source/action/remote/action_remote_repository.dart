import 'package:wepark/data/source/action/action_data_source.dart';
import 'package:wepark/data/source/action/api/action_api.dart';
import 'package:wepark/data/model/entities/entities.dart';

class ActionRemoteRepository implements ActionDataSourceRemote {
  final ActionApi _api;

  ActionRemoteRepository(this._api);

  @override
  Future<void> markPark(ActionEntity actionEntity) {
    return _api.markPark(actionEntity);
  }

  @override
  Future<List<ElementEntity>> findParking(ActionEntity actionEntity) {
    return _api.findParking(actionEntity);
  }
}
