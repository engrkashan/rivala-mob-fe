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

class SquadDetail extends StatefulWidget {
  final String squadId;
  const SquadDetail({super.key, required this.squadId});

  @override
  State<SquadDetail> createState() => _SquadDetailState();
}

class _SquadDetailState extends State<SquadDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SquadProvider>(builder: (context, provider, _) {
      final squad = provider.singleSquad;
      print("squad: ${squad?.name}");
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
                          hint: squad.name,
                          filledColor: kblack.withOpacity(0.04),
                          bordercolor: ktransparent,
                          suffixIcon: MyText(
                            text: '20/100',
                            color: ktertiary,
                          ),
                        ),
                        MyTextField(
                          label: 'Summary',
                          hint: squad.description,
                          filledColor: kblack.withOpacity(0.04),
                          bordercolor: ktransparent,
                          maxLines: 5,
                          delay: 250,
                          suffixIcon: SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MyText(
                                      text: '20/100',
                                      color: ktertiary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        squad_members_container(members: squad.members),
                        SizedBox(
                          height: 15,
                        ),
                        squad_seller(
                          isProduct: false,
                          store: squad.sellers,
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // squad_seller(
                        //   isProduct: true,
                        // ),
                        SizedBox(
                          height: 40,
                        ),
                        MyButton(
                          buttonText: 'Delete Squad',
                          backgroundColor: kred,
                          fontColor: kwhite,
                          mBottom: 50,
                          onTap: () async {
                            await provider.deleteSquad(widget.squadId);
                            Navigator.pop(context);
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
