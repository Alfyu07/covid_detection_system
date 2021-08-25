part of 'pages.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key}) : super(key: key);

  static Future cropImage(File? image) async {
    if (image == null) return;
    final tempFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
      androidUiSettings: androidUiSettings(),
      iosUiSettings: iosUiSettings(),
    );
    if (tempFile == null) return image;
    return tempFile;
  }

  static IOSUiSettings iosUiSettings() => const IOSUiSettings();
  static AndroidUiSettings androidUiSettings() => const AndroidUiSettings(
        lockAspectRatio: false,
        hideBottomControls: true,
        toolbarTitle: 'Crop Image',
        toolbarColor: Color(0xff767EBC),
        toolbarWidgetColor: Colors.white,
      );

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
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Center(
                            child: Image.asset('assets/arrow_back_white.png',
                                width: 24),
                          ),
                        )),
                    const Spacer(),
                    Text(
                      'Preview',
                      style: whiteMediumFont.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () async {
                          final provider =
                              Provider.of<ImgProvider>(context, listen: false);
                          final imgFile = await cropImage(provider.image);

                          provider.setImage(imgFile as File?);
                        },
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Center(
                            child: Image.asset('assets/crop.png', width: 24),
                          ),
                        )),
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
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  diagnosis: diagnoses[0],
                ),
              ),
            );
          },
          text: "Diagnose",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
