import 'package:jwt_decode/jwt_decode.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/claim.dart';
import 'package:sultanpos/model/user.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/repository/rest/authrepo.dart';
import 'package:sultanpos/state/app.dart';
import 'package:sultanpos/state/base.dart';

class AuthState extends BaseState {
  final RestAuthRepo repo;
  JWTClaim? claim;
  String? refreshToken;
  UserModel? user;
  bool isLoading = false;

  final fgUsername = FormControl<String>(validators: [Validators.required], touched: false);
  final fgPassword = FormControl<String>(validators: [Validators.required], touched: false);
  final fgRemember = FormControl<bool>(touched: false);
  late FormGroup loginForm;

  AuthState({required this.repo}) {
    loginForm = FormGroup({
      'username': fgUsername,
      'password': fgPassword,
      'remember': fgRemember,
    });
  }

  resetForm() {
    loginForm.reset();
    loginForm.markAllAsTouched();
  }

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
    final result = (await repo.loginWithUsernamePassword(fgUsername.value!, fgPassword.value!)).normalizeDate();
    _loadAccessToken(result);
    isLoading = false;
    if (loginForm.control('remember').value ?? false) {
      Preference().storeAuth(result);
    } else {
      Preference().resetLogin();
    }
  }

  _loadAccessToken(LoginResponse token) async {
    repo.setLogin(token);
    claim = JWTClaim.fromJson(Jwt.parseJwt(token.accessToken));
    refreshToken = token.refreshToken;
    try {
      final userResult = await repo.getUser(claim!.userId);
      user = userResult;
      notifyListeners();
      AppState().shareState.initAll();
    } catch (e) {
      rethrow;
    }
  }

  logout() async {
    claim = null;
    user = null;
    await repo.logout(refreshToken!);
    Preference().resetLogin();
    notifyListeners();
  }
}
