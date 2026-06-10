import 'package:flutter/material.dart';

import '../../../../config/network/api_client.dart';
import '../../../../config/network/endpoints.dart';
import '../../../../consts/app_colors.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/my_text_widget.dart';
class PrivacyPolicy extends StatefulWidget {
const PrivacyPolicy({super.key});

@override
State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}
class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final ApiClient _apiClient = ApiClient();
  late Future<dynamic> _policyData;

  @override
  void initState() {
    super.initState();
    // API Hit
    _policyData = _apiClient.getPublicResponse(endpoint: Endpoints.privacy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(context: context, title: 'Privacy Policy', centerTitle: true),
      body: FutureBuilder<dynamic>(
        future: _policyData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {

            final content = snapshot.data['content'] ?? "No content available";
            return ListView(
              padding: const EdgeInsets.all(22),
              children: [
                MyText(text: content, size: 14, color: kblack2),
              ],
            );
          }
          return const Center(child: Text("No data found"));
        },
      ),
    );
  }
}