import 'package:flutter/material.dart';

void main() => runApp(AktsNotOrtalamasiApp());

class AktsNotOrtalamasiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AktsNotOrtalamasiPage(),
    );
  }
}

class AktsNotOrtalamasiPage extends StatefulWidget {
  @override
  _AktsNotOrtalamasiPageState createState() => _AktsNotOrtalamasiPageState();
}

class _AktsNotOrtalamasiPageState extends State<AktsNotOrtalamasiPage> {
  List<String> grades = ['AA', 'BA', 'BB', 'CB', 'CC', 'DC', 'DD', 'FD', 'FF'];
  Map<String, double> gradeValues = {
    'AA': 4.0,
    'BA': 3.5,
    'BB': 3.0,
    'CB': 2.5,
    'CC': 2.0,
    'DC': 1.5,
    'DD': 1.0,
    'FD': 0.5,
    'FF': 0.0,
  };
  int selectedCourseCount = 1;
  List<String> courseNames = [];
  List<int> courseCredits = [];
  List<String> courseGrades = [];

  void _calculateAverage() {
    double totalGrade = 0;
    int totalCredits = 0;

    for (int i = 0; i < selectedCourseCount; i++) {
      totalGrade += (gradeValues[courseGrades[i]]! * courseCredits[i])!;
      totalCredits += courseCredits[i];
    }

    double average = totalGrade / totalCredits;
    _showResultDialog(average);
  }

  void _showResultDialog(double average) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Üniversite Not Ortalaması"),
          content: Text("Ortalamanız: ${average.toStringAsFixed(2)}"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AKTS Not Ortalaması Hesaplama"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<int>(
              value: selectedCourseCount,
              onChanged: (value) {
                setState(() {
                  selectedCourseCount = value!;
                  courseNames.clear();
                  courseCredits.clear();
                  courseGrades.clear();
                });
              },
              items: List.generate(
                10,
                    (index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('${index + 1} Ders'),
                ),
              ),
            ),
            SizedBox(height: 16),
            for (int i = 0; i < selectedCourseCount; i++)
              _buildCourseInput(i),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _calculateAverage,
              child: Text("Ortalama Hesapla"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseInput(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ders ${index + 1} Adı:"),
        TextFormField(
          onChanged: (value) => courseNames.add(value),
          decoration: InputDecoration(hintText: "Ders Adı"),
        ),
        SizedBox(height: 8),
        Text("Ders ${index + 1} Kredisi:"),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) => courseCredits.add(int.tryParse(value) ?? 0),
          decoration: InputDecoration(hintText: "Kredi Sayısı"),
        ),
        SizedBox(height: 8),
        Text("Ders ${index + 1} Notu:"),
        DropdownButton<String>(
          value: courseGrades.length > index ? courseGrades[index] : null,
          onChanged: (value) {
            setState(() {
              if (courseGrades.length > index) {
                courseGrades[index] = value!;
              } else {
                courseGrades.add(value!);
              }
            });
          },
          items: grades.map((grade) {
            return DropdownMenuItem<String>(
              value: grade,
              child: Text(grade),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
