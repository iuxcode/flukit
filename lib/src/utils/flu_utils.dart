import 'package:flukit/src/configs/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flukit/src/controllers/appController.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';
import 'package:timeago/timeago.dart' as tmago;
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart' as dio;
import 'package:emojis/emojis.dart';

import '../configs/theme/tweaks.dart';
import '../controllers/flu_controllers.dart';
import '../widgets/countrySelector.dart';
import '../widgets/flu_widgets.dart';

part './extensions/get.dart';

part './helpers/ui.dart';
part './helpers/core.dart';
part './helpers/text.dart';
part './helpers/countries.dart';

part './services/location.dart';
part './services/api.dart';
part './services/secure_storage.dart';

/// FlukitInterface allows any auxiliary package to be merged into the "Flukit"
/// class through extensions
abstract class FlukitInterface {}
class _FlukitImpl extends FlukitInterface {}

// ignore: non_constant_identifier_names
final FlukitInterface Flukit = _FlukitImpl();
