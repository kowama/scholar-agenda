import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/bloc_delegate.dart';
import 'models/models.dart';
import 'scholar_agenda_app.dart';
import 'services/preferences.dart';

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  await Preferences.initialize();
  runApp(
    Provider<ScholarAgendaAppDb>(
        builder: (context) => ScholarAgendaAppDb(),
        child: ScholarAgendaApp(),
        dispose: (context, db) => db.close()),
  );
}
