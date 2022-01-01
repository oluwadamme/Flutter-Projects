import 'package:rxdart/rxdart.dart';
import 'package:notify_app/model/notify.dart';

class NewEntryBloc {
  BehaviorSubject<Categoryn>? _selectedCategoryn;
  ValueStream<Categoryn>? get selectedCategoryn => _selectedCategoryn!.stream;

  BehaviorSubject<String>? _selectedTimeOfDay;
  BehaviorSubject<String>? get selectedTimeOfDay => _selectedTimeOfDay;

  BehaviorSubject<EntryError>? _errorState;
  BehaviorSubject<EntryError>? get errorState => _errorState;

  NewEntryBloc() {
    _selectedCategoryn = BehaviorSubject<Categoryn>.seeded(Categoryn.Others);
    // _checkedDays = BehaviorSubject<List<Day>>.seeded([]);
    _selectedTimeOfDay = BehaviorSubject<String>.seeded("Others");
    _errorState = BehaviorSubject<EntryError>();
  }

  void dispose() {
    _selectedCategoryn!.close();
    // _checkedDays.close();
    _selectedTimeOfDay!.close();
  }

  void submitError(EntryError error) {
    _errorState!.add(error);
  }

  void updateTime(String time) {
    _selectedTimeOfDay!.add(time);
  }

  // void addtoDays(Day day) {
  //   List<Day> _updatedDayList = _checkedDays.value;
  //   if (_updatedDayList.contains(day)) {
  //     _updatedDayList.remove(day);
  //   } else {
  //     _updatedDayList.add(day);
  //   }
  //   _checkedDays.add(_updatedDayList);
  // }

  void updateSelectedNote(Categoryn type) {
    Categoryn _tempType = _selectedCategoryn!.value;
    if (type == _tempType) {
      _selectedCategoryn!.add(Categoryn.Others);
    } else {
      _selectedCategoryn!.add(type);
    }
  }
}
