import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';
abstract class NetworkInfo {
  Future<bool> get isConnected; 
}
class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connection;

  NetworkInfoImpl({@required this.connection});
  @override
  
  Future<bool> get isConnected => connection.hasConnection;
  
}