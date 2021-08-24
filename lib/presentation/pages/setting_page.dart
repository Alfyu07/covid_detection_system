part of 'pages.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/unram_logo.png',
                  width: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(
                  'Universitas Mataram',
                  style: mediumFont.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  height: 28,
                  color: ghostWhiteColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('Settings', style: regularFont),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/ai_model.png',
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Text('Classification Model', style: regularFont),
                    const Spacer(),
                    Row(
                      children: [
                        Text('KNN', style: regularFont),
                        const SizedBox(width: 8),
                        Image.asset('assets/arrow_right.png', width: 24),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/reset.png',
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Text('Reset Model to Default', style: regularFont),
                    const Spacer(),
                    Image.asset('assets/arrow_right.png', width: 24),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 28,
                  color: ghostWhiteColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('Account', style: regularFont),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Text('Reset Password', style: regularFont),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Text('Logout',
                        style: regularFont.copyWith(color: redColor)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
