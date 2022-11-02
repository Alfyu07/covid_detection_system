part of '../pages.dart';

class SendSaranPage extends StatefulWidget {
  const SendSaranPage({Key? key}) : super(key: key);

  @override
  State<SendSaranPage> createState() => _SendSaranPageState();
}

class _SendSaranPageState extends State<SendSaranPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: edge),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appBar(context),
                _header(),
                _image(),
                _textField(),
                _sendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 32),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/arrow_back_black.png', width: 26),
        ),
      );

  Widget _header() => Container(
        margin: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Feedback',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Tell us what we need to improve',
                style: mediumFont.copyWith(color: blueGreyColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );

  Widget _image() => Container(
        margin: const EdgeInsets.only(top: 24),
        child: Center(
          child: SizedBox(
            height: 218,
            width: 244,
            child: Image.asset(
              'assets/email_illustration.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget _textField() => Container(
        padding: const EdgeInsets.only(top: 32),
        child: TextFormField(
          controller: _controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Type your feedback here...',
            fillColor: ghostWhiteColor,
            filled: true,
            hintStyle: const TextStyle(
              color: blueGreyColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
              //borderSide: const BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: secondaryColor,
                width: 1.5,
              ),

              //borderSide: const BorderSide(),
            ),
            errorBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: redColor, width: 1.5),

              //borderSide: const BorderSide(),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          autofillHints: const [AutofillHints.email],
        ),
      );

  Widget _sendButton() => _isLoading
      ? const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 32),
            child: CircularProgressIndicator(color: primaryColor),
          ),
        )
      : Container(
          margin: const EdgeInsets.only(top: 32),
          child: ButtonPrimary(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _isLoading = true;
                });

                final user =
                    await context.read<AuthenticationService>().getLoggedUser();

                final Saran saran = Saran(
                  idUser: user?.uid,
                  text: _controller.text,
                );

                if (!mounted) return;
                final provider =
                    Provider.of<SaranProvider>(context, listen: false);

                final result = await provider.addSaran(saran);

                if (result != null) {
                  setState(() {
                    _isLoading = false;
                  });
                  if (!mounted) return;
                  Utils.showSnackBar(context, "Your feedback sent", greenColor);
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _isLoading = false;
                  });

                  if (!mounted) return;
                  Utils.showSnackBar(
                    context,
                    "Sending feedback failed",
                    redColor,
                  );
                }
              }
            },
            text: "Send",
          ),
        );
}
