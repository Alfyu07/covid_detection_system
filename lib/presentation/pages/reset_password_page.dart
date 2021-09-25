part of 'pages.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    final navProvider =
                        Provider.of<BottomNavProvider>(context, listen: false);
                    navProvider.index = 0;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    child:
                        Image.asset('assets/arrow_back_black.png', width: 26),
                  ),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text('We will sent reset password email to you',
                      style: mediumFont.copyWith(color: blueGreyColor)),
                ),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                    height: 218,
                    width: 244,
                    child: Image.asset('assets/email_illustration.png',
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 32),
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
                        hintText: 'Email',
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
                          borderSide: const BorderSide(
                              color: secondaryColor, width: 1.5),

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
                const SizedBox(
                  height: 32,
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
                      }
                    },
                    text: "Sign In",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Remember password? ',
                        style: lightFont,
                      ),
                      TextSpan(
                        text: 'Resend',
                        style: mediumFont.copyWith(
                            fontWeight: FontWeight.w600, color: secondaryColor),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
