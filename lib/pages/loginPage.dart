import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLoginMode = true;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate login process
    await Future.delayed(Duration(milliseconds: 300));
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>))

    setState(() {
      _isLoading = false;
    });
  }

  void _toggleLoginMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Signup'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (!_isLoginMode)
              TextField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Implement forgot password functionality
                  },
                  child: Text('Forgot Password?'),
                ),
                ElevatedButton(
                  onPressed: _login,
                  child: Text(_isLoginMode ? 'Login' : 'Signup'),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _toggleLoginMode,
              child: Text(_isLoginMode
                  ? 'Don\'t have an account? Signup'
                  : 'Already have an account? Login'),
            ),
            SizedBox(height: 20),
            _isLoading ? CircularProgressIndicator() : SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
