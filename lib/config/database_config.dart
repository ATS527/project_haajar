import 'package:appwrite/appwrite.dart';
import 'package:project_haajar/config/appwrite_config.dart';
import 'package:signals/signals.dart';

final databaseClient = signal(Databases(appwriteClient.value));
