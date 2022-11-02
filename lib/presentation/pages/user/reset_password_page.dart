part of '../pages.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
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
                    Navigator.pop(context);
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
                  child: Text(
                    'We will sent reset password email to you',
                    style: mediumFont.copyWith(color: blueGreyColor),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                    height: 218,
                    width: 244,
                    child: Image.asset(
                      'assets/email_illustration.png',
                      fit: BoxFit.cover,
                    ),
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
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value);
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
                        borderSide: const BorderSide(
                          color: secondaryColor,
                          width: 1.5,
                        ),
                        //borderSide: const BorderSide(),
                      ),
                      errorBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: redColor, width: 1.5),

                        //borderSide: const BorderSide(),
                      ),
                      contentPadding: const EdgeInsets.only(left: 16),
                    ),
                    autofillHints: const [AutofillHints.email],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    child: ButtonPrimary(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          final sent = await context
                              .read<AuthenticationService>()
                              .sendResetEmail(_emailController.text);

                          if (sent == "sent") {
                            setState(() {
                              _isLoading = false;
                            });
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ResetEmailSent(
                                  email: _emailController.text,
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            if (!mounted) return;
                            Utils.showSnackBar(context, sent!, redColor);
                          }
                        }
                      },
                      text: "Send",
                    ),
                  ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remember password? ',
                      style: lightFont,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Text(
                        'Back to login page',
                        style: mediumFont.copyWith(
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
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
