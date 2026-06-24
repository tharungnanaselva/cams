import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';

class SummaryBarChart extends StatelessWidget {
  final DashboardModel data;

  const SummaryBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total =
        data.totalBuildings +
        data.totalRooms +
        data.occupiedRooms +
        data.vacantRooms +
        data.totalOccupants;

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
              'System Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BarChart(
                BarChartData(
                  gridData: const FlGridData(show: true),

                  borderData: FlBorderData(show: false),

                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        getTitlesWidget: (value, meta) {
                          const labels = [
                            'Buildings',
                            'Rooms',
                            'Occupied',
                            'Vacant',
                            'Occupants',
                          ];

                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              labels[value.toInt()],
                              style: const TextStyle(fontSize: 11),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(toY: data.totalBuildings.toDouble()),
                      ],
                    ),

                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(toY: data.totalRooms.toDouble()),
                      ],
                    ),

                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(toY: data.occupiedRooms.toDouble()),
                      ],
                    ),

                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(toY: data.vacantRooms.toDouble()),
                      ],
                    ),

                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(toY: data.totalOccupants.toDouble()),
                      ],
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
