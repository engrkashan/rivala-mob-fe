import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/tax_documentation/tax_documentation.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../../controllers/providers/tax_document_provider.dart';
import '../../../../../../models/tax_document.dart';

class TaxDocumentsListScreen extends StatefulWidget {
  const TaxDocumentsListScreen({super.key});

  @override
  State<TaxDocumentsListScreen> createState() => _TaxDocumentsListScreenState();
}

class _TaxDocumentsListScreenState extends State<TaxDocumentsListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TaxDocumentProvider>().fetchTaxDocuments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: 'Tax Documents',
        centerTitle: true,
      ),
      body: Consumer<TaxDocumentProvider>(
        builder: (context, provider, _) {
          final List<TaxDocumentModel> docs = provider.documents;
          print('Docs length: ${docs.length}');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),

              /// ➕ Add New Document Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: GestureDetector(
                  onTap: () {
                    // TODO: Navigate to Add Tax Document Screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TaxDocumentation()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: kblack,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: MyText(
                      text: '+ Add New Document',
                      color: kwhite,
                      size: 15,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Content
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : docs.isEmpty
                        ? Center(
                            child: MyText(
                              text: 'No tax documents found',
                              size: 14,
                              color: kblack,
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 10,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemCount: docs.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => TaxDocumentation(
                                                model: docs[index],
                                              ))),
                                  child: _documentCard(docs[index]));
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 📄 Document Card
  Widget _documentCard(TaxDocumentModel doc) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kgrey2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyText(
                text: doc.type.toUpperCase(),
                size: 13,
                weight: FontWeight.w600,
                color: kblack,
              ),
              const Spacer(),
              _statusChip(doc.isVerified ?? false),
            ],
          ),

          const SizedBox(height: 6),

          MyText(
            text: doc.number,
            size: 14,
            color: kblack,
          ),

          const SizedBox(height: 10),

          /// Export Row
          // GestureDetector(
          //   onTap: () {
          //     // TODO: open or download documentUrl
          //   },
          //   child: Row(
          //     children: [
          //       Image.asset(
          //         Assets.imagesExport2,
          //         height: 18,
          //       ),
          //       const SizedBox(width: 8),
          //       MyText(
          //         text: 'Export 1099',
          //         size: 14,
          //         color: kblue,
          //         weight: FontWeight.w500,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  /// 🟢 Status Chip
  Widget _statusChip(bool verified) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: verified ? kgreen.withOpacity(0.15) : kred.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: MyText(
        text: verified ? 'Verified' : 'Pending',
        size: 11,
        color: verified ? kgreen : kred,
        weight: FontWeight.w500,
      ),
    );
  }
}
