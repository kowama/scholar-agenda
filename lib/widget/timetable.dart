//import 'package:flutter/material.dart';
//import 'package:scholar_agenda/model/period.dart';
//import 'package:table_calendar/table_calendar.dart';
//
//class TimetableWidget extends StatefulWidget {
//  final List<Period> periods;
//
//  const TimetableWidget({Key key, @required this.periods}) : super(key: key);
//
//  @override
//  _TimetableWidgetState createState() => _TimetableWidgetState();
//}
//
//class _TimetableWidgetState extends State<TimetableWidget> {
//  static const cellHeight = 50.0;
//  static const numDayOfWeek = 7;
//  static const rowsCount = 24.5;
//
//  double _cellWidth;
//  CalendarController _calendarController;
//
//  _TimetableWidgetState();
//
//  @override
//  void initState() {
//    super.initState();
//    _calendarController = CalendarController();
//  }
//
//  @override
//  void dispose() {
//    _calendarController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _cellWidth = MediaQuery.of(context).size.width / (numDayOfWeek + 1);
//    return CustomScrollView(
//      slivers: <Widget>[
//        SliverPersistentHeader(
//          delegate: TimetableHeaderDelegate(
//              TableCalendar(
//                calendarController: _calendarController,
//                headerVisible: false,
//                startingDayOfWeek: StartingDayOfWeek.monday,
//                initialCalendarFormat: CalendarFormat.week,
//                availableCalendarFormats: {CalendarFormat.week: 'Week'},
//              ),
//              _cellWidth),
//          pinned: true,
//          floating: true,
//        ),
//        SliverToBoxAdapter(
//          child: _buildGrid(),
//        ),
//      ],
//    );
//  }
//
//  Widget _buildGrid() {
//    return Stack(children: <Widget>[
//      CustomPaint(
//        size: Size(MediaQuery.of(context).size.width, cellHeight * rowsCount),
//        painter: TimetableBackground(
//            cellWidth: _cellWidth,
//            cellHeight: cellHeight,
//            rowsCount: rowsCount),
//        foregroundPainter: TimetableForeground(
//            periods: widget.periods,
//            cellWidth: _cellWidth,
//            cellHeight: cellHeight,
//            rowsCount: rowsCount),
//      )
//    ]);
//  }
//}
//
//class TimetableBackground extends CustomPainter {
//  final cellHeight;
//  final cellWidth;
//  final rowsCount;
//  final columnsCount = 9;
//  final numberOfHours = 24;
//  Paint _paint = new Paint();
//
//  TimetableBackground(
//      {@required this.cellWidth,
//      @required this.cellHeight,
//      @required this.rowsCount});
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    _paint.style = PaintingStyle.stroke;
//    _paint.color = Colors.grey[400];
//    for (var i = 0; i < rowsCount * 2; i++) {
//      for (var j = 0; j <= columnsCount; j++) {
//        canvas.drawRect(
//            Rect.fromLTWH(
//                cellWidth * j, (cellHeight / 2) * i, cellWidth, cellHeight / 2),
//            _paint);
//      }
//    }
//    var yOffset = 0.5;
//    for (var i = yOffset; i < numberOfHours + yOffset; i++) {
//      final textStyle = TextStyle(
//        color: Colors.black87,
//        fontSize: 14,
//      );
//      final textSpan = TextSpan(
//        text: '${(i - yOffset).floor()}',
//        style: textStyle,
//      );
//      final textPainter = TextPainter(
//        text: textSpan,
//        textDirection: TextDirection.ltr,
//      );
//      textPainter.layout(
//        minWidth: 0,
//        maxWidth: size.width,
//      );
//      final offset = Offset(cellWidth - textPainter.width - 4, cellHeight * i);
//      textPainter.paint(canvas, offset);
//    }
//  }
//
//  @override
//  bool shouldRepaint(CustomPainter oldDelegate) {
//    return false;
//  }
//}
//
//class TimetableForeground extends CustomPainter {
//  final List<Period> periods;
//  final cellHeight;
//  final cellWidth;
//  final rowsCount;
//  final columnsCount = 9;
//  final numberOfHours = 24;
//  final xPad = 4;
//  final _paint = new Paint();
//
//  TimetableForeground(
//      {@required this.periods,
//      @required this.cellHeight,
//      @required this.cellWidth,
//      @required this.rowsCount});
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    for (var p in periods) {
//      _paint.color = p.subject.color;
//      var left = (p.dayOfWeek) * cellWidth;
//      var top = (0.5 + p.start.minute / 60.0) * cellHeight;
//      var height =
//          cellHeight * (p.end.difference(p.start).inMinutes.abs() / 60.0);
//
//      canvas.drawRect(
//          Rect.fromLTWH(left - xPad / 2, top, cellWidth - xPad / 2, height),
//          _paint);
//
//      //draw title
//      final textStyle = TextStyle(
//        color: Colors.white,
//        fontSize: 14,
//      );
//      final textSpan = TextSpan(
//        text: 'subject',
//        style: textStyle,
//      );
//      final textPainter = TextPainter(
//        text: textSpan,
//        textDirection: TextDirection.ltr,
//      );
//      textPainter.layout(
//        minWidth: 0,
//        maxWidth: size.width,
//      );
//      final offset = Offset(left, top + height / 2);
//      textPainter.paint(canvas, offset);
//    }
//  }
//
//  @override
//  bool shouldRepaint(CustomPainter oldDelegate) {
//    return false;
//  }
//}
//
//class TimetableHeaderDelegate extends SliverPersistentHeaderDelegate {
//  final Widget _content;
//  final leftOffset;
//
//  TimetableHeaderDelegate(this._content, this.leftOffset);
//
//  @override
//  Widget build(
//      BuildContext context, double shrinkOffset, bool overlapsContent) {
//    return Padding(
//      padding: const EdgeInsets.only(left: 40),
//      child: Container(child: _content),
//    );
//  }
//
//  @override
//  double get maxExtent => 90;
//
//  @override
//  double get minExtent => 87;
//
//  @override
//  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//    return false;
//  }
//}
