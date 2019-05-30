import 'package:graph_ql_poc/models/github_repo_model.dart';
import 'package:graph_ql_poc/models/view_model/github_repo_model.dart';
import 'package:graph_ql_poc/providers/github_repo_provider.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class GitHubRepoBLoC {
  final repoList = BehaviorSubject<List<GitHubRepoModel>>();
  final _gitHubRepo = GitHubRepoProvider();

  GitHubRepoBLoC() {
    _getRepos()
        .then(toViewModel)
        .then((list) => repoList.value = list)
        .catchError((err) => print('Error getting repo $err'));
  }

  Future<List<GithubRepo>> _getRepos() {
    return _gitHubRepo.getCurrentUserRepos();
  }

  List<GitHubRepoModel> toViewModel(List<GithubRepo> dataModelList) {
    return dataModelList
        .map(
          (dataModel) =>
          GitHubRepoModel(
            repoName: dataModel.name,
            creationDate:
            'Created At: ${DateFormat('dd-MM-yyyy').format(
                dataModel.createdAt)}',
            forkCount: 'Fork Count:\n${dataModel.forkCount}',
          ),
    )
        .toList(growable: false);
  }

  void dispose() {
    repoList.close();
  }
}
