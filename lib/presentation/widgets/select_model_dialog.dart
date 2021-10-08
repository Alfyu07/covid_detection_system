part of 'widgets.dart';

class SelectModelDialog extends StatelessWidget {
  const SelectModelDialog({Key? key}) : super(key: key);

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
              Image.asset('assets/ai_model.png', height: 36),
              const SizedBox(height: 8),
              Text(
                'Select AI Model',
                style: mediumFont.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Diagnostic result depends on the\nmodel you choose.',
                style: regularFont.copyWith(color: blueGreyColor, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Consumer<AiModelProvider>(
                builder: (context, modelProvider, _) => InkWell(
                  onTap: () => modelProvider.setTempValue("CNN"),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: modelProvider.tempValue == "CNN"
                            ? const Color(0xff767EBC)
                            : whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff7090B0).withOpacity(0.15),
                            offset: const Offset(0, 4),
                            blurRadius: 24,
                          )
                        ]),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CNN',
                        style: mediumFont.copyWith(
                          fontSize: 16,
                          color: modelProvider.tempValue == "CNN"
                              ? whiteColor
                              : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<AiModelProvider>(
                builder: (context, modelProvider, _) => InkWell(
                  onTap: () => modelProvider.setTempValue("KNN"),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: edge),
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: modelProvider.tempValue == "KNN"
                            ? const Color(0xff767EBC)
                            : whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff7090B0).withOpacity(0.15),
                            offset: const Offset(0, 4),
                            blurRadius: 24,
                          )
                        ]),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'KNN',
                        style: mediumFont.copyWith(
                          fontSize: 16,
                          color: modelProvider.tempValue == "KNN"
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
                  Provider.of<AiModelProvider>(context, listen: false)
                      .setValue();
                  Navigator.pop(context);
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
