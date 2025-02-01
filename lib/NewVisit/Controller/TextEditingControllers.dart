import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Visit.dart';

// Visit
final TextEditingController visitDateController = TextEditingController();
final TextEditingController visitDietController = TextEditingController();
final TextEditingController visitWeightController = TextEditingController();
final TextEditingController visitBMIController = TextEditingController();
final TextEditingController visitNotesController = TextEditingController();

List<Visit> clientVisits = [];