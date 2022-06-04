
import '../models/trial.dart';

abstract class TrialEvent {}

class TrialAuth extends TrialEvent {
  final Trial trial;

  TrialAuth(this.trial);
}