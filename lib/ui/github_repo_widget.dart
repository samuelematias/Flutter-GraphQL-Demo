import 'package:flutter/material.dart';
import 'package:graph_ql_poc/blocs/github_repo_bloc.dart';
import 'package:graph_ql_poc/view_models/github_repo_model.dart';
import 'package:provider/provider.dart';

class GitHubRepoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<GitHubRepoBLoC>(context).repoList,
      builder: (context, repoSnapshot) {
        if (!repoSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final list = repoSnapshot.data as List<GitHubRepoModel>;

        return ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                list[index].repoName,
              ),
              subtitle: Text(
                list[index].creationDate,
              ),
              trailing: Text(
                list[index].forkCount,
                textAlign: TextAlign.center,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 1,
              color: Colors.grey,
            );
          },
        );
      },
    );
  }
}
