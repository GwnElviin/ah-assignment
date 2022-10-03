import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_app/bloc/art_bloc.dart';
import 'package:list_app/data/repositories/posts_repository.dart';
import 'package:list_app/data/repositories/services/art_service.dart';
import 'package:list_app/presentation/widgets/error_widget.dart';

class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final String? postId;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ArtRepository(
        service: ArtService(),
      ),
      child: BlocProvider<ArtBloc>(
        create: (context) => ArtBloc(
          artObjectsRepository: context.read<ArtRepository>(),
        )..add(
            GetArtDetails(postId: postId ?? ''),
          ),
        child: BlocBuilder<ArtBloc, AllArtState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state.status.isSuccess) {
              return detailBody(state, context);
            } else {
              return const ErrorResultWidget();
            }
          },
        ),
      ),
    );
  }

  Scaffold detailBody(AllArtState state, BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('${state.artDetailsObject.title}'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.network(
                  fit: BoxFit.cover, '${state.artDetailsObject.image}'),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color.fromARGB(255, 233, 190, 34)),
                '${state.artDetailsObject.title}'),
            const SizedBox(
              height: 24,
            ),
            Text(
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                '${state.artDetailsObject.labelDesc} | ${state.artDetailsObject.type}'),
            const SizedBox(
              height: 16,
            ),
            Text('${state.artDetailsObject.description}'),
            ElevatedButton(
              onPressed: () {
                // Navigate back to first route when tapped.
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      )),
    );
  }
}
