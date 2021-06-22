class DiffTimeFunction {
  DateTime start;
  DateTime end;

  int get diffMin => (end?.difference(start)?.inMinutes)??-1;
}


