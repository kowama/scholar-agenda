import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';
import 'package:scholar_agenda/pages/timetable/period_form.dart';
import 'package:table_calendar/table_calendar.dart';

final timeFormat = intl.DateFormat.Hm();

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
  TimetablePeriodsBloc _timetablePeriodsBloc;
  SubjectsBloc _subjectsBloc;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = BlocProvider.of(context);
    _timetablePeriodsBloc = BlocProvider.of<TimetablePeriodsBloc>(context);
    _timetablePeriodsBloc.dispatch(LoadTimetablePeriods(widget.timetable));
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    return BlocBuilder<TimetablePeriodsBloc, TimetablePeriodsState>(
        builder: (context, state) {
      if (state is TimetablePeriodsLoaded) {
        if (widget.timetablePageTab == TimetablePageTab.weekView)
          return WeekView(
            periods: state.periods,
          );
        else {
          return DaysListView(
            periods: state.periods,
            onPeriodTap: _onPeriodTap,
          );
        }
      } else if (state is TimetablePeriodsLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Center(
          child: Text(localization.errorUnableToLoadData),
        );
      }
    });
  }

  void _onPeriodTap(Period period) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            isThreeLine: true,
            title: Text(
              period.subject.title,
              style: themeData.textTheme.title,
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(localization.dayOfWeek(period.dayOfWeek),
                        style: themeData.textTheme.caption),
                    Text(
                      ' | ${timeFormat.format(period.start)}'
                      ' - ${timeFormat.format(period.end)}',
                      style: themeData.textTheme.caption,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.room,
                        size: 12,
                      ),
                      Text('  ${period.location.isNotEmpty?period.location:localization.undefined }'),
                    ],
                  ),
                )
              ],
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text(localization.delete),
                onPressed: () {
                  _showDeleteDialog(period);
                },
              ),
              RaisedButton(
                child: Text(localization.edit),
                onPressed: () {
                  Navigator.of(context).pop();
                  _navigateToEdit(period);
                },
              )
            ],
          ),
          actions: <Widget>[
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

  void _navigateToEdit(Period period) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<TimetablePeriodsBloc>(
                  builder: (context) => _timetablePeriodsBloc,
                ),
                BlocProvider<SubjectsBloc>(
                  builder: (context) => _subjectsBloc,
                )
              ],
              child: PeriodFormPage(
                timetable: period.timetable,
                period: period,
              ),
            )));
  }

  void _showDeleteDialog(Period period) {
    final localization = Localization.of(context);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(localization.areYouSure),
            content: Text('${localization.delete} ${localization.period}'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: () {
                  _timetablePeriodsBloc.dispatch(DeletePeriod(period));
                  Navigator.of(context).pop();
                },
                child: Text(
                  localization.delete,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  localization.cancel,
                  style: TextStyle(color: Colors.black45),
                ),
              )
            ],
          );
        });
  }
}

/// Calendar WeekView with tasks as Bar
class WeekView extends StatefulWidget {
  final cellHeight = 50.0;
  final numDayOfWeek = 7;
  final rowsCount = 25.5;
  final List<Period> periods;
  final OnPeriodTap onPeriodTap;

  const WeekView({Key key, @required this.periods, this.onPeriodTap})
      : super(key: key);

  @override
  _WeekViewState createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  CalendarController _calendarController;

  ScrollController _scrollController;

  get cellHeight => widget.cellHeight;

  get numDayOfWeek => widget.numDayOfWeek;

  get rowsCount => widget.rowsCount;

  get periods => widget.periods;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _scrollController = ScrollController(
      initialScrollOffset: cellHeight * DateTime.now().hour,
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cellWidth = MediaQuery.of(context).size.width / (numDayOfWeek + 1);
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: WeekViewHeaderDelegate(
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
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, cellHeight * rowsCount),
      painter: WeekViewBackground(
          cellWidth: cellWidth, cellHeight: cellHeight, rowsCount: rowsCount),
      foregroundPainter: WeekViewForeground(
          periods: periods,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          rowsCount: rowsCount),
    );
  }
}

class WeekViewBackground extends CustomPainter {
  final cellHeight;
  final cellWidth;
  final rowsCount;
  final columnsCount = 9;
  final numberOfHours = 24;
  Paint _paint = new Paint();

  WeekViewBackground(
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
    final old = (oldDelegate as WeekViewBackground);
    return cellWidth != old.cellWidth &&
        cellHeight != old.cellWidth &&
        rowsCount != old.rowsCount;
  }
}

class WeekViewForeground extends CustomPainter {
  static const columnsCount = 9.0;
  static const numberOfHours = 24.0;
  static const leftPad = 4.0;
  static const topPad = 0.5;
  final List<Period> periods;
  final cellHeight;
  final cellWidth;
  final rowsCount;
  final maxWidth;

  final _paint = new Paint();

  WeekViewForeground(
      {@required this.periods,
      @required this.cellHeight,
      @required this.cellWidth,
      @required this.rowsCount})
      : maxWidth = cellWidth - leftPad;

  @override
  void paint(Canvas canvas, Size size) {
    // draw periods
    for (var p in periods) {
      // draw box
      _paint.color = p.subject.color;
      final left = (p.dayOfWeek) * cellWidth;
      final top = (topPad + p.start.hour + p.start.minute / 60) * cellHeight;
      final height =
          cellHeight * (p.end.difference(p.start).inMinutes.abs() / 60.0);

      canvas.drawRect(
          Rect.fromLTWH(left + leftPad / 2, top, cellWidth - leftPad, height),
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
          left + leftPad / 2 + (maxWidth - textPainter.width) / 2,
          top + height / 2 - textPainter.height / 2);
      textPainter.paint(canvas, offset);
    }
    // draw current time line
    final now = DateTime.now();

    final y = (topPad + now.hour + now.minute / 60) * cellHeight;
    _paint.color = Colors.red;
    _paint.strokeWidth = 3;
    canvas.drawLine(Offset(cellWidth, y), Offset(8 * cellWidth, y), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return periods != (oldDelegate as WeekViewForeground).periods;
  }
}

class WeekViewHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget _content;
  final double _leftOffset;

  WeekViewHeaderDelegate(
    this._content,
    this._leftOffset,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: EdgeInsets.only(left: _leftOffset),
      child: Container(child: _content),
    );
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 87;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return _content != (oldDelegate as WeekViewHeaderDelegate)._content;
  }
}

/// Days as ListView with theirs tasks
class DaysListView extends StatefulWidget {
  final List<Period> periods;
  final OnPeriodTap onPeriodTap;

  const DaysListView({
    Key key,
    this.periods,
    this.onPeriodTap,
  }) : super(key: key);

  @override
  _DaysListViewState createState() => _DaysListViewState(periods: periods);
}

class _DaysListViewState extends State<DaysListView> {
  final List<DayWithPeriod> days;

  _DaysListViewState({@required List<Period> periods})
      : days = groupPeriodsByDay(periods);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: days.map((day) => _dayToView(day)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _dayToView(DayWithPeriod day) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
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
              ' ${day.periods.length} ${localization.classes.toLowerCase()}',
              style: themeData.textTheme.subhead
                  .copyWith(color: themeData.accentColor),
            )
          ]),
        ),
      ]
        ..addAll(_periodsToView(day.periods))
        ..add(Divider(
          height: 10,
        )),
    );
  }

  List<Widget> _periodsToView(List<Period> periods) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return periods
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
                    color: themeData.hintColor,
                  ),
                  Text('  ${period.location.isNotEmpty?period.location:localization.undefined }')
                ],
              ),
              trailing: Container(
                width: 10,
                color: period.subject.color,
              ),
              isThreeLine: true,
              onTap: () {
                widget.onPeriodTap(period);
              },
            ),
          ),
        )
        .toList();
  }

  static List<DayWithPeriod> groupPeriodsByDay(final List<Period> periods) {
    return List.generate(
      7,
      (i) => DayWithPeriod(
        day: (i + 1),
        periods: periods.where((p) => p.dayOfWeek == (i + 1)).toList()
          ..sort((p1, p2) => (p1.start.hour - p2.start.hour) != 0
              ? (p1.start.hour - p2.start.hour)
              : (p1.start.minute - p2.start.minute)),
      ),
    );
  }
}

class DayWithPeriod {
  final int day;
  final List<Period> periods;

  DayWithPeriod({this.day, this.periods});
}

typedef void OnPeriodTap(Period period);
