import 'package:flutter/material.dart';
import 'package:farm_management/widgets/simple_form_view_text_row.dart';

class FormViewTimeSlotTableRow extends StatelessWidget {
  final String timeSlot;
  final String firstFieldLabel;
  final String secondFieldLabel;
  final String thirdFieldLabel;
  final String? firstFieldLabelData;
  final String? secondFieldLabelData;
  final String? thirdFieldLabelData;
  const FormViewTimeSlotTableRow({
    super.key,
    required this.timeSlot,
    required this.firstFieldLabel,
    required this.secondFieldLabel,
    required this.thirdFieldLabel,
    required this.firstFieldLabelData,
    required this.secondFieldLabelData,
    required this.thirdFieldLabelData,
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
              FormViewTextRow(
                label: "Time Slot",
                data: timeSlot,
              ),
              FormViewTextRow(
                label: firstFieldLabel,
                data: firstFieldLabelData,
              ),
              FormViewTextRow(
                label: secondFieldLabel,
                data: secondFieldLabelData,
              ),
              FormViewTextRow(
                label: thirdFieldLabel,
                data: thirdFieldLabelData,
              ),
            ],
          ),
        )
      ],
    );
  }
}
