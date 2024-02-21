import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pediapp/Classes/assignment.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Utils/format_time_of_day.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key, required this.assignment});

  final Assignment assignment;

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  List<List<bool>> newTableVariables = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.assignment.tableVariables.length; ++i) {
      newTableVariables.add([]);
      for (int j = 0; j < widget.assignment.tableVariables[i].length; ++j) {
        if (widget.assignment.tableVariables[i][j] == 'true') {
          newTableVariables[i].add(true);
        } else {
          newTableVariables[i].add(false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    widget.assignment.subjectName,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 30,
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: 'Consultant: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.primary)),
                    TextSpan(
                        text: widget.assignment.consultantName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black)),
                  ])),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: 'Day: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.primary)),
                    TextSpan(
                        text: formatDateTime(widget.assignment.date),
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black)),
                  ])),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: 'Time: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.primary)),
                    TextSpan(
                        text: formatTimeOfDay(widget.assignment.time),
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black)),
                  ])),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: 'Objective: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.primary)),
                    TextSpan(
                        text: widget.assignment.objective,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black)),
                  ])),
                  const Text('Achievement(s):',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.primary)),
                  for (int i = 1; i < widget.assignment.activities.length; ++i)
                    Text('$i. ${widget.assignment.activities[i]}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black)),
                ],
              ),
            ),
          ),
        ),
        body: TwoDimensionalGridView(
          diagonalDragBehavior: DiagonalDragBehavior.free,
          delegate: TwoDimensionalChildBuilderDelegate(
              maxXIndex: widget.assignment.tableVariables[0].length - 1,
              maxYIndex: widget.assignment.tableVariables.length - 1,
              builder: (BuildContext context, ChildVicinity vicinity) {
                return Container(
                  color: vicinity.xIndex.isEven && vicinity.yIndex.isEven
                      ? Colors.amber[50]
                      : (vicinity.xIndex.isOdd && vicinity.yIndex.isOdd
                          ? Colors.purple[50]
                          : null),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: (vicinity.xIndex == 0 && vicinity.yIndex == 0)
                        ? const Text(
                            'Achievement/Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.primary),
                          )
                        : (vicinity.xIndex == 0 || vicinity.yIndex == 0)
                            ? Text(
                                vicinity.yIndex == 0
                                    ? widget.assignment.tableVariables[0]
                                        [vicinity.xIndex]
                                    : widget.assignment
                                        .tableVariables[vicinity.yIndex][0],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.primary),
                              )
                            : Checkbox(
                                value: newTableVariables[vicinity.yIndex]
                                    [vicinity.xIndex],
                                onChanged: (bool? value) {
                                  setState(() {
                                    newTableVariables[vicinity.yIndex]
                                        [vicinity.xIndex] = value!;
                                  });
                                },
                              ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class TwoDimensionalGridView extends TwoDimensionalScrollView {
  const TwoDimensionalGridView({
    super.key,
    super.primary,
    super.mainAxis = Axis.vertical,
    super.verticalDetails = const ScrollableDetails.vertical(),
    super.horizontalDetails = const ScrollableDetails.horizontal(),
    required TwoDimensionalChildBuilderDelegate delegate,
    super.cacheExtent,
    super.diagonalDragBehavior = DiagonalDragBehavior.none,
    super.dragStartBehavior = DragStartBehavior.start,
    super.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
  ) {
    return TwoDimensionalGridViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalDetails.direction,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalDetails.direction,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
    );
  }
}

class TwoDimensionalGridViewport extends TwoDimensionalViewport {
  const TwoDimensionalGridViewport({
    super.key,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required TwoDimensionalChildBuilderDelegate super.delegate,
    required super.mainAxis,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
  });

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return RenderTwoDimensionalGridViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      childManager: context as TwoDimensionalChildManager,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderTwoDimensionalGridViewport renderObject,
  ) {
    renderObject
      ..horizontalOffset = horizontalOffset
      ..horizontalAxisDirection = horizontalAxisDirection
      ..verticalOffset = verticalOffset
      ..verticalAxisDirection = verticalAxisDirection
      ..mainAxis = mainAxis
      ..delegate = delegate
      ..cacheExtent = cacheExtent
      ..clipBehavior = clipBehavior;
  }
}

class RenderTwoDimensionalGridViewport extends RenderTwoDimensionalViewport {
  RenderTwoDimensionalGridViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required TwoDimensionalChildBuilderDelegate delegate,
    required super.mainAxis,
    required super.childManager,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  @override
  void layoutChildSequence() {
    final double horizontalPixels = horizontalOffset.pixels;
    final double verticalPixels = verticalOffset.pixels;
    final double viewportWidth = viewportDimension.width + cacheExtent;
    final double viewportHeight = viewportDimension.height + cacheExtent;
    final TwoDimensionalChildBuilderDelegate builderDelegate =
        delegate as TwoDimensionalChildBuilderDelegate;

    final int maxRowIndex = builderDelegate.maxYIndex!;
    final int maxColumnIndex = builderDelegate.maxXIndex!;

    final int leadingColumn = math.max((horizontalPixels / 100).floor(), 0);
    final int leadingRow = math.max((verticalPixels / 100).floor(), 0);
    final int trailingColumn = math.min(
      ((horizontalPixels + viewportWidth) / 100).ceil(),
      maxColumnIndex,
    );
    final int trailingRow = math.min(
      ((verticalPixels + viewportHeight) / 100).ceil(),
      maxRowIndex,
    );

    double xLayoutOffset = (leadingColumn * 100) - horizontalOffset.pixels;
    for (int column = leadingColumn; column <= trailingColumn; column++) {
      double yLayoutOffset = (leadingRow * 100) - verticalOffset.pixels;
      for (int row = leadingRow; row <= trailingRow; row++) {
        final ChildVicinity vicinity =
            ChildVicinity(xIndex: column, yIndex: row);
        final RenderBox child = buildOrObtainChildFor(vicinity)!;
        child.layout(constraints.loosen());

        // Subclasses only need to set the normalized layout offset. The super
        // class adjusts for reversed axes.
        parentDataOf(child).layoutOffset = Offset(xLayoutOffset, yLayoutOffset);
        yLayoutOffset += 100;
      }
      xLayoutOffset += 100;
    }

    // Set the min and max scroll extents for each axis.
    final double verticalExtent = 125 * (maxRowIndex + 1);
    verticalOffset.applyContentDimensions(
      0.0,
      clampDouble(
          verticalExtent - viewportDimension.height, 0.0, double.infinity),
    );
    final double horizontalExtent = 125 * (maxColumnIndex + 1);
    horizontalOffset.applyContentDimensions(
      0.0,
      clampDouble(
          horizontalExtent - viewportDimension.width, 0.0, double.infinity),
    );
    // Super class handles garbage collection too!
  }
}
