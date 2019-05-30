import 'package:graph_ql_poc/data_models/github_repo_model.dart';
import 'package:graph_ql_poc/view_models/github_repo_model.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class GitHubRepoBLoC {
  final repoList = BehaviorSubject<List<GitHubRepoModel>>();
  final gitHubRepo;

  GitHubRepoBLoC({
    @required this.gitHubRepo,
  }) {
    getRepos()
        .then(toViewModel)
        .then(repoList.add)
        .catchError((err) => print('Error getting repo $err'));
  }

  Future<List<GithubRepo>> getRepos() {
    return gitHubRepo.getCurrentUserRepos();
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
