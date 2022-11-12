import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/disease.dart';
import 'package:covidia/models/models.dart';
import 'package:covidia/presentation/widgets/widgets.dart';
import 'package:covidia/providers/admin_provider.dart';
import 'package:covidia/providers/providers.dart';
import 'package:covidia/providers/saran_provider.dart';
import 'package:covidia/providers/sign_up_provider.dart';
import 'package:covidia/services/authentication_service.dart';
import 'package:covidia/shared/shared.dart';
import 'package:covidia/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

part 'authentication_wrapper.dart';
part 'user/detail_page.dart';
part 'user/details_disease.dart';
part 'user/home_page.dart';
part 'user/main_page.dart';
part 'user/preview_page.dart';
part 'user/reset_email_sent.dart';
part 'user/reset_password_page.dart';
part 'user/setting_page.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'user/zoom_page.dart';
part 'user/send_feedback_page.dart';
part 'user/change_password_page.dart';
part 'admin/admin_home_page.dart';
part 'admin/admin_manage_users_page.dart';
part 'admin/admin_feedback_management_page.dart';
part 'admin/admin_model_management_page.dart';
