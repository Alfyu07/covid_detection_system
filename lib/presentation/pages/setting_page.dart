part of 'pages.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.read<User>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              children: [
                const SizedBox(height: 40),
                CircleAvatar(
                  radius: 72,
                  backgroundColor: ghostWhiteColor,
                  child: ClipOval(
                    child: SvgPicture.network(
                      firebaseUser.photoURL ??
                          "https://avatars.dicebear.com/api/jdenticon/default.svg",
                      width: 150,
                      placeholderBuilder: (context) {
                        return Container(width: 150, color: ghostWhiteColor);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  firebaseUser.displayName ?? "User",
                  style: mediumFont.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 32),
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
                  onTap: () => _showSelectModelDialog(context),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/ai_model.png',
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text('Classification Model', style: regularFont),
                      const Spacer(),
                      Consumer<AiModelProvider>(
                        builder: (context, modelProvider, _) => Row(
                          children: [
                            Text(
                              modelProvider.selectedValue ?? "",
                              style: regularFont,
                            ),
                            const SizedBox(width: 8),
                            Image.asset('assets/arrow_right.png', width: 24),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => _showResetModelDialog(context),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/reset.png',
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text('Reset Model to Default', style: regularFont),
                      const Spacer(),
                      Image.asset('assets/arrow_right.png', width: 24),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 28,
                  color: ghostWhiteColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('Account', style: regularFont),
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
                          .read<AuthenticationApi>()
                          .sendResetEmail(email!)
                          .then((value) {
                        if (value != "sent") {
                          Utils.showSnackBar(context, value!, redColor);
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ResetEmailSent()));
                      });
                    }
                    return;
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Text('Reset Password', style: regularFont),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    //Todo : Implement Logout
                    context.read<AuthenticationApi>().signOut().then((value) {
                      if (value == "User logged out") {
                        Provider.of<BottomNavProvider>(context).index = 0;
                        Utils.showSnackBar(context, value!, blackColor);
                      } else {
                        Utils.showSnackBar(context, value!, redColor);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Text('Logout',
                          style: regularFont.copyWith(color: redColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResetModelDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ResetDialog();
        },
      );

  void _showSelectModelDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SelectModelDialog();
        },
      );
}
