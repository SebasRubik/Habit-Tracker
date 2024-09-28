import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';
import '../widgets/habit_card.dart';
import '../widgets/button_with_text.dart';

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  _HabitTrackerScreenState createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  String newHabit = "";
  final TextEditingController _textController = TextEditingController();
  List<Habit> habits = [];
  final HabitService servicios = HabitService();

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  void _addHabit(String habitName) async {
    setState(() {
      habits.add(Habit(name: habitName, streak: 0, completed: false));
    });
    await servicios.guardarHabitos(habits);
  }

  Future<void> _loadHabits() async {
    List<Habit> loadedHabits = await servicios.leerHabitos();
    setState(() {
      habits = loadedHabits;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Seguimiento de Hábitos',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Row con TextField para Añadir Hábito y el botón de Nuevo Hábito
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 185,
                      height: 45,
                      child: TextField(
                        controller: _textController,
                        onChanged: (value) {
                          setState(() {
                            newHabit = value;
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 0, 5),
                          hintText: 'Nuevo Hábito',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(104, 0, 0, 0),
                              fontSize: 20,
                              fontFamily: 'Poppins'),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Botón de Nuevo Hábito
                  Expanded(
                    flex: 2,
                    child: ButtonWithText(
                      text: 'Añadir hábito',
                      textColor: Colors.white,
                      plusIcon: Image(image: AssetImage('assets/plus.png')),
                      onPressed: () {
                        if (newHabit.isNotEmpty) {
                          _addHabit(newHabit);
                          _textController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      HabitCard(
                        habit: habits[index],
                        habitos: habits,
                        servicios: servicios,
                        onHabitDeleted: () {
                          setState(() {
                              
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
