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
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: SignInClipper(),
                child: Container(
                  height: 320,
                  padding: const EdgeInsets.only(bottom: 16),
                  color: primaryColor,
                  child: Image.asset('assets/person_fighting_with_virus.png'),
                ),
              ),
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
                child: Text('Please login to continue',
                    style: mediumFont.copyWith(color: blueGreyColor)),
              ),
              const SizedBox(height: 24),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email address can't be empty";
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
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
                        borderSide:
                            const BorderSide(color: secondaryColor, width: 1.5),

                        //borderSide: const BorderSide(),
                      ),
                      errorBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: redColor, width: 1.5),

                        //borderSide: const BorderSide(),
                      ),
                      contentPadding: const EdgeInsets.only(left: 16)),
                  autofillHints: const [AutofillHints.email],
                ),
              ),
              const SizedBox(height: 24),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    }
                    return null;
                  },
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
                        borderSide:
                            const BorderSide(color: secondaryColor, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: redColor, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                      )),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: ButtonPrimary(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final navProvider = Provider.of<BottomNavProvider>(
                          context,
                          listen: false);
                      navProvider.index = 0;
                      context.read<AuthenticationApi>().signIn(
                          _emailController.text, _passwordController.text);
                    }
                  },
                  text: "Sign In",
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
}
