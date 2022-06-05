import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/bloc/todo_event.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/bloc/todo_state.dart';
import 'package:royal_cinema/features/mobile_staff/schedule/repository/schedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc(this.scheduleRepository) : super(SchedulesLoading()) {
    on<LoadSchedule>(_onLoadSchedules);
    on<CreateSchedule>(_onCreateSchedule);
    on<UpdateSchedule>(_onUpdateSchedule);
    on<DeleteSchedule>(_onDeleteSchedule);
    // on<UpdateMovie>(_onUpdateMovie);
  }

  void _onLoadSchedules(LoadSchedule event, Emitter emit) async {
    emit(SchedulesLoading());
    // await Future.delayed(const Duration(seconds: 3));
    final schedules = await scheduleRepository.getAllSchedules();
    if (schedules.hasError) {
      emit(SchedulesLoadingFailed(schedules.error!));
    } else {
      emit(SchedulesLoaded(schedules.val!));
    }
  }

  void _onCreateSchedule(CreateSchedule event, Emitter emit) async {
    emit(ScheduleCreating());
    final schedule = await scheduleRepository.createSchedule(event.schedule);
    // print(schedule);
    if (schedule.hasError) {
      emit(ScheduleCreatingFailed(schedule.error!));
    } else {
      emit(ScheduleCreated(schedule.val!));
    }
  }

  void _onUpdateSchedule(UpdateSchedule event, Emitter emit) async {
    
    emit(ScheduleUpdating());
    final schedule = await scheduleRepository.updateSchedule(event.schedule);
    if (schedule.hasError) {
      emit(ScheduleUpdatingFailed(schedule.error!));
    } else {
      emit(ScheduleUpdated(schedule.val!));
    }
  }

  void _onDeleteSchedule(DeleteSchedule event, Emitter emit) async {
    
    emit(ScheduleDeleting());
    final schedule = await scheduleRepository.deleteSchedule(event.id);
    if (schedule.hasError) {
      emit(ScheduleDeletingFailed(schedule.error!));
    } else {
      emit(ScheduleDeleted());
    }
  }
}
