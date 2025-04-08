import 'package:termingo/src/core/usecases/usecases.dart';
import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/events/domain/entities/event.dart';
import 'package:termingo/src/features/events/domain/repositories/event_repository.dart';

class GetTeamEvents implements UsecaseWithParams<List<Event>, GetTeamEventsParams> {
  final EventRepository eventRepository;

  const GetTeamEvents({required this.eventRepository});

  @override
  ResultFuture<List<Event>> call(GetTeamEventsParams params) {
    return eventRepository.getTeamEvents(teamId: params.teamId);
  }
}

class GetTeamEventsParams {
  final String teamId;

  GetTeamEventsParams({required this.teamId});
}
