import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool isObscure = true;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void toggleObscure() => isObscure = !isObscure;

  @action
  Future<void> login() async{
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    isLoggedIn = true;
  }

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  bool get isEmailValid => email.contains('@');

  @computed
  bool get isFormValid => isPasswordValid && isEmailValid;
}