part of 'pages.dart';

class ResetEmailSent extends StatefulWidget {
  const ResetEmailSent({Key? key}) : super(key: key);

  @override
  _ResetEmailSentState createState() => _ResetEmailSentState();
}

class _ResetEmailSentState extends State<ResetEmailSent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
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
                  child: Image.asset('assets/arrow_back_black.png', width: 26),
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
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: ButtonPrimary(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SigninPage(),
                        ),
                        (route) => false);
                  },
                  text:
                      context.read<User?>() != null ? "Back to Home" : "Login",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive an email? ",
                    style: lightFont,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Resend',
                      style: mediumFont.copyWith(
                          fontWeight: FontWeight.w600, color: secondaryColor),
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
    );
  }
}
