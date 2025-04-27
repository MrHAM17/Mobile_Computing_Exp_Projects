# Mobile Computing Lab Projects 🧪📱  

**Semester 6 | Mobile Computing Lab**  

A collection of four Android/Flutter experiments illustrating core mobile-computing concepts: GPS services, dynamic UIs, canvas drawing, and practical calculators. Each folder is a standalone project—see below for an in-depth overview of aims, tools, architecture, code highlights, and lessons learned.  

---

## 🔧 Prerequisites  

- **Android Studio** 
- **Flutter SDK**
- **Android SDK**
- **Java JDK 8+**  
- **Physical device or emulator** (GPS experiment requires location hardware/services)  

---

## 🚀 Repository Structure  

```
mobile-computing-lab/
├── gps_location_ex7/      # Exp 7: GPS Location Info (Java + Flutter)
├── pixel_palette_ex8/     # Exp 8: GUI, Fonts & Colors (Flutter)
├── sketch_craft_ex9/      # Exp 9: Freehand Sketch Canvas (Flutter)
├── coin_flow_ex10/        # Exp 10: Income Tax & EMI Calculator (Flutter)
└── README.md              # This overview
```

---

## 📍 Experiment 7: GPS Location Information  

### Aim  
Build an application that retrieves and displays the device’s current latitude/longitude.

### Objectives  
- Learn to configure Android Studio, SDK, and project structure.  
- Use `LocationManager` (Java) and `geolocator`/`geocoding` (Flutter).  
- Handle runtime permissions and GPS settings prompts.

### Tools & Technologies  
- **Java Android:** Android Studio, Android SDK, Gradle, JDK 5  
- **Flutter:** `geolocator`, `geocoding`, `permission_handler`

### Architecture & Flow  
1. **Permission Check** → request LOCATION permission.  
2. **Location Fetch** → via GPS_PROVIDER or NETWORK_PROVIDER.  
3. **Reverse Geocoding** (Flutter) → display country, state, area, region.  
4. **UI Update** → show in Toast (Android) or in a styled `Scaffold` (Flutter).  

### Key Code Highlights  
#### Java (GPStrace.java)  
```java
locationManager.requestLocationUpdates(
    LocationManager.GPS_PROVIDER, 
    MIN_TIME_BW_UPDATES, MIN_DISTANCE_CHANGE_FOR_UPDATES, this
);
double lat = location.getLatitude(), lon = location.getLongitude();
```
Displays a Toast and prompts user to enable GPS if disabled.

#### Flutter (main.dart)  
```dart
Position pos = await Geolocator.getCurrentPosition(...);
List<Placemark> marks = await placemarkFromCoordinates(lat, lon);
setState(() {
  _latitude = '$lat';
  _locationCountry = marks.first.country;
});
```
Dynamic greeting based on time of day.

### Observations & Learning  
- **Provider Fallback:** Network‐based location before GPS to save battery.  
- **Permission Flow:** Always check/request at runtime.  
- **UI/UX:** Informative messages and graceful error handling.

### Output

![](https://github.com/MrHAM17/Mobile_Computing_Exp_Projects/blob/main/Output/Ex%2007.PNG)

---

## 🎨 Experiment 8: GUI Components, Fonts & Colors  

### Aim  
Create a Flutter app showcasing dynamic text styling—fonts, sizes, weights, colors, and decorations.

### Objectives  
- Master `StatefulWidget`, `TextEditingController`, and runtime theme changes.  
- Integrate custom fonts via `pubspec.yaml`.  
- Build interactive controls (buttons) to mutate text style.

### Tools & Technologies  
- Flutter, Dart  
- Custom fonts (e.g., Montserrat)  

### Key Code Highlights  
```dart
void changeFontSize() => setState(() {
  fontSize = fontSize + 5 > 50 ? 25 : fontSize + 5;
});
void changeTextColor() => setState(() {
  textColor = colors[colorIndex];
  colorIndex = (colorIndex + 1) % colors.length;
});
```
Multiple toggles—bold, italic, underline/strike, and color cycling.

### UI Layout  
- **TextField** for user input  
- **Live Preview** in a `Card`  
- **Control Buttons** in rows below (`Font size`, `Bold/Normal`, `Italic/Normal`, etc.)  
- **FAB** to clear text  

### Observations & Learning  
- Seamless integration of Google Fonts and asset fonts.  
- Importance of state management for responsive UIs.  
- User experience improves with immediate visual feedback.

### Output

![](https://github.com/MrHAM17/Mobile_Computing_Exp_Projects/blob/main/Output/Ex%2008.PNG)

---

## ✏️ Experiment 9: Sketch Craft (Canvas Drawing)  

### Aim  
Develop a freehand drawing app allowing sketching, undo/redo, erase, and save sketches.

### Objectives  
- Use `CustomPainter` and `Canvas` for vector drawing.  
- Capture touch input via `GestureDetector`.  
- Implement undo/redo stacks and persistent save notifications.

### Tools & Technologies  
- Flutter, Dart  
- `CustomPainter`, `Canvas`, `Path`  

### Key Code Highlights  
```dart
onPanStart: (d) => _startLine(offset),
onPanUpdate: (d) => _updateLine(offset),
onPanEnd: (_) => _finishLine();

void _undo() { if (_lines.isNotEmpty) undoList.add(_lines.removeLast()); }
```
Lines stored as `List<Offset>`; painter iterates segments to draw paths.

### Observations & Learning  
- **Data Structures:** Managing lists of points for history.  
- **UI Confirmation:** Clear-all prompt via `AlertDialog`.  
- **Extensibility:** Can add color/stroke width controls.

### Output

![](https://github.com/MrHAM17/Mobile_Computing_Exp_Projects/blob/main/Output/Ex%2009.PNG)

---

## 💰 Experiment 10: Income Tax & Loan EMI Calculator  

### Aim  
Implement an Income Tax and Loan EMI calculator with form inputs and result dialogs; deploy on real devices.

### Objectives  
- Build form-driven UIs using `TextField`, `DropdownButton`.  
- Perform real‐world financial computations in Dart.  
- Display results in `AlertDialog` and handle input clearing.

### Tools & Technologies  
- Flutter, Dart  

### Key Code Highlights  
```dart
double tax = (income <= 250000) ? 0 :
             (income <= 500000) ? (income - 250000) * .05 :
             12500 + (income - 500000) * .1;
// EMI formula:
double r = rateInput / 1200;
double emi = p * r * pow(1 + r, n) / (pow(1 + r, n) - 1);
```
Single screen with category switcher—Income Tax vs Loan EMI.

### Observations & Learning  
- **Dynamic Forms:** Using enums and conditional UI rendering.  
- **Error Handling:** `double.tryParse` safeguards parsing.  
- **UX:** Clear/Reset buttons improve usability.

### Output

![](https://github.com/MrHAM17/Mobile_Computing_Exp_Projects/blob/main/Output/Ex%2010.1.PNG)
![](https://github.com/MrHAM17/Mobile_Computing_Exp_Projects/blob/main/Output/Ex%2010.2.PNG)

---
