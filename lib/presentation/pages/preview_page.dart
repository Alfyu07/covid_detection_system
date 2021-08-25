part of 'pages.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgProvider = Provider.of<ImgProvider>(context);
    return Scaffold(
      backgroundColor: blackColor,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.file(imgProvider.image!, fit: BoxFit.contain),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(edge),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset('assets/arrow_back_white.png',
                            width: 26)),
                    const Spacer(),
                    Text(
                      'Preview',
                      style: whiteMediumFont.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    Image.asset('assets/crop.png', width: 26),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(edge),
        child: ButtonPrimary(
          onPressed: () {},
          text: "Diagnose",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
