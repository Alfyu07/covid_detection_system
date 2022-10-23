part of '../pages.dart';

class ResetEmailSent extends StatefulWidget {
  final String? email;
  const ResetEmailSent({Key? key, this.email}) : super(key: key);

  @override
  _ResetEmailSentState createState() => _ResetEmailSentState();
}

class _ResetEmailSentState extends State<ResetEmailSent> {
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
                  'Email has been sent!',
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
                  'Please check your email and click in the\nreceived link to reset your password',
                  style: mediumFont.copyWith(color: blueGreyColor),
                  textAlign: TextAlign.center,
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
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: ButtonPrimary(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
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
                    onTap: () {
                      final user = context.read<User?>();
                      if (user != null) {
                        final String? email = user.email;
                        context
                            .read<AuthenticationService>()
                            .sendResetEmail(email!)
                            .then(
                          (value) {
                            if (value != "sent") {
                              Utils.showSnackBar(context, value!, redColor);
                            } else {
                              Utils.showSnackBar(
                                context,
                                "Email successfully sent",
                                blackColor,
                              );
                            }
                          },
                        );
                      } else {
                        context
                            .read<AuthenticationService>()
                            .sendResetEmail(widget.email!)
                            .then(
                          (value) {
                            if (value != "sent") {
                              Utils.showSnackBar(context, value!, redColor);
                            } else {
                              Utils.showSnackBar(context, value!, blackColor);
                            }
                          },
                        );
                      }
                    },
                    child: Text(
                      'Resend',
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
    );
  }
}
