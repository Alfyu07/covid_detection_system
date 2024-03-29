part of '../pages.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<AdminProvider>(context, listen: false)
        ..getUsers("")
        ..getFeedbacks(""),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: edge, right: edge),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(userProvider),
              _summaries(),
              _menus(),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(UserProvider userProvider) => Container(
        margin: const EdgeInsets.only(top: edge),
        child: Row(
          children: [
            if (userProvider.isLoading || userProvider.currentUser == null)
              const SkeletonContainer.circular(
                width: 40,
                height: 40,
              )
            else
              CircleAvatar(
                radius: 20,
                backgroundColor: ghostWhiteColor,
                child: ClipOval(
                  child: userProvider.currentUser!.imgUrl == "null" ||
                          userProvider.currentUser!.imgUrl == null
                      ? SvgPicture.network(
                          "https://avatars.dicebear.com/api/jdenticon/default.svg",
                          width: 40,
                          placeholderBuilder: (context) {
                            return Container(
                              width: 40,
                              height: 40,
                              color: ghostWhiteColor,
                            );
                          },
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          userProvider.currentUser!.imgUrl!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            const SizedBox(width: 16),
            Text(
              "Hello, Admin",
              style: regularFont.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const Spacer(),
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
              child: Image.asset("assets/icon_logout.png", height: 24),
            ),
          ],
        ),
      );

  Widget _summaries() => Container(
        margin: const EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Summary",
              style: mediumFont.copyWith(
                fontSize: 22,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 145,
              child: ListView(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  diagnosedImageSummaryItem(),
                  activeUsersSummaryItem(),
                  feedbacksSummaryItem(),
                ],
              ),
            ),
          ],
        ),
      );

  Widget diagnosedImageSummaryItem() {
    final provider = Provider.of<AdminProvider>(context, listen: false);
    return FutureBuilder<int>(
      future: provider.getImagesCount(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              margin: const EdgeInsets.only(right: 16),
              child: const SkeletonContainer.rounded(width: 124, height: 145),
            );
          default:
            if (snapshot.hasError) {
              return Container(
                margin: const EdgeInsets.only(right: 16),
                child: const SkeletonContainer.rounded(width: 124, height: 145),
              );
            }
            if (snapshot.hasData) {
              return Container(
                width: 124,
                height: 145,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff434970),
                      Color(0xff999BB1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icon_stethoscope.png",
                          height: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${snapshot.data}",
                      style: mediumFont.copyWith(
                        fontSize: 20,
                        color: whiteColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Diagnosed\nImages",
                      style: regularFont.copyWith(
                        fontSize: 12,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              margin: const EdgeInsets.only(right: 16),
              child: const SkeletonContainer.rounded(width: 124, height: 145),
            );
        }
      },
    );
  }

  Widget activeUsersSummaryItem() {
    final provider = Provider.of<AdminProvider>(context, listen: false);

    return FutureBuilder<int>(
      future: provider.getUsersCount(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              margin: const EdgeInsets.only(right: 16),
              child: const SkeletonContainer.rounded(width: 124, height: 145),
            );
          default:
            if (snapshot.hasError) {
              return Container(
                margin: const EdgeInsets.only(right: 16),
                child: const SkeletonContainer.rounded(width: 124, height: 145),
              );
            }
            if (snapshot.hasData) {
              return Container(
                width: 124,
                height: 145,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff0D0F1B),
                      Color(0xff25294C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Image.asset("assets/icon_users.png", height: 12),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${snapshot.data}",
                      style: mediumFont.copyWith(
                        fontSize: 20,
                        color: whiteColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Active\nUsers",
                      style: regularFont.copyWith(
                        fontSize: 12,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              margin: const EdgeInsets.only(right: 16),
              child: const SkeletonContainer.rounded(width: 124, height: 145),
            );
        }
      },
    );
  }

  Widget feedbacksSummaryItem() {
    final provider = Provider.of<AdminProvider>(context, listen: false);

    return FutureBuilder<int>(
      future: provider.getFeedbacksCount(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              margin: const EdgeInsets.only(right: 16),
              child: const SkeletonContainer.rounded(width: 124, height: 145),
            );
          default:
            if (snapshot.hasError) {
              return Container(
                margin: const EdgeInsets.only(right: 16),
                child: const SkeletonContainer.rounded(width: 124, height: 145),
              );
            }
            if (snapshot.hasData) {
              return Container(
                width: 124,
                height: 145,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff111322),
                      Color(0xff8387A1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: whiteColor.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icon_send_filled.png",
                          height: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${snapshot.data}",
                      style: mediumFont.copyWith(
                        fontSize: 20,
                        color: whiteColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Feedbacks\nreceived",
                      style: regularFont.copyWith(
                        fontSize: 12,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              margin: const EdgeInsets.only(right: 16),
              child: const SkeletonContainer.rounded(width: 124, height: 145),
            );
        }
      },
    );
  }

  Widget _menus() => Container(
        margin: const EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Menu",
              style: mediumFont.copyWith(
                fontSize: 22,
                color: blackColor,
              ),
            ),
            //menu item
            AdminMenuItem(
              iconUrl: "assets/icon_users_menu.png",
              title: "User Management",
              subtitle: "Create, Delete and update\nuser’s data",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminManageUsersPage(),
                  ),
                );
              },
            ),
            AdminMenuItem(
              iconUrl: "assets/icon_feedbacks_menu.png",
              title: "Feedbacks",
              subtitle: "See feedback sent by user",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminFeedbackManagementPage(),
                  ),
                );
              },
            ),
            AdminMenuItem(
              iconUrl: "assets/icon_models_menu.png",
              title: "Machine Learning Models",
              subtitle: "Select a Machine Learning\nmodel to use",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminModelManagementPage(),
                  ),
                );
              },
            ),
          ],
        ),
      );
}
