import 'package:meta/meta.dart';

import '../data_provider/data_provider.dart';
import '../models/trial.dart';

class TrialRepository {
  TrialDataProvider dataProvider;

  TrialRepository(this.dataProvider);

  Future trialUser(String id) async {
    await dataProvider.trialUser(id);
  }
}