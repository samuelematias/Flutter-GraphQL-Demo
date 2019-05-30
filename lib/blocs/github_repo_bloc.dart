import 'package:graph_ql_poc/models/github_repo_model.dart';
import 'package:graph_ql_poc/network_utils/graphql_client.dart';
import 'package:graphql/client.dart';
import 'package:rxdart/rxdart.dart';

class GitHubRepoBLoC {
  final repoList = BehaviorSubject<List<GithubRepo>>();

  GitHubRepoBLoC() {
    _getRepos()
        .then(toGitHubRepo)
        .then((list) => repoList.value = list)
        .catchError((err) => print('Error getting repo $err'));
  }

  Future<QueryResult> _getRepos() {
    return getGraphQLClient().query(_queryOptions());
  }

  QueryOptions _queryOptions() {
    return QueryOptions(
      document: readRepositories,
      variables: <String, dynamic>{
        'nRepositories': 50,
      },
    );
  }

  List<GithubRepo> toGitHubRepo(QueryResult queryResult) {
    if (queryResult.hasErrors) {
      throw Exception();
    }

    final list =
        queryResult.data['viewer']['repositories']['nodes'] as List<dynamic>;

    print('Data from API: $list');

    return list
        .map((repoJson) => GithubRepo.fromJson(repoJson))
        .toList(growable: false);
  }

  void dispose() {
    repoList.close();
  }
}

const String readRepositories = r'''
  query ReadRepositories($nRepositories: Int!) {
    viewer {
      repositories(last: $nRepositories) {
        nodes {
          name
          createdAt
          forkCount
        }
      }
    }
  }
''';
