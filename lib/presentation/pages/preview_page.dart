part of 'pages.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key}) : super(key: key);

  static Future<File?> cropImage(File? image) async {
    if (image == null) return null;
    final tempFile = await ImageCropper().cropImage(
      sourcePath: image.path,
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
    final imgProvider = Provider.of<ImgProvider>(context, listen: false);
    final previewProvider = Provider.of<PreviewProvider>(context);
    final diagnosisProvider =
        Provider.of<DiagnoseProvider>(context, listen: false);
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: blackColor,
      body: Stack(
        children: [
          /// Image
          Consumer<ImgProvider>(
            builder: (context, imgProvider, _) => InteractiveViewer(
              minScale: 1.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.file(imgProvider.image!, fit: BoxFit.contain),
              ),
            ),
          ),

          /// Appbar

          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(edge),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Center(
                          child: Image.asset(
                            'assets/arrow_back_white.png',
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Preview',
                      style: whiteMediumFont.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        final File? imgFile =
                            await cropImage(imgProvider.image);
                        imgProvider.image = imgFile;
                      },
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Center(
                          child: Image.asset('assets/crop.png', width: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: edge, vertical: 40),
              child: ButtonPrimary(
                onPressed: () async {
                  previewProvider.isLoading = true;
                  if (imgProvider.image == null) return;

                  final image = imgProvider.image!;
                  final filename = path.basename(image.path);
                  final destination = 'images/predicted_image/$filename';

                  //* predict
                  final output = await EngineService.classifyImage(image);
                  if (output.message != "success") {
                    Fluttertoast.showToast(msg: 'something went wrong');
                    return;
                  }
                  // upload image ke firebase storage
                  final String? imgUrl =
                      await FirebaseApi().uploadFile(destination, image);
                  if (imgUrl == "null") {
                    //TODO : snackbar
                    Fluttertoast.showToast(msg: 'Upload image Failed');
                    return;
                  }

                  //* upload data ke firebase
                  final diagnosis = Diagnosis(
                    id: DateTime.now().toString(),
                    imgUrl: imgUrl,
                    label: output.value!.prediction == "covid"
                        ? "Covid 19"
                        : output.value!.prediction == "pneumonia"
                            ? "Pneumonia"
                            : output.value!.prediction == "normal"
                                ? "Normal"
                                : "null",
                    confidence: output.value!.confidence,
                    date: DateTime.now(),
                    index: output.value!.index,
                  );

                  diagnosisProvider.addDiagnoses(diagnosis).then((value) {
                    diagnosis.id = value;
                    previewProvider.isLoading = false;
                    detailProvider.diagnosis = diagnosis;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DetailPage(),
                      ),
                    );
                  });
                  //*terima data dan bawa ke Detail Page
                },
                text: "Diagnose",
              ),
            ),
          ),
          if (previewProvider.isLoading == true)
            Container(
              color: blackColor.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
