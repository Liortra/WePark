import 'package:json_annotation/json_annotation.dart';

part 'queueing_theory.g.dart';

@JsonSerializable()
class QueueingTheory{
  double generalQuantity; 		// L - Total amount of customers in system (currently parking + waiting for a parking place)
  double arrivalRate; 			// Lamda - arrival rate of customers to the GRID
  double totalTimeInSystem; 		// W - Total time in the system (waiting for a parking place + parking)
  double averageQueueQuantity_q; 	// Lq - amount of customers waiting for a parking in average.
  double averageWaitingTime_q; 	// Wq - average waiting time in a queue
  double serviceRate; 			// Meu - how many customers, a single parking spot, is serving (in a unit of time)
  double averageServiceDuration; 	// 1/Meu - how long customer is using a parking spot
  int servers; 				// C - how many parking spots are available
  double overload;				// p - load on the system
  double getServiceImmediately; 	// p0 - What is the chance of getting service immediately without waiting at all
  double w_t; 					// W(t) - The chances to get a service within t units of time
  double r;

  QueueingTheory(
      this.generalQuantity,
      this.arrivalRate,
      this.totalTimeInSystem,
      this.averageQueueQuantity_q,
      this.averageWaitingTime_q,
      this.serviceRate,
      this.averageServiceDuration,
      this.servers,
      this.overload,
      this.getServiceImmediately,
      this.w_t,
      this.r);
}