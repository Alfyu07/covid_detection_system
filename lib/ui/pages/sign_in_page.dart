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
            SafeArea(
              child: ClipPath(
                clipper: SignInClipper(),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: lighGreenColor,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/person_fighting_with_virus.png.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 64),
            Text(
              'Sign In',
              style: TextStyle(
                color: primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please enter your access code',
              style: TextStyle(
                color: greyColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 48),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 56,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Access code',
                  hintStyle: TextStyle(
                    color: lightGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: lightGreyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: greenColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              width: double.infinity,
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(primary: darkGreenColor),
              ),
            ),
            SizedBox(
              height: 64,
            ),
          ],
        ),
      ),
    );
  }
}
