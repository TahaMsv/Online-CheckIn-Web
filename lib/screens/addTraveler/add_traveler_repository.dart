import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import 'data_source/add_traveler_remote_ds.dart';
import 'interfaces/add_traveler_repository_interface.dart';

class AddTravelerRepository implements AddTravelerRepositoryInterface {
  final AddTravelerRemoteDataSource addTravelerRemoteDataSource;

  AddTravelerRepository({required this.addTravelerRemoteDataSource});


}
