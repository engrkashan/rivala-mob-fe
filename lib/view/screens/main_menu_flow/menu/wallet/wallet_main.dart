import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/wallet_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/bank_info/bank_management.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/payment/payment_management.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/tax_documentation/tax_documents.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class WalletMain extends StatefulWidget {
  const WalletMain({super.key});

  @override
  State<WalletMain> createState() => _WalletMainState();
}

class _WalletMainState extends State<WalletMain> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> mainMenuItems = [
      {
        'text': 'Tax Documents',
        'icon': Assets.imagesTax,
        'delay': 100,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(page: TaxDocumentsListScreen()),
            )
      },
      {
        'text': 'Bank Info',
        'icon': Assets.imagesBankinfo,
        'delay': 250,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(page: BankManagement()),
            )
      },
      {
        'text': 'Payments',
        'icon': Assets.imagesPaymnet,
        'delay': 400,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(page: PaymentManagement()),
            )
      },
    ];

    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context, actions: [
          circular_icon_container(),
          SizedBox(
            width: 12,
          )
        ]),
        body: Consumer<WalletProvider>(builder: (context, walletProvider, _) {
          if (walletProvider.isLoading && walletProvider.wallet == null) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    MyText(
                      text: 'Sell On Rivala',
                      size: 28,
                      weight: FontWeight.bold,
                      color: kblack,
                      paddingLeft: 22,
                      paddingBottom: 20,
                    ),

                    // Wallet Balance Section
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kblack,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              text: "Total Balance", color: kwhite, size: 14),
                          SizedBox(height: 10),
                          MyText(
                            text:
                                "\$${walletProvider.wallet?.balance.toStringAsFixed(2) ?? '0.00'}",
                            color: kwhite,
                            size: 32,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                  text: "Last payout: --",
                                  color: kgrey2,
                                  size: 12),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                    color: kwhite,
                                    borderRadius: BorderRadius.circular(20)),
                                child: MyText(
                                    text: "Withdraw",
                                    color: kblack,
                                    size: 12,
                                    weight: FontWeight.w600,
                                    onTap: () {
                                      // Trigger payout (mock or real)
                                      walletProvider.requestPayout(
                                          walletProvider.wallet?.balance ?? 0);
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    // Transactions Snippet
                    MyText(
                      text: 'Recent Transactions',
                      size: 18,
                      weight: FontWeight.w600,
                      color: kblack,
                      paddingLeft: 22,
                      paddingBottom: 10,
                      paddingTop: 10,
                    ),
                    if (walletProvider.transactions.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 10),
                        child: Text("No recent transactions"),
                      )
                    else
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: walletProvider.transactions.take(3).length,
                          itemBuilder: (ctx, i) {
                            final t = walletProvider.transactions[i];
                            return ListTile(
                              title: Text(t.description),
                              subtitle:
                                  Text(t.date.toString().substring(0, 10)),
                              trailing: Text(
                                "\$${t.amount.toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: t.type == 'credit'
                                        ? Colors.green
                                        : Colors.black),
                              ),
                            );
                          }),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Divider(
                        thickness: 1,
                        color: kgrey2,
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      physics: const BouncingScrollPhysics(),
                      itemCount: mainMenuItems.length,
                      itemBuilder: (context, index) {
                        final item = mainMenuItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ShoppingRow(
                            textt: item['text'],
                            icon: item['icon'],
                            delay: item['delay'],
                            isSelected: selectedIndex == index,
                            ontap: () {
                              setState(() {
                                selectedIndex = index;
                              });

                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                item['onTap']();
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
