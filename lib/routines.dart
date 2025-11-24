class Routines {
  String _routineName = "";

  // May need to edit this later to be a more complex data structure
  List<String> _exercises = [];
  var _repetitions = 0;
  var _sets = 0;

  // Getters
  String get routineName => _routineName;
  List<String> get exercises => _exercises;
  get repetitions => _repetitions;
  get sets => _sets;

  // Setters
  Routines(this._routineName, this._exercises, this._repetitions, this._sets);
}