part of 'pages.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<UserProvider>(context, listen: false)..getCurrentUser(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    if (userProvider.currentUser == null) {
      return const SigninPage();
    }
    if (userProvider.currentUser != null &&
        userProvider.currentUser?.role == 0) {
      return const AdminHomePage();
    }
    return const MainPage();
  }
}
