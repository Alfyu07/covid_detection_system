part of '../pages.dart';

class AdminEditUserProfilePage extends StatefulWidget {
  final UserModel user;
  const AdminEditUserProfilePage({Key? key, required this.user})
      : super(key: key);

  @override
  State<AdminEditUserProfilePage> createState() =>
      _AdminEditUserProfilePageState();
}

class _AdminEditUserProfilePageState extends State<AdminEditUserProfilePage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController()..text = widget.user.name!;
    _emailController = TextEditingController()..text = widget.user.email!;
    _passwordController = TextEditingController()..text = "*******";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: edge),
        child: Form(
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
                if (widget.user.imgUrl == null || widget.user.imgUrl == "null")
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipOval(
                        child: SvgPicture.network(
                          "https://avatars.dicebear.com/api/jdenticon/default.svg",
                          width: 120,
                          placeholderBuilder: (context) {
                            return Container(
                              width: 120,
                              color: ghostWhiteColor,
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                else
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.user.imgUrl!,
                      imageBuilder: (context, imgProvider) => CircleAvatar(
                        radius: 60,
                        backgroundColor: ghostWhiteColor,
                        foregroundImage: imgProvider,
                      ),
                      placeholder: (context, url) =>
                          const SkeletonContainer.circular(
                        height: 120,
                        width: 120,
                      ),
                      errorWidget: (context, url, _) =>
                          const SkeletonContainer.circular(
                        height: 120,
                        width: 120,
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
                // * Name TextField

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
                const SizedBox(height: 24),

                // * Email label
                Text(
                  'Email address',
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
                        color: secondaryColor,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: redColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.only(left: 16),
                  ),
                  autofillHints: const [AutofillHints.email],
                ),

                const SizedBox(height: 24),

                // * Password Label
                Text(
                  'Password',
                  style: mediumFont.copyWith(
                    color: blueGreyColor,
                  ),
                ),
                const SizedBox(height: 8),

                // * Password TextField
                TextFormField(
                  // onChanged: (value) => provider.passwordValue = value,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: ghostWhiteColor,
                    filled: true,
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
                        color: secondaryColor,
                        width: 1.5,
                      ),
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

                const SizedBox(
                  height: 32,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonPrimary(
                      width: 100,
                      height: 48,
                      color: Colors.red[400],
                      text: "Delete",
                      onPressed: () {},
                    ),
                    ButtonPrimary(
                      width: 100,
                      height: 48,
                      text: "Edit",
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
