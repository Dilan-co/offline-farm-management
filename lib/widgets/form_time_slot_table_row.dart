import 'package:flutter/material.dart';
import 'package:farm_management/configs/font.dart';
import 'package:farm_management/widgets/form_textfield.dart';

class FormTimeSlotTableRow extends StatelessWidget {
  final String timeSlot;
  final String firstFormFieldLabel;
  final String secondFormFieldLabel;
  final String thirdFormFieldLabel;
  final dynamic firstFormFieldInitialData;
  final dynamic secondFormFieldInitialData;
  final dynamic thirdFormFieldInitialData;
  final bool isUpdate;
  final Function(String) onChangedTextFieldOne;
  final Function(String) onChangedTextFieldTwo;
  final Function(String) onChangedTextFieldThree;
  const FormTimeSlotTableRow({
    super.key,
    required this.timeSlot,
    required this.isUpdate,
    required this.firstFormFieldLabel,
    required this.secondFormFieldLabel,
    required this.thirdFormFieldLabel,
    this.firstFormFieldInitialData,
    this.secondFormFieldInitialData,
    this.thirdFormFieldInitialData,
    required this.onChangedTextFieldOne,
    required this.onChangedTextFieldTwo,
    required this.onChangedTextFieldThree,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text("Time Slot",
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: CFGFont.defaultFontSize,
                      fontWeight: CFGFont.regularFontWeight,
                      color: CFGFont.defaultFontColor,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: Text(
                  timeSlot,
                  style: TextStyle(
                    fontSize: CFGFont.defaultFontSize,
                    fontWeight: CFGFont.lightFontWeight,
                    color: CFGFont.defaultFontColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              FormTextField(
                isUpdate: isUpdate,
                initialData: firstFormFieldInitialData,
                label: firstFormFieldLabel,
                hintText: "Type here",
                isRequired: false,
                onChangedText: onChangedTextFieldOne,
              ),
              FormTextField(
                isUpdate: isUpdate,
                initialData: secondFormFieldInitialData,
                label: secondFormFieldLabel,
                hintText: "Type here",
                isRequired: false,
                onChangedText: onChangedTextFieldTwo,
              ),
              FormTextField(
                isUpdate: isUpdate,
                initialData: thirdFormFieldInitialData,
                label: thirdFormFieldLabel,
                hintText: "Type here",
                isRequired: false,
                onChangedText: onChangedTextFieldThree,
              ),
            ],
          ),
        )
      ],
    );
  }
}
