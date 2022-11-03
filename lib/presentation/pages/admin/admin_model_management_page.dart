part of '../pages.dart';

class AdminModelManagementPage extends StatefulWidget {
  const AdminModelManagementPage({Key? key}) : super(key: key);

  @override
  State<AdminModelManagementPage> createState() =>
      _AdminModelManagementPageState();
}

class _AdminModelManagementPageState extends State<AdminModelManagementPage> {
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
              _header(),
              _selectedModel(),
              _availableModels(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() => Container(
        margin: const EdgeInsets.only(top: edge),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset('assets/arrow_back_black.png', height: 24),
            ),
            const SizedBox(width: 16),
            Text(
              "ML Engine Models",
              style: mediumFont.copyWith(
                color: blackColor,
                fontSize: 20,
              ),
            )
          ],
        ),
      );

  Widget _selectedModel() => Container(
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selected Model",
              style: mediumFont.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            AdminModelItem(
              iconUrl: "assets/icon_models_menu.png",
              title: "Inception Model v.1.0.1",
              date: "Created on 22 Nov 2022",
              onTap: () {},
            ),
          ],
        ),
      );

  Widget _availableModels() => Container(
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Available Models",
              style: mediumFont.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),

            //models item
            AdminModelItem(
              iconUrl: "assets/icon_models_menu.png",
              title: "Inception Model v.1.0.1",
              date: "Created on 22 Nov 2022",
              onTap: () {},
            ),
            AdminModelItem(
              iconUrl: "assets/icon_models_menu.png",
              title: "Inception Model v.1.0.1",
              date: "Created on 22 Nov 2022",
              onTap: () {},
            ),
            AdminModelItem(
              iconUrl: "assets/icon_models_menu.png",
              title: "Inception Model v.1.0.1",
              date: "Created on 22 Nov 2022",
              onTap: () {},
            ),
          ],
        ),
      );
}
