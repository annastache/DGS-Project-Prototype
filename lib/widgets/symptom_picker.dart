import 'package:flutter/material.dart';
 
Future<String?> showSymptomPicker(BuildContext context) async {
  const symptoms = [
    'Bauchschmerzen',
    'Übelkeit',
    'Kopfschmerzen',
    'Müdigkeit',
    'Blähungen',
    'Sodbrennen',
  ];
 
  return showModalBottomSheet<String>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Welches Symptom möchtest du erfassen?',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            for (final symptom in symptoms)
              ListTile(
                title: Text(symptom),
                onTap: () => Navigator.pop(context, symptom),
              ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
