import '../entities/auction_event.dart';

abstract class WatchAuctionEventsUseCase {
  Stream<AuctionEvent> call(String auctionId);
}
// Note: This one is usually implemented by a provider or repository 
// because it's a stream, but we'll provide a wrapper if needed.
