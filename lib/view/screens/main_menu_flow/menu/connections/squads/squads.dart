import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/squads/create_new_squad.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/squads/squad_detail.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/image_stack.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../../controllers/providers/squads_provider.dart';
import '../../../../../../models/squad_model.dart';

class Squads extends StatefulWidget {
  const Squads({super.key});

  @override
  State<Squads> createState() => _SquadsState();
}

class _SquadsState extends State<Squads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar:
            simpleAppBar(context: context, title: 'Squads', centerTitle: true),
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
                      row_widget(
                        onTap: () {
                          Get.to(() => CreateNewSquad());
                        },
                        icon: Assets.imagesAdd3,
                        title: '  Start new squad',
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MyTextField(
                        hint: 'Search squads',
                        prefixIcon: Image.asset(
                          Assets.imagesSearch,
                          width: 12,
                        ),
                        contentvPad: 5,
                      ),
                      Consumer<SquadProvider>(builder: (context, squad, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: squad.filteredSquads.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: squad_container(
                                delay: (index * 1) + 200,
                                squad: squad.filteredSquads[index],
                              ),
                            );
                          },
                        );
                      }),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (context.read<SquadProvider>().isLoading)
              Positioned.fill(
                  child: Container(
                color: kblack.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ))
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SquadProvider>().getSquads();
    });
  }
}

class squad_container extends StatefulWidget {
  final String? date, amount, savedAmount;
  final int? delay;
  final SquadModel? squad;

  const squad_container({
    super.key,
    this.date,
    this.amount,
    this.savedAmount,
    this.delay,
    this.squad,
  });

  @override
  State<squad_container> createState() => _squad_containerState();
}

class _squad_containerState extends State<squad_container> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final squad = widget.squad;
    final imageUrl = squad?.members
            ?.map((e) => e.avatarUrl)
            .where((url) => url != null)
            .cast<String>()
            .toList() ??
        [];
    return Bounce_widget(
      ontap: () {
        Get.to(() => SquadDetail(
              squadId: squad!.id!,
            ));
      },
      widget: Animate(
        effects: [
          MoveEffect(delay: Duration(milliseconds: widget.delay ?? 100))
        ],
        child: CustomeContainer(
          color: kwhite,
          hpad: 10,
          hasShadow: true,
          radius: 15,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: squad?.name ?? 'Squad Name',
                      size: 13,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Bounce_widget(
                      ontap: () {
                        setState(() {
                          isActive = !isActive;
                        });
                      },
                      widget: Icon(isActive == true
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_right_rounded))
                ],
              ),
              row_widget(
                icon: Assets.imagesAlert2,
                iconSize: 12,
                title: squad?.status ?? 'InActive',
                textColor: kred,
                fontstyle: FontStyle.italic,
              ),
              SizedBox(
                height: 10,
              ),
              MyText(
                text: 'Description:',
                size: 11,
                weight: FontWeight.w500,
              ),
              MyText(
                text: squad?.description ??
                    'This is a brief description of the squad. It provides an overview of the squad\'s purpose and objectives.',
                size: 11,
                weight: FontWeight.w500,
                paddingBottom: 10,
                paddingTop: 0,
              ),
              StackedImagesWidget(
                urlImages: imageUrl,
              ),
              if (isActive) ...{
                SizedBox(
                  height: 10,
                ),
                MyText(
                  text: '> Edit squad',
                  size: 12,
                  color: kblue,
                  weight: FontWeight.w500,
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
