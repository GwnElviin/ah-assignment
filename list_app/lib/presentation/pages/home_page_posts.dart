import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_app/bloc/art_bloc.dart';
import 'package:list_app/data/repositories/posts_repository.dart';
import 'package:list_app/data/repositories/services/art_service.dart';
import 'package:list_app/presentation/pages/home_layout_posts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: const Text("AHrt Gallery"),
      ),
      // Attach the Bloc & Repo with provider (dependency injection)
      // Now children can acces states and Bloc events
      body: RepositoryProvider(
        create: (context) => ArtRepository(
          service: ArtService(),
        ),
        child: BlocProvider<ArtBloc>(
          create: (context) => ArtBloc(
            artObjectsRepository: context.read<ArtRepository>(),
          )..add(
              GetArtObjectsForList(),
            ),
          child: const HomeLayout(),
        ),
      ),
    );
  }
}
