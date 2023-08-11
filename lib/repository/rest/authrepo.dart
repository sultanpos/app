import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/user.dart';

class RestAuthRepo {
  final HttpAPI httpApi;
  RestAuthRepo(this.httpApi);

  loginWithUsernamePassword(String username, String password) {
    return httpApi.loginWithUsernamePassword(LoginUsernamePasswordRequest(username, password));
  }

  setLogin(LoginResponse token) {
    httpApi.setLogin(token);
  }

  Future<UserModel> getUser(int id) {
    return httpApi.getOne('/user/$id', fromJsonFunc: UserModel.fromJson);
  }

  Future logout(String refreshToken) {
    return httpApi.logout(refreshToken);
  }

  Future registerNewUser(RegisterRequest registerRequest) {
    return httpApi.post(registerRequest, '/auth/register', skipAuth: true, skipCompanyId: true);
  }
}
