// providers.dart

import 'package:amazone_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider<dynamic>> appProviders = [
  ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
];
