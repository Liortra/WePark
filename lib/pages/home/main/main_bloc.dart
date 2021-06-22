import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepark/data/manager/locationmanager/location_manager.dart';
import 'package:wepark/data/source/user/user_repository.dart';
import 'package:wepark/pages/home/main/main_states.dart';

class MainBloc extends Cubit<BaseMainState> {
  SharedPreferences _localStorage;
  final UserRepository _userRepository;
  final LocationManager _locationManager;

  MainBloc(this._locationManager, this._userRepository) : super(MainInitialState());

  checkSharedPreferences() async {
    await init();
    final user = await _userRepository.loadUser();
    if(_localStorage == null || !_localStorage.containsKey(user.userId.email)){
      _localStorage.setInt(user.userId.email+user.username, 100);
      _localStorage.setBool(user.userId.email, false);
    }
  }

  askLocationPermission() async{
    final state = await _locationManager.checkPermissionGranted();
    emit(LocationPermissionState(state));
  }

  logout() async{
    final user = await _userRepository.loadUser();
    _localStorage.setBool(user.userId.email, false);
    emit(MainLogout());
  }

  Future init() async {
    _localStorage = await SharedPreferences.getInstance();
  }

}