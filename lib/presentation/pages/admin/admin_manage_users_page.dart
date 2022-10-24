part of '../pages.dart';

class AdminManageUsersPage extends StatefulWidget {
  const AdminManageUsersPage({Key? key}) : super(key: key);

  @override
  State<AdminManageUsersPage> createState() => _AdminManageUsersPageState();
}

class _AdminManageUsersPageState extends State<AdminManageUsersPage> {
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
            Image.asset('assets/arrow_back_black.png', height: 24),
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

  Widget _searchBar() => Container(
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
            // query.isEmpty
            //     ? Container()
            //     : Container(
            //         padding: const EdgeInsets.only(right: 16),
            //         child: Image.asset(
            //           'assets/img/icon_delete.png',
            //           width: 24,
            //         ),
            //       )
          ],
        ),
      );

  Widget _noData() => Container(
        height: 234,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: AssetImage('assets/img_no_data.png'),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _userList() => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 24),
        child: _noData(),
      );

  Widget _searchResults() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminUserItem(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AdminUserItem(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AdminUserItem(),
          )
        ],
      );
}
