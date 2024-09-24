# Habit Tracker App

## Descripción

**Habit Tracker** es una aplicación desarrollada en Flutter que ayuda a los usuarios a realizar un seguimiento de sus hábitos diarios. Permite agregar nuevos hábitos, visualizar la racha de días consecutivos en los que se han completado y mostrar los niveles de progreso para cada hábito. La aplicación también guarda los hábitos utilizando `shared_preferences`, permitiendo que los datos persistan incluso después de cerrar la app.

## Características

- Agregar nuevos hábitos.
- Ver el progreso de racha diaria de los hábitos.
- Reiniciar la racha si no se ha completado el hábito en un día.
- Actualizar el nivel del hábito basado en la cantidad de días completados.
- Persistencia de datos usando `shared_preferences`.
- Iconos adaptativos para Android e iOS.

## Instalación

### Requisitos previos:

- Tener Flutter instalado en tu máquina. Si no lo tienes, puedes seguir la [guía oficial de instalación de Flutter](https://flutter.dev/docs/get-started/install).
- Tener un emulador de Android o iOS configurado, o un dispositivo físico conectado.

### Pasos:

1. Clona el repositorio a tu máquina local:
   
   git clone https://github.com/tuusuario/habit-tracker.git

2. Navega a la carpeta del proyecto:

   cd habit-tracker

3. Instala las dependencias de Flutter:

   flutter pub get

4. Conéctate a un dispositivo o emulador y ejecuta la aplicación:

   flutter run

## Iconos personalizados

Para cambiar los iconos de la aplicación, se ha utilizado el paquete `flutter_launcher_icons`. Asegúrate de colocar los archivos de imagen en la carpeta `assets/Logo/` y actualiza el archivo `pubspec.yaml` con las rutas correctas. Luego, puedes ejecutar:

flutter pub run flutter_launcher_icons:main

Esto generará los iconos para Android e iOS automáticamente.

## Estructura del proyecto

El proyecto sigue una estructura clara y modular:

```
habit-tracker/
│
├── assets/               # Archivos de recursos como imágenes
│   └── Logo/             # Iconos personalizados
│
├── lib/                  # Código fuente principal de Flutter
│   ├── models/           # Modelos de datos como Habit
│   ├── services/         # Servicios como HabitService
│   ├── widgets/          # Widgets reutilizables como HabitCard
│   └── main.dart         # Punto de entrada de la aplicación
│
├── android/              # Archivos específicos de Android
│
├── ios/                  # Archivos específicos de iOS
│
├── pubspec.yaml          # Configuración de Flutter y dependencias
│
└── README.md             # Este archivo
```


## Dependencias principales

- `shared_preferences`: Para el almacenamiento local de los hábitos.
- `flutter_launcher_icons`: Para generar los iconos de la aplicación. (Debe revisarse su funcionamiento)

## Cómo contribuir

Si quieres contribuir a este proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una rama nueva (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza tus cambios y haz commit (`git commit -m 'Agrega nueva funcionalidad'`).
4. Sube tu rama (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.
