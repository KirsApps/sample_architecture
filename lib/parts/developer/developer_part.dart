import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:de_log/de_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_architecture/code_kit/de_log/de_log_kit.dart';
import 'package:sample_architecture/parts/environment/cubit/environment_cubit.dart';
import 'package:sample_architecture/root/root.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stream_transform/stream_transform.dart';

part 'bloc/developer_log_bloc.dart';
part 'bloc/developer_log_event.dart';
part 'bloc/developer_log_state.dart';
part 'models/pagination_log_loader.dart';
part 'models/renderable_record.dart';
part 'screens/environment_manage.dart';
part 'screens/log_screen.dart';
part 'widgets/app_version_info.dart';
part 'widgets/developer_log_builder.dart';
