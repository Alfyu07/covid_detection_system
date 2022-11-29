part of '../pages.dart';

class AdminManageUsersPage extends StatefulWidget {
  const AdminManageUsersPage({Key? key}) : super(key: key);

  @override
  State<AdminManageUsersPage> createState() => _AdminManageUsersPageState();
}

class _AdminManageUsersPageState extends State<AdminManageUsersPage> {
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
              _header(),
              _searchBar(),
              _userList(),
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
              "Users",
              style: mediumFont.copyWith(
                color: blackColor,
                fontSize: 20,
              ),
            )
          ],
        ),
      );

  Widget _searchBar() {
    final provider = Provider.of<AdminProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(top: edge),
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF1F2F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
            child: Image.asset(
              'assets/search.png',
              width: 24,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextField(
                onTap: () {},
                onSubmitted: (value) {
                  provider.getUsers(value);
                },
                style: regularFont.copyWith(
                  fontSize: 15,
                  color: const Color(0xff595B66),
                ),
                decoration: const InputDecoration(
                  hintText: 'Search user',
                  hintStyle: TextStyle(
                    color: Color(0xffA0ABC0),
                    fontSize: 14,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noData() => Container(
        margin: const EdgeInsets.only(top: 24),
        height: 234,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: AssetImage('assets/img_no_data.png'),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _userList() {
    return Consumer<AdminProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return Container(
            margin: const EdgeInsets.only(top: edge),
            child: Column(
              children: const [
                Center(
                  child: CircularProgressIndicator(color: primaryColor),
                )
              ],
            ),
          );
        }

        if (provider.users.isEmpty) {
          return _noData();
        } else {
          return Column(
            children: provider.users.map((user) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: AdminUserItem(
                  user: user,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AdminEditUserProfilePage(user: user),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
