part of '../pages.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  State<ChangePasswordPage> createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value != _newPasswordController.text) {
      return "Please make sure your passwords match";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: edge),
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
                  child: Image.asset('assets/arrow_back_black.png', width: 26),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Current Password',
                  style: mediumFont.copyWith(
                    color: blueGreyColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _currentPasswordController,
                  validator: passwordValidator,
                  decoration: InputDecoration(
                    hintText: 'Your current password...',
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
                        color: secondaryColor,
                        width: 1.5,
                      ),
                      //borderSide: const BorderSide(),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: redColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.only(left: 16),
                  ),
                  autofillHints: const [AutofillHints.email],
                ),
                const SizedBox(height: 16),
                Text(
                  'New Password',
                  style: mediumFont.copyWith(
                    color: blueGreyColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _newPasswordController,
                  validator: passwordValidator,
                  decoration: InputDecoration(
                    hintText: 'Your new password...',
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
                const SizedBox(height: 16),
                Text(
                  'Confirm New Password',
                  style: mediumFont.copyWith(
                    color: blueGreyColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: confirmPasswordValidator,
                  decoration: InputDecoration(
                    hintText: 'Confirm your new password...',
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
                const SizedBox(height: 32),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  )
                else
                  ButtonPrimary(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        final result = await context
                            .read<AuthenticationService>()
                            .changePassword(
                              _currentPasswordController.text,
                              _newPasswordController.text,
                              _confirmPasswordController.text,
                            );

                        setState(() {
                          _isLoading = false;
                        });
                        if (!mounted) {
                          return;
                        }
                        if (result == "success") {
                          Navigator.pop(context);
                          Utils.showSnackBar(
                            context,
                            "Successfully Changed Password",
                            blackColor,
                          );
                        } else {
                          Utils.showSnackBar(
                            context,
                            result ?? "Something went wrong",
                            redColor,
                          );
                        }
                      }
                    },
                    text: "Change Password",
                  ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
