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
    final result = (await httpAPI.post<LoginResponse>(LoginUsernamePasswordRequest.fromJson(loginForm.value), skipAuth: true)).normalizeDate();
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
    try {
      final userResult = await httpAPI.get<User>(claim!.userPublicId, fromJsonFunc: User.fromJson, path: '/company/${claim!.companyId}/user');
      user = userResult;
    } catch (e) {
      rethrow;
    }
  }

  logout() {
    claim = null;
    user = null;
    Preference().resetLogin();
    notifyListeners();
  }
}
