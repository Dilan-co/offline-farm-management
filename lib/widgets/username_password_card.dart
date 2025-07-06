import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/widgets/sized_box.dart';

class UsernamePasswordCard extends StatefulWidget {
  final String title;
  final String label;
  final bool obscureTextIconIsVisible;
  final String? initialTextFieldData;
  final bool passwordTextReadOnly;
  final bool isPinNumber;
  final Function(String?) onChangedTextField;
  const UsernamePasswordCard({
    super.key,
    required this.title,
    required this.label,
    required this.obscureTextIconIsVisible,
    this.initialTextFieldData,
    this.passwordTextReadOnly = false,
    this.isPinNumber = false,
    required this.onChangedTextField,
  });

  @override
  State<UsernamePasswordCard> createState() => _UsernamePasswordCard();
}

class _UsernamePasswordCard extends State<UsernamePasswordCard>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  bool obscureText = false;
  bool passwordReadOnly = false;

  //to auto fill text field by default
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    obscureText = widget.obscureTextIconIsVisible;
    passwordReadOnly = widget.passwordTextReadOnly;

    super.initState();

    //Assigning value to textController
    setState(() {
      debugPrint(widget.initialTextFieldData);
      textController.text = widget.initialTextFieldData ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: CFGFont.defaultFontSize,
              fontWeight: CFGFont.regularFontWeight,
              color: CFGFont.defaultFontColor,
            ),
          ),

          //
          const SB(height: 8),

          // Username/Password TextBox
          SB(
            height: 54,
            child: TextField(
              readOnly: passwordReadOnly,
              controller: textController,
              keyboardType: widget.isPinNumber
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: widget.isPinNumber
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : <TextInputFormatter>[],
              style: TextStyle(
                fontWeight: CFGFont.regularFontWeight,
                fontSize: CFGFont.subTitleFontSize,
                color: CFGFont.defaultFontColor,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    // width: 2,
                    color: CFGColor.lightGrey,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(CFGTheme.buttonRadius)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    // width: 2,
                    color: CFGColor.darkGrey,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(CFGTheme.buttonRadius)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    // width: 2,
                    color: CFGTheme.logoColorsRed,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(CFGTheme.buttonRadius)),
                ),
                contentPadding: const EdgeInsets.only(left: 20.0),
                filled: false,

                // fillColor: CFGColor.lightGrey,
                hintText: widget.label,
                hintStyle: TextStyle(
                  fontSize: CFGFont.defaultFontSize,
                  fontWeight: CFGFont.lightFontWeight,
                  color: CFGFont.lightGreyFontColor,
                ),

                //Suffix icon
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                      // if(widget.isvisible == true){
                      //   _obscuretext: true;
                      // };
                      // if(widget.isvisible == false){
                      //   _obscuretext: false;
                      // };
                    });
                  },
                  child: SB(
                    height: 30,
                    width: 30,
                    child: Visibility(
                      visible: widget.obscureTextIconIsVisible,
                      child: Icon(
                          color: CFGColor.darkGrey,
                          obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                    ),
                  ),
                ),
              ),
              onChanged: (value) {
                debugPrint(value);
                widget.onChangedTextField(value);
              },
              obscureText: obscureText,
            ),
          ),
        ],
      ),
    );
  }
}
