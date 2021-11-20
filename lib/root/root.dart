library root;

import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sample_architecture/parts/environment/cubit/environment_cubit.dart';

part 'app.dart';
part 'initializers/dio.dart';
part 'initializers/hive.dart';
part 'models/config.dart';
part 'models/dependency_container.dart';
part 'models/environment.dart';
part 'models/manager.dart';
part 'models/runner.dart';
