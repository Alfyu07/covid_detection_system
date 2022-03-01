part of 'widgets.dart';

class SelectDiseaseDialog extends StatelessWidget {
  const SelectDiseaseDialog({
    Key? key,
  }) : super(key: key);

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

  Widget contentBox(BuildContext context) {
    return Stack(
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
                  onTap: () => provider.selectedCorrection = "Covid 19",
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: provider.selectedCorrection == "Covid 19"
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
                          color: provider.selectedCorrection == "Covid 19"
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
                  onTap: () => provider.selectedCorrection = "Pneumonia",
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: provider.selectedCorrection == "Pneumonia"
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
                          color: provider.selectedCorrection == "Pneumonia"
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
                  onTap: () => provider.selectedCorrection = "Normal",
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: provider.selectedCorrection == "Normal"
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
                          color: provider.selectedCorrection == "Normal"
                              ? whiteColor
                              : blackColor,
                        ),
                      ),
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
