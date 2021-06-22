import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wepark/data/manager/locationmanager/location_manager.dart';
import 'package:wepark/data/model/entities/element_entity/element_entity.dart';
import 'package:wepark/data/source/action/action_repository.dart';
import 'package:wepark/pages/home/list/list_state.dart';
import 'package:wepark/utils/utils.dart';

class ListBloc extends Cubit<BaseListState> {
  final ActionRepository _actionRepository;
  final LocationManager _locationManager;
  LatLng _myLocation;

  ListBloc(this._actionRepository, this._locationManager)
      : super(InitialListState());

  loadList() {
    // Use Api
    Future(() => _locationManager.getLastLocation())
        .then((value) => value.latLng)
        .then((myLocation) async {
          final list = await _actionRepository.loadCacheElements();
          _myLocation = myLocation;
          return MyLocationComparator.startSortParking(list, myLocation);
    })
        .then((sortList) => emit(DisplayParkingState(sortList,_myLocation)),
        onError: (e) => print("show error: $e"));
  }

  saveElementEntityThenGo(ElementEntity elementEntity) async {
    try {
      await _actionRepository.saveElementEntity(elementEntity);
      emit(NavigateResultState(elementEntity.center));
    } catch (e,stackTrace) {
      var message = "Catch: Something wrong, check again $e";
      print("show error: $e stack: $stackTrace");
    }
  }
}
