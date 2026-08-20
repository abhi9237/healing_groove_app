import 'package:get/get.dart';
import 'package:healing/presentation/model/common/doc_model.dart';

class ProgramPreviewDetailController extends GetxController {
   DocModel program;

  ProgramPreviewDetailController({required this.program});

  // Calculate pricing aggregates
  int get baseProgramPrice => program.price ?? program.basePrice ?? 0;

  int get servicesTotal {
    int sum = 0;
    if (program.services != null) {
      for (var svc in program.services!) {
        sum += svc.basePrice ?? 0;
      }
    }
    return sum;
  }

  int get doctorsTotal {
    int sum = 0;
    if (program.doctors != null) {
      for (var doc in program.doctors!) {
        sum += doc.consultationFee ?? 0;
      }
    }
    return sum;
  }

  int get grandTotal => baseProgramPrice + servicesTotal + doctorsTotal;

  // Set of available dates parsed into DateTime objects (ignoring time)
  Set<DateTime> get availableDateTimes {
    final dates = <DateTime>{};
    if (program.availableDates != null) {
      for (var avDate in program.availableDates!) {
        if (avDate.date != null) {
          try {
            final parsedDate = DateTime.parse(avDate.date!);
            dates.add(DateTime(parsedDate.year, parsedDate.month, parsedDate.day));
          } catch (_) {}
        }
      }
    }
    return dates;
  }
}
