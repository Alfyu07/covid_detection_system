part of 'widgets.dart';

class ResetDialog extends StatelessWidget {
  const ResetDialog({Key? key}) : super(key: key);

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
              Image.asset('assets/reset.png', height: 36),
              Text(
                'Are you sure?',
                style: mediumFont.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Your current model will be lost.',
                style: regularFont.copyWith(color: blueGreyColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 46,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  spacing: 24,
                  children: [
                    ButtonSecondary(
                      width: 96,
                      height: 40,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                    ),
                    ButtonPrimary(
                      width: 96,
                      height: 40,
                      color: redColor,
                      onPressed: () {},
                      text: 'Reset',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
