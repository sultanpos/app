import 'package:jwt_decode/jwt_decode.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/http/httpapi.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/claim.dart';
import 'package:sultanpos/model/user.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/state/base.dart';

class AuthState extends BaseState {
  JWTClaim? claim;
  String? refreshToken;
  User? user;
  bool isLoading = false;

  AuthState(HttpAPI httpAPI) : super(httpAPI);

  final loginForm = FormGroup({
    'username': FormControl<String>(validators: [Validators.required], touched: true),
    'password': FormControl<String>(validators: [Validators.required], touched: true),
    'remember': FormControl<bool>(touched: true),
  });

  loadLogin() async {
    final token = Preference().getToken();
    if (token == null) {
      throw 'token not available';
    }
    return _loadAccessToken(token);
  }

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  login() async {
    if (!loginForm.valid) {
      throw "form is not valid";
    }
    setLoading(true);
    final result = (await httpAPI.loginWithUsernamePassword(LoginUsernamePasswordRequest.fromJson(loginForm.value))).normalizeDate();
    _loadAccessToken(result);
    isLoading = false;
    if (loginForm.control('remember').value ?? false) {
      Preference().storeAuth(result);
    } else {
      Preference().resetLogin();
    }
  }

  _loadAccessToken(LoginResponse token) async {
    httpAPI.setLogin(token);
    claim = JWTClaim.fromJson(Jwt.parseJwt(token.accessToken));
    refreshToken = token.refreshToken;
    try {
      final userResult = await httpAPI.getOne<User>('/user/${claim!.userPublicId}', fromJsonFunc: User.fromJson);
      user = userResult;
    } catch (e) {
      rethrow;
    }
  }

  logout() async {
    claim = null;
    user = null;
    await httpAPI.logout(refreshToken!);
    Preference().resetLogin();
    notifyListeners();
  }
}
