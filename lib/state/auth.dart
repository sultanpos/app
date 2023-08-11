import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sultanpos/model/auth.dart';
import 'package:sultanpos/model/claim.dart';
import 'package:sultanpos/model/user.dart';
import 'package:sultanpos/preference.dart';
import 'package:sultanpos/repository/rest/authrepo.dart';
import 'package:sultanpos/state/app.dart';

class AuthState extends ChangeNotifier {
  final RestAuthRepo repo;
  JWTClaim? claim;
  String? refreshToken;
  UserModel? user;
  bool isLoading = false;
  bool isRegistering = false;

  final fgUsername = FormControl<String>(validators: [Validators.required], touched: false);
  final fgPassword = FormControl<String>(validators: [Validators.required], touched: false);
  final fgRemember = FormControl<bool>(touched: false);
  final fgRegisterName = FormControl<String>(validators: [Validators.required]);
  final fgRegisterEmail = FormControl<String>(validators: [Validators.email, Validators.required], touched: false);
  final fgRegisterPassword = FormControl<String>(validators: [Validators.required]);
  late FormGroup loginForm;
  late FormGroup registerForm;

  AuthState({required this.repo}) {
    loginForm = FormGroup({
      'username': fgUsername,
      'password': fgPassword,
      'remember': fgRemember,
    });
    registerForm = FormGroup({
      'name': fgRegisterName,
      'email': fgRegisterEmail,
      'password': fgRegisterPassword,
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
    AppState().global.setupBranch(claim!);
    AppState().afterLogin();
  }

  _loadAccessToken(LoginResponse token) async {
    repo.setLogin(token);
    claim = JWTClaim.fromJson(Jwt.parseJwt(token.accessToken));
    refreshToken = token.refreshToken;
    try {
      final userResult = await repo.getUser(claim!.userId);
      user = userResult;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  logout() async {
    claim = null;
    user = null;
    await repo.logout(refreshToken!);
    await AppState().loggedOut();
    notifyListeners();
  }

  resetRegister() {
    registerForm.reset();
  }

  processRegister() async {
    if (!registerForm.valid) return;
    isRegistering = true;
    notifyListeners();
    final data = RegisterRequest(fgRegisterName.value!, fgRegisterName.value!, fgRegisterEmail.value!,
        fgRegisterEmail.value!, fgRegisterPassword.value!);
    fgUsername.updateValue(fgRegisterEmail.value);
    fgPassword.updateValue(fgRegisterPassword.value);
    try {
      await repo.registerNewUser(data);
      isRegistering = false;
      notifyListeners();
    } catch (e) {
      isRegistering = false;
      notifyListeners();
      rethrow;
    }
  }
}
