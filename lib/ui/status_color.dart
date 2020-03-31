import 'package:flutter/material.dart';

enum CTStatusColor { YES, NO, SYMPTOMS }

Pair getSymptomData(int value) {
  switch (value) {
    case 0:
      {
        return Pair("No Symptoms", getColorIconForStatus(CTStatusColor.NO));
      }
      break;
    case 1:
      {
        return Pair(
            "Tested Positive", getColorIconForStatus(CTStatusColor.YES));
      }
      break;
    case 2:
      {
        return Pair("Symptoms, not tested",
            getColorIconForStatus(CTStatusColor.SYMPTOMS));
      }
      break;
  }

  return null;
}

getColorIconForStatus(CTStatusColor ctStatusColor) {
  switch (ctStatusColor) {
    case CTStatusColor.YES:
      {
        return Pair(
            Colors.red,
            Icon(
              Icons.add_circle_outline,
              color: Colors.red,
            ));
      }
      break;
    case CTStatusColor.NO:
      {
        return Pair(
          Colors.green,
          Icon(
            Icons.remove_circle_outline,
            color: Colors.green,
          ),
        );
      }
      break;
    case CTStatusColor.SYMPTOMS:
      {
        return Pair(
            Colors.amber,
            Image.asset(
              "assets/images/help_circle.png",
              color: Colors.amber,
            ));
      }
  }
}

class Pair<T, S> {
  T first;
  S second;

  Pair(this.first, this.second);
}
