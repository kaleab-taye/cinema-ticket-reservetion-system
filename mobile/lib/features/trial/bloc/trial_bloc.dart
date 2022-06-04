import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/trial_repository.dart';
import 'bloc.dart';

class TrialBloc extends Bloc<TrialEvent, TrialState> {

  final TrialRepository trialRepository;

  TrialBloc(this.trialRepository) : super(Idle()) {
    on<TrialAuth>(_onTrialAuth);
  }

  void _onTrialAuth(TrialAuth event, Emitter emit) async {
    await trialRepository.trialUser(event.trial.id!);
    emit(TrialSuccessful());
  }
}
