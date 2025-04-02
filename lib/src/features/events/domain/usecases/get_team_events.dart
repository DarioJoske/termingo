import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/features/events/domain/entities/event.dart';

class GetTeamEvents implements UsecaseWithParams<List<Event>, GetTeamEventsParams> {}

class GetTeamEventsParams {
  final String teamId;

  GetTeamEventsParams({required this.teamId});
}
