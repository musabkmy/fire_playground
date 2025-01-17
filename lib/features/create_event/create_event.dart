import 'package:fire_playground/features/create_event/data/create_event_data.dart';
import 'package:fire_playground/features/create_event/layouts/build_details_layout.dart';
import 'package:fire_playground/features/create_event/providers/page_controller_provider.dart';
import 'package:fire_playground/features/create_event/shared/rectangle_painter.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageControllerProvider pageControllerProvider =
        PageControllerProvider();
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Event'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(spacing: 32, children: [
            SizedBox(height: 24),
            BuildTop(),
            _buildSteps(),
            SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                controller: pageControllerProvider.pageController,
                itemCount: pageControllerProvider.numberOfPages,
                itemBuilder: (context, index) => index == 0
                    ? BuildDetailsLayout()
                    : index == 1
                        ? Placeholder()
                        : Placeholder(),
              ),
            )
          ]),
        ));
  }

  Widget _buildSteps() {
    return Row(
      spacing: 16,
      children:
          stepTopData.entries.map((step) => BuildStepTop(item: step)).toList(),
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
    final PageControllerProvider pageControllerProvider =
        PageControllerProvider();
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPaint(
          size: Size(double.maxFinite, 4),
          painter: RRectanglePainter(
              isClicked: item.value == pageControllerProvider.page),
        ),
        Text(
          item.key,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 2,
            color: item.value == pageControllerProvider.page
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
      child: Text.rich(TextSpan(children: [
        WidgetSpan(
          child: Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.0),
            ),
            child: Icon(
              Icons.document_scanner_rounded,
              size: 24,
            ),
          ),
        ),
        TextSpan(
          text: ' What\'s your event about?',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ])),
    );
  }
}
