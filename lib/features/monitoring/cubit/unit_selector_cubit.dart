import 'package:monitoring_models/monitoring_models.dart';

import '../../../core/bloc/app_bloc.dart';

class UnitSelectorCubit extends Cubit<PowerUnit> {
  UnitSelectorCubit() : super(PowerUnit.watts);

  void selectUnit(PowerUnit unit) {
    emit(unit);
  }
}
