import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tada_local_storage/local_storage_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final TadaLocalStorageHelper _storageHelper;
  AuthCubit(this._storageHelper) : super(AuthInitial());

  checkAuth() {
    emit(_storageHelper.userName.isNotEmpty
        ? Authenthicated(_storageHelper.userName)
        : Unauthenthicated());
  }

  unAuthUser() {
    _storageHelper.setUsername('');
    emit(Unauthenthicated());
  }

  auhtUser(String username) {
    _storageHelper.setUsername(username);
    emit(Authenthicated(username));
  }
}
