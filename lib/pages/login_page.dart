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
      if(username == 'tes' && password == 'tes') {
        
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: EdgeInsetsGeometry.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 'Login'),
                    SizedBox(height: 20),
                    _loginField(
                      hint: 'Username',
                      inputController: usernameController,
                    ),

                    SizedBox(height: 20),
                    _loginField(
                      hint: 'Password',
                      inputController: passwordController,
                      isPassword: true,
                    ),
                    
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of( context ).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(side: BorderSide()),
                        onPressed: () => login(
                          username: usernameController.text,
                          password: passwordController.text,
                        ),
                        child: Text('Login')
                      ),
                    )
                  ]

                )
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginField({
    required String hint,
    required TextEditingController inputController,
    bool isPassword = false,
  }){
    return TextField(
      controller: inputController,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        )
      ),
    );
  }
}