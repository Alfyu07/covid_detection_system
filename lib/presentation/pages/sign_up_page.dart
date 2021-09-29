part of 'pages.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  String getRandString(int len) {
    final random = Random.secure();
    final values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Widget build(BuildContext context) {
    final String randString = getRandString(5);
    final provider = Provider.of<SignUpProvider>(context, listen: false);
    final authProvider = Provider.of<AuthenticationApi>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Form(
          key: provider.formKey,
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
                    'Create Account',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text('Please create an account to continue',
                      style: mediumFont.copyWith(color: blueGreyColor)),
                ),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Stack(children: [
                      SizedBox(
                          width: 120,
                          height: 120,
                          child: Consumer<SignUpProvider>(
                              builder: (context, provider, _) {
                            if (provider.image != null) {
                              return ClipOval(
                                child: Image.file(provider.image!,
                                    fit: BoxFit.cover),
                              );
                            }
                            return Image.asset('assets/user_default_avatar.png',
                                fit: BoxFit.cover);
                          })),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            provider.pickImage(ImageSource.gallery);

                            //upload jika belum ada

                            //delete dan upload jika sudah ada
                          },
                          child: Image.asset('assets/camera2.png', width: 40),
                        ),
                      )
                    ]),
                  ),
                ),
                const SizedBox(height: 32),

                // * Name Label

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: edge),
                  child: Text(
                    'Full Name',
                    style: mediumFont.copyWith(
                      color: blueGreyColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // * Email TextField
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: edge),
                  child: TextFormField(
                    onChanged: (value) => provider.fullNameValue = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Full name can't be empty";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: 'Enter your full name',
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
                const SizedBox(height: 24),

                // * Email label
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: edge),
                  child: TextFormField(
                    onChanged: (value) {
                      provider.emailValue = value;
                    },
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
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: secondaryColor, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: redColor, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.only(left: 16)),
                    autofillHints: const [AutofillHints.email],
                  ),
                ),

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
                Consumer<SignUpProvider>(
                  builder: (context, provider, _) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    child: TextFormField(
                      onChanged: (value) => provider.passwordValue = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty";
                        }
                        return null;
                      },
                      obscureText: provider.hidePassword,
                      decoration: InputDecoration(
                          fillColor: ghostWhiteColor,
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              provider.hidePassword = !provider.hidePassword;
                            },
                            icon: provider.hidePassword
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
                            borderSide: const BorderSide(
                                color: secondaryColor, width: 1.5),
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
                ),

                const SizedBox(
                  height: 32,
                ),
                Consumer<SignUpProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: ButtonPrimary(
                          onPressed: () async {
                            if (!provider.formKey.currentState!.validate()) {
                              return;
                            }
                            provider.isLoading = true;
                            String? imgUrl = "null";
                            if (provider.image != null) {
                              final filename =
                                  path.basename(provider.image!.path);
                              final destination = 'images/users/$filename';
                              imgUrl = await FirebaseApi.uploadFile(
                                  destination, provider.image!);
                              //sign up
                            }

                            final resultSignUp = await authProvider.signUp(
                              provider.fullNameValue!,
                              provider.emailValue!,
                              provider.passwordValue!,
                              imgUrl ?? "null",
                            );
                            if (resultSignUp == "Successfully signed up") {
                              Utils.showSnackBar(
                                  context, resultSignUp!, blackColor);
                              provider.isLoading = true;

                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            } else {
                              provider.isLoading = true;
                              Utils.showSnackBar(
                                context,
                                resultSignUp!,
                                redColor,
                              );
                            }
                          },
                          text: "Sign Up",
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: lightFont,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Text(
                        'Login',
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
      ),
    );
  }
}
