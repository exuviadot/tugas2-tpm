import 'package:flutter/material.dart';
import 'package:tugas_2/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void login({
      required String username,
      required String password,
    }){

      final Map<String, String> validUsers = {
        '123230163': 'upn163',   
        '123230001': 'upn001',  
        '123230167': 'upn167',     
        '123230185': 'upn185',      
      };


      if (validUsers.containsKey(username) && validUsers[username] == password) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => HomePage())
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Login Gagal! Username atau Password Salah')
          )
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.deepPurple.shade50],
          ),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.deepPurple.shade100,
                        child: const Icon(Icons.person, size: 50, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Login',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 30),
                      _loginField(
                        hint: 'Username',
                        icon: Icons.person_outline,
                        inputController: usernameController,
                      ),
                      const SizedBox(height: 20),
                      _loginField(
                        hint: 'Password',
                        icon: Icons.lock_outline,
                        inputController: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                          ),
                          onPressed: () => login(
                            username: usernameController.text,
                            password: passwordController.text,
                          ),
                          child: const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginField({
    required String hint,
    required IconData icon,
    required TextEditingController inputController,
    bool isPassword = false,
  }){
    return TextField(
      controller: inputController,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
        )
      ),
    );
  }
}