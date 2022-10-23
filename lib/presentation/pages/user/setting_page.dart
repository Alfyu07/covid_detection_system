part of '../pages.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              children: [
                const SizedBox(height: 40),
                StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SkeletonContainer.circular(
                        width: 150,
                        height: 150,
                      );
                    }
                    if (!snapshot.hasData) {
                      return const SkeletonContainer.circular(
                        width: 150,
                        height: 150,
                      );
                    }
                    return CircleAvatar(
                      radius: 72,
                      backgroundColor: ghostWhiteColor,
                      child: ClipOval(
                        child: snapshot.data!.photoURL == "null" ||
                                snapshot.data!.photoURL == null
                            ? SvgPicture.network(
                                "https://avatars.dicebear.com/api/jdenticon/default.svg",
                                width: 150,
                                placeholderBuilder: (context) {
                                  return Container(
                                    width: 150,
                                    color: ghostWhiteColor,
                                  );
                                },
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                snapshot.data!.photoURL!,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SkeletonContainer.rounded(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.6,
                      );
                    }
                    return Text(
                      snapshot.data!.displayName ?? "User",
                      style: mediumFont.copyWith(fontSize: 20),
                    );
                  },
                ),
                const SizedBox(height: 32),
                // Container(
                //   width: double.infinity,
                //   height: 28,
                //   color: ghostWhiteColor,
                //   child: Padding(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //     child: Text('Settings', style: regularFont),
                //   ),
                // ),
                // const SizedBox(height: 16),
                // InkWell(
                //   onTap: () => _showSelectModelDialog(context),
                //   child: Row(
                //     children: [
                //       const SizedBox(width: 8),
                //       Image.asset(
                //         'assets/ai_model.png',
                //         width: 24,
                //       ),
                //       const SizedBox(width: 8),
                //       Text('Classification Model', style: regularFont),
                //       const Spacer(),
                //       Consumer<AiModelProvider>(
                //         builder: (context, modelProvider, _) => Row(
                //           children: [
                //             Text(
                //               modelProvider.selectedValue ?? "",
                //               style: regularFont,
                //             ),
                //             const SizedBox(width: 8),
                //             Image.asset('assets/arrow_right.png', width: 24),
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 16),
                // InkWell(
                //   onTap: () => _showResetModelDialog(context),
                //   child: Row(
                //     children: [
                //       const SizedBox(width: 8),
                //       Image.asset(
                //         'assets/reset.png',
                //         width: 24,
                //       ),
                //       const SizedBox(width: 8),
                //       Text('Reset Model to Default', style: regularFont),
                //       const Spacer(),
                //       Image.asset('assets/arrow_right.png', width: 24),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 28,
                  color: ghostWhiteColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('Settings', style: regularFont),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SendSaranPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon_send.png',
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text('Send Feedback', style: regularFont),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    //Todo : Implement reset password
                    final user = context.read<User?>();
                    if (user != null) {
                      final String? email = user.email;
                      context
                          .read<AuthenticationService>()
                          .sendResetEmail(email!)
                          .then((value) {
                        if (value != "sent") {
                          Utils.showSnackBar(context, value!, redColor);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ResetEmailSent(),
                          ),
                        );
                      });
                    }
                    return;
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon_password.png',
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text('Reset Password', style: regularFont),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    //Todo : Implement Logout
                    context
                        .read<AuthenticationService>()
                        .signOut()
                        .then((value) {
                      if (value == "User logged out") {
                        Provider.of<BottomNavProvider>(context, listen: false)
                            .index = 0;
                        Utils.showSnackBar(context, value!, blackColor);
                      } else {
                        Utils.showSnackBar(context, value!, redColor);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon_logout.png',
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: regularFont.copyWith(color: redColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _showResetModelDialog(BuildContext context) => showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return const ResetDialog();
  //       },
  //     );

  // void _showSelectModelDialog(BuildContext context) => showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return const SelectModelDialog();
  //       },
  //     );
}
