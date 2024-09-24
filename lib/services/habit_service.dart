import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/habit.dart';

class HabitService {
  Future<void> guardarHabitos(List<Habit> habitos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList = habitos.map((habit) => jsonEncode(habit.toJson())).toList();
    await prefs.setStringList('habitos', jsonStringList);
    print(jsonStringList);
  }

  Future<List<Habit>> leerHabitos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('habitos');
    if (jsonStringList == null) {
      return [];
    }
    return jsonStringList.map((jsonString) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      print(Habit.fromJson(json));
      return Habit.fromJson(json);
    }).toList();
  }
}
