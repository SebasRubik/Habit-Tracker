import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:habit_track/services/habit_service.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final List<Habit> habitos;
  final HabitService servicios;

  const HabitCard({
    Key? key,
    required this.habit,
    required this.habitos,
    required this.servicios,
  }) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  int maxBar = 21;
  String buttonText = 'Completar';
  Color buttonColor = Colors.black;
  Color buttonTextColor = Colors.white;
  Widget icon = Image(image: AssetImage('assets/CheckMark.png'));

  @override
  void initState() {
    super.initState();
    _checkStreak();

    // Verificamos si es un nuevo día para resetear la opción de completado.
    if (_isNewDay(widget.habit.lastCompletedDate)) {
      widget.habit.completed = false;
    }

    // Establecer el estado inicial del botón basado en el estado de completado
    if (widget.habit.completed) {
      buttonText = 'Desmarcar';
      buttonColor = Colors.white;
      buttonTextColor = Colors.black;
      icon = Image(image: AssetImage('assets/Cancel.png'));
    } else {
      buttonText = 'Completar';
      buttonColor = Colors.black;
      buttonTextColor = Colors.white;
      icon = Image(image: AssetImage('assets/CheckMark.png'));
    }
  }

    // Verifica si es un nuevo día y actualiza la racha
  void _checkStreak() {
    DateTime today = DateTime.now();
    DateTime? lastCompleted = widget.habit.lastCompletedDate;

    // Si es la primera vez que se completa o el último completado fue más de 1 día atrás
    if (lastCompleted != null) {
      int daysDifference = today.difference(lastCompleted).inDays;

      if (daysDifference == 1) {
        // Si fue completado justo el día anterior, sumamos a la racha
        widget.habit.streak += 1;
      } else if (daysDifference > 1) {
        // Si la diferencia es mayor a 1 día, reiniciamos la racha
        widget.habit.streak = 0;
      }
    } else {
      // Si nunca ha sido completado, la racha empieza desde 0
      widget.habit.streak = 0;
    }
  }

  

  // Verifica si es un nuevo día
  bool _isNewDay(DateTime? ultimaFecha) {
    if (ultimaFecha == null) return true;
    DateTime today = DateTime.now();
    return today.difference(ultimaFecha).inDays >= 1;
  }

  // Función para manejar el estado del hábito al marcarlo como completado/desmarcado
  void _toggleComplete() async {
    setState(() {
      if (!widget.habit.completed) {
        widget.habit.streak += 1;
        _updateLevel(widget.habit.streak);
        widget.habit.completed = true;
        widget.habit.lastCompletedDate = DateTime.now();
        buttonText = 'Desmarcar';
        buttonColor = Colors.white;
        buttonTextColor = Colors.black;
        icon = Image(image: AssetImage('assets/Cancel.png'));
      } else {
        // Si se desmarca, reducimos la racha y marcamos como incompleto
        widget.habit.streak -= 1;
        widget.habit.completed = false;
        buttonText = 'Completar';
        buttonColor = Colors.black;
        buttonTextColor = Colors.white;
        icon = Image(image: AssetImage('assets/CheckMark.png'));
      }
    });

    // Guardamos el nuevo estado del hábito
    await widget.servicios.guardarHabitos(widget.habitos);
  }

  // Actualiza el nivel del hábito basado en la racha
  void _updateLevel(int days) {
    if (days >= 21) {
      widget.habit.level = 2;
    } else if (days >= 42) {
      widget.habit.level = 3;
    } else if (days >= 63) {
      widget.habit.level = 4;
    } else if (days >= 84) {
      widget.habit.level = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construimos la tarjeta con la información actualizada del hábito
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black.withOpacity(1)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(62, 255, 255, 255),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.habit.name,
            style: const TextStyle(
              fontSize: 30,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Racha actual: ${widget.habit.streak} días',
            style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: widget.habit.streak / maxBar * widget.habit.level,
            minHeight: 8,
            backgroundColor: const Color(0xFFBABABA),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF141414)),
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 40,
            width: 350,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.fromLTRB(95.0, 6.0, 8.0, 6.0),
                side: BorderSide(color: Colors.black.withOpacity(1), width: 1),
                shadowColor: const Color(0x3F000000),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: _toggleComplete,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: buttonTextColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
