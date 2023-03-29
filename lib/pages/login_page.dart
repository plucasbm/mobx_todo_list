import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_todo/pages/todo_page.dart';
import 'package:mobx_todo/stores/login_store.dart';
import 'package:mobx_todo/widgets/custom_icon_button.dart';
import 'package:mobx_todo/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginStore = LoginStore();
  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    disposer = reaction(
      (_) => loginStore.isLoggedIn,
      (loggedIn) {
        if(loggedIn){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ListScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(32),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Observer(builder: (_) {
                  return CustomTextField(
                    hint: 'E-mail',
                    prefix: const Icon(Icons.account_circle),
                    textInputType: TextInputType.emailAddress,
                    onChanged: loginStore.setEmail,
                    enabled: !loginStore.isLoading,
                  );
                }),
                const SizedBox(height: 16),
                Observer(
                  builder: (_) {
                    return CustomTextField(
                      hint: 'Senha',
                      prefix: const Icon(Icons.lock),
                      obscure: loginStore.isObscure,
                      onChanged: loginStore.setPassword,
                      enabled: !loginStore.isLoading,
                      suffix: CustomIconButton(
                        radius: 32,
                        iconData: loginStore.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onTap: loginStore.toggleObscure,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Observer(
                  builder: (_) {
                    return SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: loginStore.isFormValid
                            ? () {
                                loginStore.login();
                              }
                            : null,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Theme.of(context).primaryColor,
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                            (states) => const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: loginStore.isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              )
                            : const Text('Login'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
