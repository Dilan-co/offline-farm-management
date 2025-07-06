import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';

class FormToggleSwitchButton extends StatefulWidget {
  final String label;
  final String trueLabel;
  final String falseLabel;
  final int? initialSwitchValue;
  final Function(bool) onChangedSwitch;
  const FormToggleSwitchButton({
    super.key,
    required this.label,
    this.trueLabel = "YES",
    this.falseLabel = "NO",
    this.initialSwitchValue = 1,
    required this.onChangedSwitch,
  });

  @override
  State<FormToggleSwitchButton> createState() => _FormToggleSwitchButtonState();
}

class _FormToggleSwitchButtonState extends State<FormToggleSwitchButton>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  bool isSwitchedOn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      if (widget.initialSwitchValue == 1) {
        isSwitchedOn = true;
      } else {
        isSwitchedOn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Flexible(
            child: Text(widget.label,
                style: TextStyle(
                  // overflow: TextOverflow.clip,
                  letterSpacing: 0.5,
                  fontSize: CFGFont.defaultFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.defaultFontColor,
                )),
          ),

          Row(
              //
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Text(":",
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: CFGFont.defaultFontSize,
                        fontWeight: CFGFont.regularFontWeight,
                        color: CFGFont.defaultFontColor,
                      )),
                ),

                Text(widget.falseLabel,
                    style: TextStyle(
                      fontSize: CFGFont.smallTitleFontSize,
                      fontWeight: isSwitchedOn
                          ? CFGFont.regularFontWeight
                          : CFGFont.mediumFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Switch(
                    // hoverColor: CFGColor.darkGrey,
                    // splashRadius: 20,
                    activeColor: CFGTheme.bgColorScreen,
                    activeTrackColor: CFGTheme.button,
                    trackOutlineColor:
                        WidgetStatePropertyAll(CFGColor.midGrey),
                    inactiveThumbColor: CFGColor.darkGrey,
                    inactiveTrackColor: CFGTheme.bgColorScreen,
                    value: isSwitchedOn,
                    onChanged: (bool value) {
                      widget.onChangedSwitch(value);

                      setState(() {
                        isSwitchedOn = value;
                      });
                    },
                  ),
                ),

                Text(widget.trueLabel,
                    style: TextStyle(
                      fontSize: CFGFont.smallTitleFontSize,
                      fontWeight: isSwitchedOn
                          ? CFGFont.mediumFontWeight
                          : CFGFont.regularFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ]),
        ],
      ),
    );
  }
}
