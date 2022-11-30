part of 'widgets.dart';

class SelectDiseaseDialog extends StatefulWidget {
  const SelectDiseaseDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectDiseaseDialog> createState() => _SelectDiseaseDialogState();
}

class _SelectDiseaseDialogState extends State<SelectDiseaseDialog> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  String titleCase(String str) {
    final List<String> splitStr = str.toLowerCase().split(" ");

    for (int i = 0; i < splitStr.length; i++) {
      splitStr[i] = splitStr[i][0].toUpperCase() + splitStr[i].substring(1);
    }
    return splitStr.join(' ');
  }

  Widget contentBox(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: edge, vertical: edge),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              Text(
                'Correction',
                style: mediumFont.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Please choose the right diagnosis.',
                style: regularFont.copyWith(color: blueGreyColor, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              Consumer<DetailProvider>(
                builder: (context, provider, _) => InkWell(
                  onTap: () {
                    provider.selectedOption = 0;
                    provider.selectedCorrection = "Normal";
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: provider.selectedOption == 0
                          ? const Color(0xff767EBC)
                          : whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff7090B0).withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 24,
                        )
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Normal',
                        style: mediumFont.copyWith(
                          fontSize: 16,
                          color: provider.selectedOption == 0
                              ? whiteColor
                              : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<DetailProvider>(
                builder: (context, provider, _) => InkWell(
                  onTap: () {
                    provider.selectedOption = 1;
                    provider.selectedCorrection = "Covid 19";
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: provider.selectedOption == 1
                          ? const Color(0xff767EBC)
                          : whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff7090B0).withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 24,
                        )
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Covid 19',
                        style: mediumFont.copyWith(
                          fontSize: 16,
                          color: provider.selectedOption == 1
                              ? whiteColor
                              : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<DetailProvider>(
                builder: (context, provider, _) => InkWell(
                  onTap: () {
                    provider.selectedOption = 2;
                    provider.selectedCorrection = "Pneumonia";
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: provider.selectedOption == 2
                          ? const Color(0xff767EBC)
                          : whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff7090B0).withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 24,
                        )
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pneumonia',
                        style: mediumFont.copyWith(
                          fontSize: 16,
                          color: provider.selectedOption == 2
                              ? whiteColor
                              : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //Lainnya
              Consumer<DetailProvider>(
                builder: (context, provider, _) => InkWell(
                  onTap: () {
                    provider.selectedOption = 3;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: edge,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: provider.selectedOption == 3
                          ? const Color(0xff767EBC)
                          : whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff7090B0).withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 24,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Other: ',
                            style: mediumFont.copyWith(
                              fontSize: 16,
                              color: provider.selectedOption == 3
                                  ? whiteColor
                                  : blackColor,
                            ),
                          ),
                        ),
                        if (provider.selectedOption == 3)
                          SizedBox(
                            width: double.maxFinite,
                            height: 40,
                            child: TextField(
                              onChanged: (value) =>
                                  provider.selectedCorrection = value,
                              controller: controller,
                              style: regularFont.copyWith(
                                color: whiteColor,
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: whiteColor,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),
              ButtonPrimary(
                onPressed: () {
                  final detailProvider =
                      Provider.of<DetailProvider>(context, listen: false);
                  detailProvider.selectedCorrection =
                      titleCase(detailProvider.selectedCorrection ?? "");
                  //TODO : update in db
                  Provider.of<DiagnoseProvider>(context, listen: false)
                      .updateDiagnoses(
                    diagnosis: detailProvider.diagnosis!,
                    label: detailProvider.selectedCorrection,
                    isCorrected: true,
                  )
                      .then((value) {
                    if (value == "Data successfully updated") {
                      detailProvider.diagnosis =
                          detailProvider.diagnosis!.copyWith(
                        label: detailProvider.selectedCorrection,
                        isCorrected: true,
                      );

                      Navigator.pop(context);
                    } else {
                      Utils.showSnackBar(context, value!, redColor);
                    }
                  });
                },
                text: 'Select',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
