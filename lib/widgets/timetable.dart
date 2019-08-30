import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/blocs/timetable_page_tab/timetable_page_tab.dart';
import 'package:scholar_agenda/blocs/timetable_page_tab/timetable_page_tab_state.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';
import 'package:table_calendar/table_calendar.dart';

class TimetableWidget extends StatefulWidget {
  final Timetable timetable;
  final TimetablePageTab timetablePageTab;

  const TimetableWidget(
      {Key key,
      @required this.timetable,
      this.timetablePageTab = TimetablePageTab.weekView})
      : super(key: key);

  @override
  _TimetableWidgetState createState() => _TimetableWidgetState();
}

class _TimetableWidgetState extends State<TimetableWidget> {
  static const cellHeight = 50.0;
  static const numDayOfWeek = 7;
  static const rowsCount = 25.5;

  CalendarController _calendarController;
  TimetablePeriodsBloc _timetablePeriodsBloc;
  Localization localization;

  _TimetableWidgetState();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _timetablePeriodsBloc = BlocProvider.of<TimetablePeriodsBloc>(context);
    _timetablePeriodsBloc.dispatch(LoadTimetablePeriods(widget.timetable));
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    localization = Localization.of(context);
    if (widget.timetablePageTab == TimetablePageTab.weekView)
      return _buildWeekView(context);
    else {
      return _buildDayListView(context);
    }
  }

  Widget _buildWeekView(BuildContext context) {
    final cellWidth = MediaQuery.of(context).size.width / (numDayOfWeek + 1);
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: TimetableHeaderDelegate(
              TableCalendar(
                calendarController: _calendarController,
                headerVisible: false,
                startingDayOfWeek: StartingDayOfWeek.monday,
                initialCalendarFormat: CalendarFormat.week,
                availableCalendarFormats: {CalendarFormat.week: 'Week'},
              ),
              cellWidth),
          pinned: true,
          floating: true,
        ),
        SliverToBoxAdapter(
          child: _buildGrid(cellWidth: cellWidth),
        ),
      ],
    );
  }

  Widget _buildGrid({double cellWidth}) {
    return BlocBuilder<TimetablePeriodsBloc, TimetablePeriodsState>(
        builder: (context, state) {
      if (state is TimetablePeriodsLoaded) {
        return CustomPaint(
          size: Size(MediaQuery.of(context).size.width, cellHeight * rowsCount),
          painter: TimetableBackground(
              cellWidth: cellWidth,
              cellHeight: cellHeight,
              rowsCount: rowsCount),
          foregroundPainter: TimetableForeground(
              periods: (state is TimetablePeriodsLoaded) ? state.periods : [],
              cellWidth: cellWidth,
              cellHeight: cellHeight,
              rowsCount: rowsCount),
        );
      } else {
        if (state is TimetablePeriodsLoading) {
          return Stack(
            children: <Widget>[
              CustomPaint(
                size: Size(
                    MediaQuery.of(context).size.width, cellHeight * rowsCount),
                painter: TimetableBackground(
                    cellWidth: cellWidth,
                    cellHeight: cellHeight,
                    rowsCount: rowsCount),
              ),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        }
        return CustomPaint(
          size: Size(MediaQuery.of(context).size.width, cellHeight * rowsCount),
          painter: TimetableBackground(
              cellWidth: cellWidth,
              cellHeight: cellWidth,
              rowsCount: rowsCount),
          foregroundPainter: TimetableForeground(
              periods: [],
              cellWidth: cellWidth,
              cellHeight: cellHeight,
              rowsCount: rowsCount),
        );
      }
    });
  }

  Widget _buildDayListView(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildList() {
    return BlocBuilder<TimetablePeriodsBloc, TimetablePeriodsState>(
      builder: (context, state) {
        if (state is TimetablePeriodsLoaded) {
          return DaysTaskView(
            periods: state.periods,
          );
        } else if (state is TimetablePeriodsLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Text(localization.errorUnableToLoadData);
        }
      },
    );
  }
}

class TimetableBackground extends CustomPainter {
  final cellHeight;
  final cellWidth;
  final rowsCount;
  final columnsCount = 9;
  final numberOfHours = 24;
  Paint _paint = new Paint();

  TimetableBackground(
      {@required this.cellWidth,
      @required this.cellHeight,
      @required this.rowsCount});

  @override
  void paint(Canvas canvas, Size size) {
    _paint.style = PaintingStyle.stroke;
    _paint.color = Colors.grey[400];
    for (var i = 0; i < rowsCount * 2; i++) {
      for (var j = 0; j <= columnsCount; j++) {
        canvas.drawRect(
            Rect.fromLTWH(
                cellWidth * j, (cellHeight / 2) * i, cellWidth, cellHeight / 2),
            _paint);
      }
    }
    var yOffset = 0.5;
    for (var i = yOffset; i < numberOfHours + yOffset; i++) {
      final textStyle = TextStyle(
        color: Colors.black87,
        fontSize: 14,
      );
      final textSpan = TextSpan(
        text: '${(i - yOffset).floor()}',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      final offset = Offset(cellWidth - textPainter.width - 4, cellHeight * i);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final old = (oldDelegate as TimetableBackground);
    return cellWidth != old.cellWidth &&
        cellHeight != old.cellWidth &&
        rowsCount != old.rowsCount;
  }
}

class TimetableForeground extends CustomPainter {
  static const columnsCount = 9;
  static const numberOfHours = 24;
  static const xPad = 4;
  final List<Period> periods;
  final cellHeight;
  final cellWidth;
  final rowsCount;
  final maxWidth;

  final _paint = new Paint();

  TimetableForeground(
      {@required this.periods,
      @required this.cellHeight,
      @required this.cellWidth,
      @required this.rowsCount})
      : maxWidth = cellWidth - xPad;

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in periods) {
      _paint.color = p.subject.color;
      final left = (p.dayOfWeek) * cellWidth;
      final top = (0.5 + (p.start.hour + p.start.minute / 60)) * cellHeight;
      final height =
          cellHeight * (p.end.difference(p.start).inMinutes.abs() / 60.0);

      canvas.drawRect(
          Rect.fromLTWH(left + xPad / 2, top, cellWidth - xPad, height),
          _paint);

      //draw title
      final textStyle = TextStyle(
        color: Colors.white,
        fontSize: 14,
      );
      final textSpan = TextSpan(
        text: p.subject.title,
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: maxWidth,
      );
      final offset = Offset(
          left + xPad / 2 + (maxWidth - textPainter.width) / 2,
          top + height / 2 - textPainter.height / 2);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return periods != (oldDelegate as TimetableForeground).periods;
  }
}

class TimetableHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget _content;
  final leftOffset;

  TimetableHeaderDelegate(this._content, this.leftOffset);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Container(child: _content),
    );
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 87;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return _content != (oldDelegate as TimetableHeaderDelegate)._content;
  }
}

class DaysTaskView extends StatelessWidget {
  static List<DayWithPeriod> groupPeriodsByDay(final List<Period> periods) {
    return List.generate(
      7,
      (i) => DayWithPeriod(
        day: (i + 1),
        periods: periods.where((p) => p.dayOfWeek == (i + 1)).toList()
          ..sort((p1, p2) => p1.start.hour - p2.start.hour)
          ..sort((p1, p2) => p1.start.minute - p2.start.minute),
      ),
    );
  }

  static final timeFormat = intl.DateFormat.Hm();

  final List<Period> periods;
  final List<DayWithPeriod> days;

  DaysTaskView({Key key, @required this.periods})
      : days = groupPeriodsByDay(periods),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    final ThemeData themeData = Theme.of(context);

    final daysView = days.map((day) {
      final periods = day.periods;
      final periodsView = periods
          .map(
            (period) => Card(
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${timeFormat.format(period.start)}'
                      ' - ${timeFormat.format(period.end)}',
                      style: themeData.textTheme.caption,
                    ),
                    Text(
                      period.subject.title,
                      style: themeData.textTheme.title
                          .copyWith(color: period.subject.color),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: <Widget>[
                    Icon(
                      Icons.room,
                      size: 12,
                    ),
                    Text(period.location)
                  ],
                ),
                trailing: Container(
                  width: 10,
                  color: period.subject.color,
                ),
                isThreeLine: true,
                onTap: () {
                  _onPeriodTap(context, period);
                },
              ),
            ),
          )
          .toList();
      return Column(
          children: <Widget>[
        ListTile(
          title: Text(
            localization.dayOfWeek(day.day),
            style: themeData.textTheme.headline,
          ),
          subtitle: Row(children: <Widget>[
            Text(
              localization.youHave,
              style: themeData.textTheme.subtitle,
            ),
            Text(
              ' ${day.periods.length} ${localization.classes}',
              style: themeData.textTheme.subhead
                  .copyWith(color: themeData.accentColor),
            )
          ]),
        ),
      ]
            ..addAll(periodsView)
            ..add(Divider(
              height: 10,
            )));
    }).toList();

    return Column(children: daysView);
  }

  void _onPeriodTap(BuildContext context, Period period) {
    final localization = Localization.of(context);
    final ThemeData themeData = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: ListTile(
            isThreeLine: true,
            title: Text(
              period.subject.title,
              style: themeData.textTheme.title,
            ),
            subtitle: Text(localization.dayOfWeek(period.dayOfWeek)),
            trailing: Text('google'),
          ),
          content: Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(localization.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class DayWithPeriod {
  final int day;
  final List<Period> periods;

  DayWithPeriod({this.day, this.periods});
}
