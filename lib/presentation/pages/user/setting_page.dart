part of '../pages.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              children: [
                const SizedBox(height: 40),
                if (userProvider.currentUser == null || userProvider.isLoading)
                  const SkeletonContainer.circular(
                    width: 150,
                    height: 150,
                  )
                else
                  SizedBox(
                    width: 144,
                    height: 144,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 72,
                          backgroundColor: ghostWhiteColor,
                          child: ClipOval(
                            child: userProvider.currentUser!.imgUrl == "null" ||
                                    userProvider.currentUser!.imgUrl == null
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
                                    userProvider.currentUser!.imgUrl!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () async {
                              final image = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                            },
                            child: Image.asset('assets/camera2.png', width: 40),
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(height: 8),
                if (userProvider.isLoading || userProvider.currentUser == null)
                  SkeletonContainer.rounded(
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.6,
                  )
                else
                  Text(
                    userProvider.currentUser!.name ?? "User",
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon_password.png',
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text('Change Password', style: regularFont),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    final user = context.read<User?>();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(user: user),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon_profile.png',
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text('Edit Profile', style: regularFont),
                    ],
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
                    userProvider.signOut().then((value) {
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
}
