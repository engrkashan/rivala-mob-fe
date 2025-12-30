import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rivala/controllers/providers/user/seller_provider.dart';

import '../../../../../consts/app_colors.dart';
import '../../../../widgets/appbar.dart';
import '../../../../widgets/custome_comtainer.dart';
import '../../../../widgets/my_text_widget.dart';

class SellerRestrictionsScreen extends StatefulWidget {
  const SellerRestrictionsScreen({super.key});

  @override
  State<SellerRestrictionsScreen> createState() =>
      _SellerRestrictionsScreenState();
}

class _SellerRestrictionsScreenState extends State<SellerRestrictionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SellerProvider>().fetchRestrictions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SellerProvider>();

    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: 'Seller Restrictions',
        centerTitle: true,
        size: 18,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error.isNotEmpty
              ? Center(
                  child: MyText(
                    text: provider.error,
                    color: Colors.red,
                  ),
                )
              : provider.restrictions.isEmpty
                  ? _emptyState()
                  : _restrictionList(provider),
    );
  }

  Widget _restrictionList(SellerProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: provider.restrictions.length,
      itemBuilder: (context, index) {
        final item = provider.restrictions[index];
        return _restrictionCard(item);
      },
    );
  }

  Widget _restrictionCard(item) {
    return CustomeContainer(
      radius: 12,
      vpad: 14,
      hpad: 14,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: item.type.toUpperCase(),
                size: 14,
                weight: FontWeight.w600,
                color: kblack,
              ),
              _statusChip(item.isActive),
            ],
          ),

          const SizedBox(height: 8),

          /// Reason
          MyText(
            text: item.reason,
            size: 13,
            color: kblack.withOpacity(0.75),
          ),

          if (item.targetId != null) ...[
            const SizedBox(height: 6),
            MyText(
              text: 'Target ID: ${item.targetId}',
              size: 11,
              color: kblack.withOpacity(0.5),
            ),
          ],

          const SizedBox(height: 10),

          /// Dates
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text:
                    'Created: ${DateFormat('dd MMM yyyy').format(item.createdAt)}',
                size: 11,
                color: kblack.withOpacity(0.45),
              ),
              MyText(
                text:
                    'Updated: ${DateFormat('dd MMM yyyy').format(item.updatedAt)}',
                size: 11,
                color: kblack.withOpacity(0.45),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withOpacity(0.15)
            : Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: MyText(
        text: isActive ? 'ACTIVE' : 'INACTIVE',
        size: 11,
        weight: FontWeight.w600,
        color: isActive ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: MyText(
        text: 'No restrictions found',
        size: 14,
        color: kblack.withOpacity(0.5),
      ),
    );
  }
}
