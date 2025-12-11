import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';

class SwitchButton extends StatelessWidget {
  final bool? isActive;
  final ValueChanged<bool>? onChanged;
  final double scale;

  const SwitchButton({
    super.key,
    this.isActive,
    this.onChanged,
    this.scale = 0.9,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Switch(
        value: isActive ?? true,
        onChanged: onChanged,
        inactiveTrackColor: kgrey4,
        trackOutlineColor: WidgetStateColor.transparent,
        inactiveThumbColor: kwhite,
        activeColor: kwhite,
        activeTrackColor: kgreen,
        thumbIcon: MaterialStateProperty.all(const Icon(null)),
      ),
    );
  }
}

//

class SwitchButton2 extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const SwitchButton2({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isActive),
      child: Transform.scale(
        scale: 0.8,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Gradient background for the track
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: ktertiary.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isActive
                        ? [
                            Color.fromARGB(255, 96, 102, 102),
                            Color.fromARGB(255, 233, 232, 232)
                          ]
                        : [
                            Color.fromARGB(255, 219, 225, 225),
                            Color.fromARGB(255, 255, 255, 255)
                          ],
                  ).createShader(bounds);
                },
                child: Container(
                  height: 28, // Approximate track height
                  width: 49, // Approximate track width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Actual Switch to display thumb without border color
            Theme(
              data: Theme.of(context).copyWith(
                switchTheme: SwitchThemeData(
                  trackOutlineColor:
                      MaterialStateProperty.all(Colors.transparent),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
              ),
              child: Switch(
                value: isActive,
                onChanged: onChanged,
                activeColor: ksecondary, // Thumb color when active
                inactiveThumbColor: kwhite,
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
