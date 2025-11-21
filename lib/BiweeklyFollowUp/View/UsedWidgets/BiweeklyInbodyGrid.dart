import 'package:flutter/material.dart';

import '../../../Core/Controller/UtilityFunctions.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Controller/BiweeklyFollowUpTEC.dart';

class BiweeklyInbodyGrid extends StatelessWidget {
  final Client client;
  final List<ClientMonthlyFollowUp> previousFollowUps;

  const BiweeklyInbodyGrid({
    super.key,
    required this.client,
    required this.previousFollowUps,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure previous follow-ups are in chronological order for labeling.
    final List<ClientMonthlyFollowUp> sortedAsc = [...previousFollowUps];
    sortedAsc.sort((a, b) {
      final da = a.mDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      final db = b.mDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      return da.compareTo(db);
    });

    final List<_InbodyColumn> previousColumns = [];

    if (sortedAsc.isNotEmpty) {
      previousColumns.add(_InbodyColumn(
        title: 'الانبدي الاول',
        followUp: sortedAsc.first,
      ));
    }

    if (sortedAsc.length > 2) {
      final secondToLast = sortedAsc[sortedAsc.length - 2];
      if (!previousColumns
          .any((c) => c.followUp.mClientMonthlyFollowUpId ==
              secondToLast.mClientMonthlyFollowUpId)) {
        previousColumns.add(_InbodyColumn(
          title: 'الانبدي القبل الاخير',
          followUp: secondToLast,
        ));
      }
    }

    if (sortedAsc.length > 1) {
      final last = sortedAsc.last;
      if (!previousColumns.any((c) =>
          c.followUp.mClientMonthlyFollowUpId ==
          last.mClientMonthlyFollowUpId)) {
        previousColumns.add(_InbodyColumn(
          title: 'الانبدي الاخير',
          followUp: last,
        ));
      }
    }

    final attributes = _buildAttributes(client);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: myCard(
        'نتائج الانبدي السابقة والحالية',
        Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              // Let each column size itself based on its content so the table
              // can grow horizontally and be scrolled instead of squeezing
              // all columns into the available width.
              defaultColumnWidth: const IntrinsicColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                color: Colors.black,
                width: 2,
              ),
              children: [
                // Header row
                TableRow(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Text(
                        'البند',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ...previousColumns.map(
                      (col) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: SizedBox(
                          width: 140,
                          child: Column(
                            children: [
                              Text(
                                col.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                getDateText(col.followUp.mDate),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Text(
                        'اليوم',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                // Data rows
                ...attributes.map(
                  (row) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: Text(
                          row.label,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      ...previousColumns.map(
                        (col) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          child: SizedBox(
                            width: 140,
                            child: Text(
                              row.getPreviousValue(col.followUp),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: row.todayWidget,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_InbodyRow> _buildAttributes(Client client) {
    return [
      _InbodyRow(
        label: 'الوزن (كجم)',
        previousValueBuilder: (cmfu) {
          final weight =
              deriveWeightFromBmi(cmfu.mBMI, client.mHeight) ?? 0.0;
          if (weight == 0.0) return '';
          return formatOneDecimal(weight);
        },
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mWeightController,
            label: 'الوزن (كجم)',
            hint: 'Weight (kg)',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'كتلة العضلات',
        previousValueBuilder: (cmfu) =>
            cmfu.mMuscleMass == null || cmfu.mMuscleMass == 0
                ? ''
                : formatOneDecimal(cmfu.mMuscleMass),
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mMuscleMassController,
            hint: 'Muscle Mass',
            label: 'كتلة العضلات',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'الماء',
        previousValueBuilder: (cmfu) => cmfu.mWater ?? '',
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mWaterController,
            hint: 'Water',
            label: 'الماء',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'BMI',
        previousValueBuilder: (cmfu) =>
            cmfu.mBMI == null || cmfu.mBMI == 0 ? '' : formatOneDecimal(cmfu.mBMI),
        todayWidget: Align(
          alignment: Alignment.center,
          child: Text(
            _computeCurrentBmi(client),
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
      _InbodyRow(
        label: 'نسبة الدهون',
        previousValueBuilder: (cmfu) =>
            cmfu.mPBF == null || cmfu.mPBF == 0 ? '' : formatOneDecimal(cmfu.mPBF),
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mPBFController,
            label: 'نسبة الدهون',
            hint: 'PBF',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'معدل الحرق الأساسي',
        previousValueBuilder: (cmfu) =>
            cmfu.mBMR == null || cmfu.mBMR == 0 ? '' : formatOneDecimal(cmfu.mBMR),
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            label: 'معدل الحرق الأساسي',
            myController: BiweeklyFollowUpTEC.mBMRController,
            hint: 'BMR',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'أقصي وزن',
        previousValueBuilder: (cmfu) => cmfu.mMaxWeight == null ||
                cmfu.mMaxWeight == 0
            ? ''
            : formatOneDecimal(cmfu.mMaxWeight),
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mMaxWeightController,
            hint: '',
            label: 'أقصي وزن',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'الوزن المثالي',
        previousValueBuilder: (cmfu) =>
            cmfu.mOptimalWeight == null || cmfu.mOptimalWeight == 0
                ? ''
                : formatOneDecimal(cmfu.mOptimalWeight),
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mOptimalWeightController,
            hint: '',
            label: 'الوزن المثالي',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'أقصي سعرات',
        previousValueBuilder: (cmfu) =>
            cmfu.mMaxCalories == null || cmfu.mMaxCalories == 0
                ? ''
                : formatOneDecimal(cmfu.mMaxCalories),
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mMaxCaloriesController,
            hint: '',
            label: 'أقصي سعرات',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'السعرات اليومية',
        previousValueBuilder: (cmfu) =>
            cmfu.mDailyCalories == null || cmfu.mDailyCalories == 0
                ? ''
                : formatOneDecimal(cmfu.mDailyCalories),
        todayWidget: SizedBox(
          width: 160,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mDailyCaloriesController,
            hint: '',
            label: 'السعرات اليومية',
            textAlign: TextAlign.right,
          ),
        ),
      ),
      _InbodyRow(
        label: 'ملاحظات',
        previousValueBuilder: (cmfu) => cmfu.mNotes ?? '',
        todayWidget: SizedBox(
          width: 220,
          child: MyInputField(
            myController: BiweeklyFollowUpTEC.mNotesController,
            hint: 'أدخل ملاحظات إضافية...',
            label: 'ملاحظات',
            maxLines: 2,
            textAlign: TextAlign.right,
          ),
        ),
      ),
    ];
  }

  String _computeCurrentBmi(Client client) {
    final height = client.mHeight;
    final weightText = BiweeklyFollowUpTEC.mWeightController.text.trim();
    final weight = double.tryParse(weightText);
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      return '';
    }
    final bmi = weight / ((height / 100) * (height / 100));
    return formatOneDecimal(normalizeBmi(bmi));
  }
}

class _InbodyColumn {
  final String title;
  final ClientMonthlyFollowUp followUp;

  _InbodyColumn({
    required this.title,
    required this.followUp,
  });
}

class _InbodyRow {
  final String label;
  final String Function(ClientMonthlyFollowUp) previousValueBuilder;
  final Widget todayWidget;

  _InbodyRow({
    required this.label,
    required this.previousValueBuilder,
    required this.todayWidget,
  });

  String getPreviousValue(ClientMonthlyFollowUp cmfu) {
    return previousValueBuilder(cmfu);
  }
}


