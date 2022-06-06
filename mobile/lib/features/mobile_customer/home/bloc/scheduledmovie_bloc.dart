import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/schedule_repository.dart';
import 'bloc.dart';

class ScheduledBloc extends Bloc<ScheduledEvent, ScheduledState> {
  final ScheduledRepository scheduledRepository;
  // final String query;

  ScheduledBloc(this.scheduledRepository) : super(ScheduledsLoading()) {
    on<LoadScheduleds>(_onLoadScheduleds);
    // on<UpdateScheduled>(_onUpdateScheduled);
  }

  void _onLoadScheduleds(LoadScheduleds event, Emitter emit) async {
    emit(ScheduledsLoading());
    await Future.delayed(const Duration(seconds: 1));
    final scheduleds = await scheduledRepository.getAllScheduleds();
    if (scheduleds.hasError) {
      emit(ScheduledsLoadingFailed(scheduleds.error!));
    } else {
      emit(ScheduledsLoaded(scheduleds.val!));
    }
  }

  // void _onUpdateScheduled(UpdateScheduled event, Emitter emit) async {
  //   await scheduledRepository.editScheduled(event.scheduled.id, event.scheduled);
  //   emit(ScheduleUpdateSuccessful());
  // }
}
