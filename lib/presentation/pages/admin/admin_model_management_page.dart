part of '../pages.dart';

class AdminModelManagementPage extends StatefulWidget {
  const AdminModelManagementPage({Key? key}) : super(key: key);

  @override
  State<AdminModelManagementPage> createState() =>
      _AdminModelManagementPageState();
}

class _AdminModelManagementPageState extends State<AdminModelManagementPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<EngineProvider>(context, listen: false)
        ..getModels()
        ..getSelectedModel(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final engineProvider = Provider.of<EngineProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: edge),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _selectedModel(engineProvider),
              _availableModels(engineProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() => Container(
        margin: const EdgeInsets.only(top: edge),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset('assets/arrow_back_black.png', height: 24),
            ),
            const SizedBox(width: 16),
            Text(
              "ML Engine Models",
              style: mediumFont.copyWith(
                color: blackColor,
                fontSize: 20,
              ),
            )
          ],
        ),
      );

  Widget _selectedModel(EngineProvider engineProvider) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selected Model",
            style: mediumFont.copyWith(
              fontSize: 16,
              color: blackColor,
            ),
          ),
          if (engineProvider.selectedModel == null || engineProvider.isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: buildSkeleton(context),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AbsorbPointer(
                child: AdminModelItem(
                  engineModel: engineProvider.selectedModel!,
                  onTap: () {},
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _availableModels(EngineProvider engineProvider) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Models",
            style: mediumFont.copyWith(
              fontSize: 16,
              color: blackColor,
            ),
          ),

          //models item

          if (engineProvider.isLoading)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: buildSkeleton(context),
                  )
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: engineProvider.models
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: AdminModelItem(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(28)),
                            ),
                            barrierColor: blackColor.withOpacity(0.2),
                            context: context,
                            builder: (BuildContext context) => ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(28),
                                topRight: Radius.circular(28),
                              ),
                              child: buildSheet(engineProvider, e),
                            ),
                          );

                          // engineProvider.setModel(e);
                        },
                        engineModel: e,
                      ),
                    ),
                  )
                  .toList(),
            )
        ],
      ),
    );
  }

  Widget buildSkeleton(BuildContext context) {
    return Row(
      children: [
        const SkeletonContainer.circular(
          width: 64,
          height: 64,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            SkeletonContainer.rounded(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 16,
            ),
            const SizedBox(height: 8),
            const SkeletonContainer.rounded(
              width: 60,
              height: 12,
            ),
            const SizedBox(height: 16),
          ],
        )
      ],
    );
  }

  Widget buildSheet(EngineProvider provider, EngineModel e) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Center(
            child: Container(
              height: 4,
              width: 36,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Color(0xffBABEDE),
              ),
            ),
          ),
          const SizedBox(height: edge),
          const Text(
            'Are you sure?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: edge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 120,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "No",
                      style: boldFont.copyWith(
                        color: primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.setModel(e);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 120,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      "Yes",
                      style: boldFont.copyWith(
                        color: whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: edge),
        ],
      );
}
