import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/squads_provider.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/set_account.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/squad_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/platform_dialog.dart';

class SquadDetail extends StatefulWidget {
  final String squadId;
  const SquadDetail({super.key, required this.squadId});

  @override
  State<SquadDetail> createState() => _SquadDetailState();
}

class _SquadDetailState extends State<SquadDetail> {
  final nameController = TextEditingController();
  final summaryController = TextEditingController();
  int nameCount = 0;
  int summaryCount = 0;

  @override
  void dispose() {
    nameController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SquadProvider>(builder: (context, provider, _) {
      final squad = provider.singleSquad;
      if (squad != null) {
        if (nameController.text.isEmpty && squad.name != null) {
          nameController.text = squad.name!;
          nameCount = squad.name!.length;
        }
        if (summaryController.text.isEmpty && squad.description != null) {
          summaryController.text = squad.description!;
          summaryCount = squad.description!.length;
        }
      }

      if (squad == null) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
          backgroundColor: kwhite,
          appBar: simpleAppBar(
              context: context, title: squad.name, centerTitle: true),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 22),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        EditImgStack(),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          label: 'Squad Name',
                          controller: nameController,
                          filledColor: kblack.withOpacity(0.04),
                          bordercolor: ktransparent,
                          onChanged: (val) {
                            setState(() {
                              nameCount = val.length;
                            });
                          },
                          suffixIcon: MyText(
                            text: '$nameCount/100',
                            color: ktertiary,
                          ),
                        ),
                        MyTextField(
                          label: 'Summary',
                          controller: summaryController,
                          filledColor: kblack.withOpacity(0.04),
                          bordercolor: ktransparent,
                          maxLines: 5,
                          delay: 250,
                          onChanged: (val) {
                            setState(() {
                              summaryCount = val.length;
                            });
                          },
                          suffixIcon: SizedBox(
                            height: 100,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyText(
                                    text: '$summaryCount/100',
                                    color: ktertiary,
                                    paddingBottom: 5,
                                  ),
                                ]),
                          ),
                        ),
                        squad_members_container(
                          members: squad.members,
                          squadId: widget.squadId,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        squad_seller(
                          isProduct: false,
                          store: squad.sellers,
                          squadId: widget.squadId,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MyButton(
                          buttonText: 'Update Squad',
                          backgroundColor: kblack,
                          fontColor: kwhite,
                          mBottom: 15,
                          onTap: () async {
                            squad.name = nameController.text;
                            squad.description = summaryController.text;
                            await provider.updateSquad(widget.squadId, squad);
                            // AlertInfo.show(context: context, text: "Squad updated successfully");
                          },
                        ),
                        MyButton(
                          buttonText: 'Delete Squad',
                          backgroundColor: kred,
                          fontColor: kwhite,
                          mBottom: 50,
                          onTap: () async {
                            final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => PlatformConfirmationDialog(
                                      title: "Delete Squad",
                                      message:
                                          "Are you sure you want to delete this squad?",
                                      confirmText: "Delete",
                                      isDestructive: true,
                                    ));

                            if (confirmed == true) {
                              await provider.deleteSquad(widget.squadId);
                              if (provider.error == null) {
                                Navigator.pop(context);
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if (provider.isLoading)
                Positioned.fill(
                  child: Container(
                    color: kblack.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ));
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SquadProvider>().loadSingleSquad(widget.squadId);
    });
  }
}
