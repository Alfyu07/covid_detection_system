part of '../pages.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: edge, right: edge),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_header(), _summaries(), _menus()],
          ),
        ),
      ),
    );
  }

  Widget _header() => Container(
        margin: const EdgeInsets.only(top: edge),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: ghostWhiteColor,
              foregroundImage: NetworkImage(
                "https://plus.unsplash.com/premium_photo-1661876567457-d9bd96f4b67f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
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
            Image.asset("assets/menu.png", height: 24),
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

  Container diagnosedImageSummaryItem() {
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
              child: Image.asset("assets/icon_stethoscope.png", height: 12),
            ),
          ),
          const Spacer(),
          Text(
            "67",
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

  Container activeUsersSummaryItem() {
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
            "67",
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

  Container feedbacksSummaryItem() {
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
              child: Image.asset("assets/icon_send_filled.png", height: 12),
            ),
          ),
          const Spacer(),
          Text(
            "67",
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
                    builder: (context) => AdminManageUsersPage(),
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
                    builder: (context) => AdminFeedbackManagementPage(),
                  ),
                );
              },
            ),
            AdminMenuItem(
              iconUrl: "assets/icon_models_menu.png",
              title: "Machine Learning Models",
              subtitle: "Select a Machine Learning\nmodel to use",
              onTap: () {},
            ),
          ],
        ),
      );
}
