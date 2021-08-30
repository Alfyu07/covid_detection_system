import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_detection_system/api/api.dart';
import 'package:covid_detection_system/models/models.dart';
import 'package:covid_detection_system/providers/correction_dialog_provider.dart';
import 'package:covid_detection_system/providers/providers.dart';
import 'package:covid_detection_system/shared/shared.dart';
import 'package:covid_detection_system/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

part 'sign_in_page.dart';
part 'main_page.dart';
part 'home_page.dart';
part 'detail_page.dart';
part 'setting_page.dart';
part 'preview_page.dart';
