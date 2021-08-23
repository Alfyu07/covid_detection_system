part of 'pages.dart';

class DetailPage extends StatelessWidget {
  final Diagnosis diagnosis;
  const DetailPage({Key? key, required this.diagnosis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          diagnosis.id,
          style: mediumFont,
        ),
      ),
    );
  }
}
