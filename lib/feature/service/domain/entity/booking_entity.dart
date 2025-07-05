import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String? id;
  final String customerName;
  final String serviceType;
  final String bikeModel;
  final DateTime date;
  final String? notes;
  final double totalCost;
  final String status; // 'Pending', 'Confirmed', 'Completed', 'Cancelled'
  final String paymentStatus; // 'Pending', 'Paid'
  final bool isPaid;
  final String? paymentMethod; // 'COD', 'Khalti'

  const BookingEntity({
     this.id,
    required this.customerName,
    required this.serviceType,
    required this.bikeModel,
    required this.date,
    this.notes,
    required this.totalCost,
    required this.status,
    required this.paymentStatus,
    required this.isPaid,
    this.paymentMethod,
  });

  @override
  List<Object?> get props => [id, status, paymentStatus, date];
}

