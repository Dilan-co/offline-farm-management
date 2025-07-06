import 'package:flutter/material.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';

class TextFieldTest extends StatefulWidget {
  final String label;
  final String formText;
  final dynamic initialData;
  final bool isRequired;
  final Function(String) onChanged;
  const TextFieldTest({
    super.key,
    required this.label,
    required this.formText,
    required this.initialData,
    required this.isRequired,
    required this.onChanged,
  });

  @override
  State<TextFieldTest> createState() => _TextFieldTestState();
}

class _TextFieldTestState extends State<TextFieldTest>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  //validate form data
  final _formKey = GlobalKey<FormState>();

  bool required = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        //
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label,
                  style: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: CFGFont.regularFontWeight,
                    color: CFGFont.defaultFontColor,
                  )),
              Visibility(
                visible: widget.isRequired,
                child: Text(required ? "Required" : '',
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: CFGFont.smallFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.redFontColor,
                    )),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Form(
            key: _formKey,
            child: TextFormField(
              enabled: true,
              //set initial value here for "Update Form"
              //Exception handling done
              //"initialData" type set to "dynamic" and converted to "String"
              initialValue:
                  widget.initialData == null || widget.initialData == ''
                      ? ''
                      : widget.initialData.toString(),
              style: TextStyle(
                fontSize: CFGFont.smallTitleFontSize,
                fontWeight: CFGFont.regularFontWeight,
                color: CFGFont.defaultFontColor,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20, right: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
                  borderSide: BorderSide(color: CFGTheme.button, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CFGTheme.cardRadius),
                  borderSide: BorderSide(
                    color: CFGColor.midGrey,
                    width: 1.0,
                  ),
                ),
                fillColor: CFGTheme.bgColorScreen,
                filled: true,
                hintText: widget.formText,
                hintStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: CFGFont.smallFontSize,
                  fontWeight: CFGFont.regularFontWeight,
                  color: CFGFont.lightGreyFontColor,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(CFGTheme.cardRadius)),
                ),
              ),
              onChanged: (value) {
                widget.onChanged(value);
                setState(() {
                  if (widget.isRequired && value.isEmpty) {
                    required = true;
                  } else {
                    required = false;
                  }
                });
              },
              onSaved: (newValue) {},
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter text';
              //   }
              //   return null;
              // },
            ),
          ),
        ),

        // TextButton(
        //     onPressed: () {
        //       if (_formKey.currentState!.validate()) {}
        //     },
        //     child: Text('Validate')),
      ],
    );
  }
}
