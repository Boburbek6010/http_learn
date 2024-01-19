import 'package:flutter/material.dart';
import 'package:http_learn/pages/home_page.dart';
import 'package:http_learn/service/locale_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isLoading = true;

  Future<void> check(String name, String password) async {
    isLoading = false;
    if (name.isNotEmpty && password.isNotEmpty) {
      await AppStorage.write(StorageKey.token, "userToken").then((value) {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: userNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () async{
                        await check(userNameController.text, passController.text).then((value) {
                          if(isLoading){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Muvaffaqiyatli kirildi")));
                            Navigator.pushReplacementNamed(context, HomePage.id);
                          }
                        });
                      },
                      child: const Text("Login"),
                    )
                  ],
                ),
            ),
          )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
