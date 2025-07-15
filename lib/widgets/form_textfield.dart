import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:farm_management/configs/color.dart';
import 'package:farm_management/configs/theme.dart';
import 'package:farm_management/configs/font.dart';

class FormTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final double hintTextSize;
  final double inputTextSize;
  final TextAlign textAlign;
  final bool isRequired;
  final bool isUpdate;
  final bool isIntOnly;
  final bool expandBox;
  final dynamic initialData;
  final Function(String) onChangedText;
  const FormTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.hintTextSize = CFGFont.smallFontSize,
    this.inputTextSize = CFGFont.smallTitleFontSize,
    this.textAlign = TextAlign.left,
    required this.isRequired,
    required this.isUpdate,
    this.isIntOnly = false,
    this.expandBox = false,
    this.initialData,
    required this.onChangedText,
  });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField>
    with AutomaticKeepAliveClientMixin {
  //to keep the State when scrolling out of the screen
  @override
  bool get wantKeepAlive => true;

  //validate form data
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  bool required = true;

  @override
  void initState() {
    super.initState();
    loadInitialValues();
    // setState(() {
    //   if (widget.initialData == null || widget.initialData == "") {
    //     required = true;
    //   } else {
    //     required = false;
    //   }
    // });
  }

  loadInitialValues() {
    if (widget.isUpdate) {
      if (widget.initialData == null || widget.initialData == "") {
        setState(() {
          textController.text = "";
          required = true;
        });
      } else {
        setState(() {
          textController.text = widget.initialData.toString();
          required = false;
        });
      }
    } else {
      setState(() {
        textController.text = "";
        required = true;
      });
    }
    debugPrint("${widget.initialData}");
    debugPrint(textController.text);
  }

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
              minLines: widget.expandBox ? 8 : 1, // Minimum number of lines
              maxLines: widget.expandBox ? 8 : 1, // Allow unlimited lines
              // FormField Allow Int Only Mode
              inputFormatters: widget.isIntOnly == true
                  ? <TextInputFormatter>[
                      // Allow only numbers
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : null,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: widget.isIntOnly == true
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : null,
              //
              enabled: true,
              controller: textController,
              //set initial value here for update form
              // initialValue: widget.initialData == null
              //     ? ""
              //     : widget.initialData.toString(),
              textAlign: widget.textAlign,
              style: TextStyle(
                fontSize: widget.inputTextSize,
                fontWeight: CFGFont.regularFontWeight,
                color: CFGFont.defaultFontColor,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
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
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: widget.hintTextSize,
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
                widget.onChangedText(value);
                debugPrint(value);
                setState(() {
                  if ((widget.initialData == null ||
                          widget.initialData == "") &&
                      widget.isRequired &&
                      (value.isEmpty || value == "")) {
                    required = true;
                  } else if (widget.isRequired &&
                      (value.isEmpty || value == "")) {
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
