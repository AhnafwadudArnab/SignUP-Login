import 'package:firebase_aoy/Blocs/LoginBloc/logInState.dart';
import 'package:firebase_aoy/Login_Signup/forget_Password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import '../Blocs/LoginBloc/LogIn_Bloc.dart';
import '../Blocs/LoginBloc/LoginEvent.dart';
import '../utils/dimensions.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            // Gradient background
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red,
                    Colors.orange,
                  ],
                ),
              ),
            ),
            // White container for form fields
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3.4),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimension.radius40),
                  topRight: Radius.circular(Dimension.radius40),
                ),
              ),
            ),
            // FooDash picture and form fields
            Container(
              margin: const EdgeInsets.only(top: 22.0, left: 20.0, right: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/logo6-.png",
                        width: MediaQuery.of(context).size.width / 1.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: Dimension.height45),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                        ),
                        child: const _loginScreenState(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}//UiX form end here//

class _loginScreenState extends StatefulWidget {
  const _loginScreenState();

  @override
  State<_loginScreenState> createState() => _LoginFormState();
}

class _LoginFormState extends State<_loginScreenState> {
  final _formKey = GlobalKey<FormState>();//global key//
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<LoginBloc,Login_State>(listener: (context,State){

          if(State is login_Success){
           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
              return const ForgotPassword(); //home page after login//
            }));
          }
          if(State is login_Failure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: ${State.error}')));
          }
        },
        child: BlocBuilder<LoginBloc,Login_State>(builder: (context,State){
          if(State is login_Loading){
            return const Center(child: CircularProgressIndicator());
          }
          return LoginFormWidget();
        },),
      ),
    ),
    );
  }
    
    //login form widget//
  Widget LoginFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          // Email field
          TextFormField(
            controller: emailTextController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Email";
              } else if (!EmailValidator.validate(value)) {
                return "Invalid Email!";
              }
              return null;
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              hintText: "Email",
            ),
          ),
          // Password field
          SizedBox(height: Dimension.height20),
          TextFormField(
            obscureText: isVisible,
            controller: passwordTextController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Password";
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: isVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              prefixIcon: const Icon(Icons.password_outlined),
              hintText: "Password",
            ),
          ),
          // Sign Up button with loading indicator
          const SizedBox(height: 45),
          BlocBuilder<LoginBloc, Login_State>(
            builder: (context, state) {
              if (state is login_Loading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffff5722), // Background color
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                  ),
                  minimumSize:
                      Size(Dimension.width200, 40), // Adjust height as needed
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(
                          LoginSubmitted(
                            email: emailTextController.text,
                            password: passwordTextController.text,
                          ),
                        );
                  }
                },
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: Dimension.font26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Poopins1",
                  ),
                ),
              );
            },
          ),
          // Already have an account? Sign in button
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                  
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: Dimension.width4),
                Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: Dimension.font20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginSubmitted extends LogIn_Event {
  final String email;

  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Add your imports here

class LoginButtonPressed extends LogIn_Event {
  final String email;

  final String password;

  const LoginButtonPressed({required this.email, required this.password});
}
