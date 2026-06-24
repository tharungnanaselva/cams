import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';

class OccupancyPieChart extends StatelessWidget {
  final DashboardModel data;

  const OccupancyPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total =
        data.roomStatusSummary.available +
        data.roomStatusSummary.occupied +
        data.roomStatusSummary.reserved +
        data.roomStatusSummary.blocked +
        data.roomStatusSummary.maintenance;

    if (total == 0) {
      return const Card(child: Center(child: Text('No chart data')));
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Room Status Distribution',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,

                  sections: [
                    PieChartSectionData(
                      value: data.roomStatusSummary.available.toDouble(),
                      title: 'Available\n${data.roomStatusSummary.available}',
                      radius: 90,
                    ),

                    PieChartSectionData(
                      value: data.roomStatusSummary.occupied.toDouble(),
                      title: 'Occupied\n${data.roomStatusSummary.occupied}',
                      radius: 90,
                    ),

                    PieChartSectionData(
                      value: data.roomStatusSummary.reserved.toDouble(),
                      title: 'Reserved\n${data.roomStatusSummary.reserved}',
                      radius: 90,
                    ),

                    PieChartSectionData(
                      value: data.roomStatusSummary.blocked.toDouble(),
                      title: 'Blocked\n${data.roomStatusSummary.blocked}',
                      radius: 90,
                    ),

                    PieChartSectionData(
                      value: data.roomStatusSummary.maintenance.toDouble(),
                      title:
                          'Maintenance\n${data.roomStatusSummary.maintenance}',
                      radius: 90,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
