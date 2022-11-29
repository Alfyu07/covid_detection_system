part of '../pages.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;
  const EditProfilePage({Key? key, this.user}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserModel user;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: edge),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/arrow_back_black.png', width: 26),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Edit Profile',
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
                  'Update your user data',
                  style: mediumFont.copyWith(color: blueGreyColor),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child:
                            // provider.image != null
                            //     ? ClipOval(
                            //         child: Image.file(
                            //           provider.image!,
                            //           fit: BoxFit.cover,
                            //         ),
                            //       )
                            // :
                            Image.asset(
                          'assets/user_default_avatar.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .pickImage(
                              ImageSource.gallery,
                            );
                          },
                          child: Image.asset('assets/camera2.png', width: 40),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // * Name Label
              Text(
                'Full Name',
                style: mediumFont.copyWith(
                  color: blueGreyColor,
                ),
              ),
              const SizedBox(height: 8),

              // * Email TextField
              TextFormField(
                onChanged: (value) {},

                // onChanged: (value) => provider.fullNameValue = value,
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
                      color: secondaryColor,
                      width: 1.5,
                    ),

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

              const SizedBox(
                height: 32,
              ),

              // if (authProvider.isLoading)
              //   const Center(
              //     child: CircularProgressIndicator(color: primaryColor),
              //   )
              // else
              ButtonPrimary(
                onPressed: () async {
                  // final navigator = Navigator.of(context);
                  // final scaffoldMessenger = ScaffoldMessenger.of(context);
                  // if (!provider.formKey.currentState!.validate()) {
                  //   return;
                  // }
                  // authProvider.isLoading = true;
                  // String? imgUrl = "null";
                  // if (provider.image != null) {
                  //   final filename = path.basename(provider.image!.path);

                  //   final destination = 'images/users/$filename';
                  //   imgUrl = await provider.uploadImage(
                  //     destination,
                  //     provider.image!,
                  //   );
                  // }

                  // final resultSignUp = await authProvider.signUp(
                  //   fullname: provider.fullNameValue!,
                  //   email: provider.emailValue!,
                  //   password: provider.passwordValue!,
                  //   imgUrl: imgUrl ?? "null",
                  // );

                  // if (resultSignUp == "Successfully signed up") {
                  //   scaffoldMessenger
                  //     ..removeCurrentSnackBar()
                  //     ..showSnackBar(
                  //       SnackBar(
                  //         content: Text(resultSignUp!),
                  //         backgroundColor: blackColor,
                  //       ),
                  //     );

                  //   authProvider.isLoading = false;

                  //   navigator.popUntil((route) => route.isFirst);
                  // } else {
                  //   provider.isLoading = false;
                  //   scaffoldMessenger
                  //     ..removeCurrentSnackBar()
                  //     ..showSnackBar(
                  //       SnackBar(
                  //         content: Text(resultSignUp!),
                  //         backgroundColor: blackColor,
                  //       ),
                  //     );
                  // }
                },
                text: "Sign Up",
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
