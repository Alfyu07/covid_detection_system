part of '../pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel currentUser;
  const EditProfilePage({Key? key, required this.currentUser})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController()..text = widget.currentUser.name!;
    _emailController = TextEditingController()
      ..text = widget.currentUser.email!;
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: edge),
        child: SafeArea(
          child: Form(
            key: _formKey,
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

                const SizedBox(height: 40),

                // * Name Label
                Text(
                  'Full Name',
                  style: mediumFont.copyWith(
                    color: blueGreyColor,
                  ),
                ),
                const SizedBox(height: 8),

                // * Full Name
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Full name can't be empty";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: 'John Doe',
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
                    ),
                    errorBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: redColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.only(left: 16),
                  ),
                  autofillHints: const [AutofillHints.email],
                ),
                const SizedBox(height: 16),
                // * Name Label
                Text(
                  'Email',
                  style: mediumFont.copyWith(
                    color: blueGreyColor,
                  ),
                ),
                const SizedBox(height: 8),

                // * Email TextField
                TextFormField(
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
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: 'example@email.com',
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
                    ),
                    errorBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: redColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.only(left: 16),
                  ),
                  autofillHints: const [AutofillHints.email],
                ),
                const SizedBox(
                  height: 32,
                ),

                if (userProvider.isLoading)
                  const Center(
                      child: CircularProgressIndicator(color: primaryColor))
                else
                  ButtonPrimary(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final password = await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: contentBox(context),
                            );
                          },
                        );
                        if (password == null) return;

                        final result = await userProvider.editProfile(
                          newName: _nameController.text,
                          newEmail: _emailController.text,
                          password: password,
                        );

                        if (!mounted) return;
                        if (result != "success") {
                          Utils.showSnackBar(context, result, blackColor);
                        } else {
                          Utils.showSnackBar(
                            context,
                            "Edit profile success",
                            blackColor,
                          );
                        }
                      }
                    },
                    text: "Continue",
                  ),

                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: edge, vertical: edge),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'For security reason, please enter your password',
            style: regularFont.copyWith(color: blueGreyColor, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
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
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: '********',
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
              ),
              errorBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: redColor, width: 1.5),
              ),
              contentPadding: const EdgeInsets.only(left: 16),
            ),
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 16),
          ButtonPrimary(
            onPressed: () {
              Navigator.pop(context, _passwordController.text);
            },
            text: "Edit Profile Now",
          ),
        ],
      ),
    );
  }
}
