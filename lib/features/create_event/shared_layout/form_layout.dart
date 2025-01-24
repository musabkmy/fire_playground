import 'package:fire_playground/features/create_event/providers/page_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormLayout extends StatelessWidget {
  const FormLayout({
    super.key,
    required this.formKey,
    required this.unfocus,
    required this.formFields,
    required this.onPressedAction,
    required this.actionButtonLabel,
    required this.hasPrevious,
  });

  final GlobalKey<FormState> formKey;
  final Function()? unfocus;
  final List<Widget> formFields;
  final Function()? onPressedAction;
  final String actionButtonLabel;
  final bool hasPrevious;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Stack(
        children: [
          GestureDetector(
            onTap: unfocus,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: formFields,
            ),
          ),
          Container(
            alignment: AlignmentDirectional.bottomEnd,
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                hasPrevious
                    ? MaterialButton(
                        onPressed: Provider.of<PageControllerProvider>(context,
                                listen: false)
                            .previousPage,
                        child: Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      )
                    : SizedBox(),
                MaterialButton(
                  color: Colors.blueAccent,
                  disabledColor: Colors.grey,
                  height: 48,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  onPressed: onPressedAction,
                  child: Text(
                    actionButtonLabel,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
