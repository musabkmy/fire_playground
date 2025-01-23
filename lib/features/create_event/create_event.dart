import 'package:fire_playground/features/create_event/data/create_event_data.dart';
import 'package:fire_playground/features/create_event/layouts/event_date_and_location_layout.dart';
import 'package:fire_playground/features/create_event/layouts/event_details_layout.dart';
import 'package:fire_playground/features/create_event/layouts/event_speakers_layout.dart';
import 'package:fire_playground/features/create_event/providers/page_controller_provider.dart';
import 'package:fire_playground/features/create_event/shared/rectangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _detailsFormKey = GlobalKey<FormState>();
  final _dateAndLocationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pageControllerProvider = Provider.of<PageControllerProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Event',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Column(spacing: 32, children: [
          SizedBox(height: 24),
          BuildTop(),
          _buildSteps(),
          SizedBox(),
          Expanded(
            child: PageView.builder(
              controller: pageControllerProvider.pageController,
              itemCount: pageControllerProvider.numberOfPages,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => index == 0
                  ? EventDetailsLayout(formKey: _detailsFormKey)
                  : index == 1
                      ? EventDateAndLocationLayout(
                          formKey: _dateAndLocationFormKey)
                      : EventSpeakersLayout(),
            ),
          ),
          // SizedBox(height: 16),
          BuildActionButton(pageControllerProvider: pageControllerProvider),
          SizedBox(height: 24),
        ]));
  }

  Widget _buildSteps() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stepTopData.entries
            .map((step) => BuildStepTop(item: step))
            .toList(),
      ),
    );
  }
}

class BuildActionButton extends StatelessWidget {
  const BuildActionButton({
    super.key,
    required this.pageControllerProvider,
  });

  final PageControllerProvider pageControllerProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pageControllerProvider.atDetails
              ? SizedBox()
              : MaterialButton(
                  onPressed: pageControllerProvider.previousPage,
                  child: Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
          MaterialButton(
            color: Colors.blueAccent,
            height: 48,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            onPressed: pageControllerProvider.atLastPage
                ? () {}
                : () {
                    pageControllerProvider.nextPage();

                    // if ((pageControllerProvider.atDetails &&
                    //         _detailsFormKey.currentState!.validate()) ||
                    //     (pageControllerProvider.atDateAndLocation &&
                    //         _dateAndLocationFormKey.currentState!
                    //             .validate())) {
                    //   pageControllerProvider.nextPage();
                    // }
                  },
            child: Text(
              pageControllerProvider.atLastPage ? 'Submit' : 'Next',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildStepTop extends StatelessWidget {
  const BuildStepTop({
    super.key,
    required this.item,
  });
  final MapEntry<String, int> item;

  @override
  Widget build(BuildContext context) {
    final pageControllerProvider = Provider.of<PageControllerProvider>(context);
    return Expanded(
        key: Key(item.key),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPaint(
              size: Size(double.maxFinite, 4),
              painter: RRectanglePainter(
                  isClicked:
                      item.value == pageControllerProvider.currentPageIndex),
            ),
            Text(
              item.key,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.1,
                color: item.value == pageControllerProvider.currentPageIndex
                    ? Colors.blueAccent
                    : Colors.grey.shade400,
              ),
            ),
          ],
        ));
  }
}

class BuildTop extends StatelessWidget {
  const BuildTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Text.rich(TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.window,
            size: 24,
          ),
        ),
        TextSpan(
          text: ' What\'s your event about?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ])),
    );
  }
}
