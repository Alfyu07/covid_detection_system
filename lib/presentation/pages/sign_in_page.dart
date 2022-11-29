part of 'pages.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              ClipPath(
                clipper: SignInClipper(),
                child: Container(
                  height: size.height <= 480 ? 320 : size.height * 0.4,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 16),
                  color: primaryColor,
                  child: Image.asset('assets/person_fighting_with_virus.png'),
                ),
              ),

              //Header Text
              const Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Please login to continue',
                  style: mediumFont.copyWith(color: blueGreyColor),
                ),
              ),
              const SizedBox(height: 24),

              // * Email Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: Text(
                  'Email address',
                  style: mediumFont.copyWith(
                    color: blueGreyColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // * Email TextField
              _buildEmailTextField(),
              const SizedBox(height: 24),

              // * Password Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: Text(
                  'Password',
                  style: mediumFont.copyWith(
                    color: blueGreyColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // * Password TextField
              _buildPasswordTextField(),

              const SizedBox(height: 16),

              // * Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResetPasswordPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: edge,
                      ),
                      child: Text(
                        'Forgot password?',
                        style: mediumFont.copyWith(
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // * Signin Button
              const SizedBox(
                height: 40,
              ),

              if (authProvider.isLoading)
                const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: edge),
                  child: ButtonPrimary(
                    onPressed: signIn,
                    text: "Sign In",
                  ),
                ),
              const SizedBox(
                height: 16,
              ),

              //reset password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: regularFont.copyWith(
                        color: blueGreyColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<SignUpProvider>(context, listen: false)
                            .image = null;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 2,
                        ),
                        child: Text(
                          'Sign up',
                          style: boldFont.copyWith(
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 64,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPasswordTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: edge),
      child: TextFormField(
        controller: _passwordController,
        validator: passwordValidator,
        obscureText: _hidePassword,
        decoration: InputDecoration(
          fillColor: ghostWhiteColor,
          filled: true,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
            icon: _hidePassword
                ? const Icon(Icons.visibility_off_outlined)
                : const Icon(Icons.visibility),
          ),
          hintText: 'Enter your password',
          hintStyle: const TextStyle(
            color: blueGreyColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
            //borderSide: const BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: secondaryColor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: redColor, width: 1.5),
          ),
          contentPadding: const EdgeInsets.only(
            left: 16,
          ),
        ),
      ),
    );
  }

  Container _buildEmailTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: edge),
      child: TextFormField(
        controller: _emailController,
        validator: emailValidator,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter your email',
          fillColor: ghostWhiteColor,
          filled: true,
          hintStyle: const TextStyle(
            color: blueGreyColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
            //borderSide: const BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: secondaryColor, width: 1.5),

            //borderSide: const BorderSide(),
          ),
          errorBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: redColor, width: 1.5),

            //borderSide: const BorderSide(),
          ),
          contentPadding: const EdgeInsets.only(left: 16),
        ),
        autofillHints: const [AutofillHints.email],
      ),
    );
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email address can't be empty";
    }
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value);
    if (!emailValid) {
      return "Please enter a valid email address";
    }
    return null;
  }

  void signIn() {
    final messenger = ScaffoldMessenger.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final navProvider = Provider.of<BottomNavProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      authProvider.isLoading = true;

      navProvider.index = 0;
      authProvider
          .signIn(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then(
        (value) {
          authProvider.isLoading = false;

          if (value == "signed in") {
            messenger
              ..removeCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Successfully signed in"),
                  backgroundColor: blackColor,
                ),
              );
          } else {
            messenger
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(value!),
                  backgroundColor: blackColor,
                ),
              );
          }
        },
      );
    }
  }
}
