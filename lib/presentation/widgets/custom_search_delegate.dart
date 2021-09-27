part of 'widgets.dart';

class CustomSearchDelegate extends SearchDelegate<Diagnosis> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Diagnosis());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: edge),
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseApi.queryData(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator(color: primaryColor)],
            );
          }

          if (snapshot.hasData) {
            return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              final diagnosis = Diagnosis.fromJson(data);
              return DiagnosisCard(
                  diagnosis: diagnosis, onTap: () => close(context, diagnosis));
            }).toList());
          }
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text('No Data')],
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: edge),
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseApi.queryData(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator(color: primaryColor)],
            );
          }

          if (snapshot.hasData) {
            return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              final diagnosis = Diagnosis.fromJson(data);
              return DiagnosisCard(
                  diagnosis: diagnosis, onTap: () => close(context, diagnosis));
            }).toList());
          }
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text('No Data')],
            );
          }
          return Container();
        },
      ),
    );
  }
}
