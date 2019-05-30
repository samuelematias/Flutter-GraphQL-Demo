import 'package:meta/meta.dart';

class GitHubRepoModel {
  final String repoName;
  final String creationDate;
  final String forkCount;

  GitHubRepoModel({
    @required this.repoName,
    @required this.creationDate,
    @required this.forkCount,
  });
}
