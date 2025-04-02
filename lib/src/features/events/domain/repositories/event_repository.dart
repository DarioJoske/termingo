import 'package:termingo/src/core/utils/typedefs.dart';
import 'package:termingo/src/features/events/domain/entities/event.dart';

abstract class EventRepository {
  /// Creates an event with the given [eventName], [teamId], and [userId].
  ///
  /// Returns the created event.
  ResultFuture<Event> createEvent({required String eventName, required String teamId, required String userId});

  /// Retrieves a stream of events for the specified [teamId].
  ///
  /// Returns a stream of events.
  ResultFuture<List<Event>> getTeamEvents({required String teamId});
}
