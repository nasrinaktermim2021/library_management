import 'package:flutter/material.dart';
import 'package:library_management/pages/admin/admin_book_list_page.dart';
import 'package:library_management/pages/admin/admin_home_page.dart';
import 'package:library_management/pages/admin/admin_signup.dart';
import 'package:library_management/pages/user/user_home_page.dart';
import 'package:library_management/pages/user/user_signup.dart';
import 'package:library_management/providers/admin_provider.dart';
import 'package:library_management/utils/helper_functions.dart';
import 'package:provider/provider.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  static const String routeName = '/adminloginpage';

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  bool _isObsecure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Admin Login Page'),
      ),
      body: Stack(
        children: [
          Container(

      decoration: new BoxDecoration(
      image: new DecorationImage(image: new AssetImage("images/img2.png"), fit: BoxFit.cover,),
    ),
    ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(8, 100, 8, 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,

          ),
          child: Padding(
            padding:  const EdgeInsets.all(8),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: "Enter your email",
                        labelText: "Enter your email",

                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: _isObsecure,
                      obscuringCharacter: "*",
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: "Enter your password",
                        labelText: "Enter your password",
                        suffixIcon: IconButton(
                          icon: Icon(_isObsecure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObsecure = !_isObsecure;
                            });
                          },
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: (){
                            _authenticate();

                          },
                          child: const Text('Login'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, AdminSignup.routeName);
                          },
                          child: const Text('Create new account'),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ElevatedButton(
                      //     onPressed: (){
                      //
                      //     },
                      //     child: const Text('forget password'),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    errMsg,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        )
          ]
      ),
    );
  }

  _authenticate() async{
    final provider = Provider.of<AdminProvider>(context, listen: false);
    if(_formkey.currentState!.validate()){
      final email = emailController.text;
      final password = passwordController.text;
      final admin = await provider.getAdminByEmail(email);
      if(admin == null){
          _setErroMsg('Admin does not exist');

      } else{
        if(password == admin.password){
            Navigator.pushReplacementNamed(context, AdminHomePage.routeName);
        }else {
            _setErroMsg('Wrong password');
        }
      }
    }

  }
  _setErroMsg(String msg) {
    setState(() {
      errMsg = msg;
    });
  }

}


