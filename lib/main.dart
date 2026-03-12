import 'package:flutter/material.dart';
import 'app.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>(),
        ),
      ],
      child: const SparkApp(),
    ),
  );
}
