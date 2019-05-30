import 'package:flutter/material.dart';
import 'package:graph_ql_poc/blocs/github_repo_bloc.dart';
import 'package:graph_ql_poc/ui/github_repo_widget.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQL Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('GraphQL Demo'),
        ),
        body: Provider<GitHubRepoBLoC>(
          builder: (_) => GitHubRepoBLoC(),
          dispose: (_, bloc) => bloc.dispose(),
          child: GitHubRepoWidget(),
        ),
      ),
    );
  }
}
