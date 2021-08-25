part of 'pages.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: SignInClipper(),
              child: Container(
                height: 320,
                padding: const EdgeInsets.only(bottom: 16),
                color: primaryColor,
                child: Image.asset('assets/person_fighting_with_virus.png'),
              ),
            ),
            const SizedBox(height: 64),
            const Text(
              'Sign In',
              style: TextStyle(
                color: primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please enter your access code',
              style: TextStyle(
                color: blueGreyColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              height: 56,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Access code',
                    hintStyle: const TextStyle(
                      color: blueGreyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: blueGreyColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: secondaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.only(left: 16)),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: ButtonPrimary(
                onPressed: () {
                  //TODO : implement login
                  final navProvider =
                      Provider.of<BottomNavProvider>(context, listen: false);
                  navProvider.setIndex(0);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
                  );
                },
                text: "Sign In",
              ),
            ),
            const SizedBox(
              height: 64,
            ),
          ],
        ),
      ),
    );
  }
}
