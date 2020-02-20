class TeamDetail {
  String name;
  String time;

  TeamDetail({this.name, this.time});

  factory TeamDetail.fromJson(Map<dynamic, dynamic> parsedJson) {
    return TeamDetail(name: parsedJson['name'], time: parsedJson['time']);
  }
}

class TeamList {
  List<TeamDetail> teamData;
  TeamList({this.teamData});

  static List<TeamDetail> parseTeams(recipeJSON) {
    var teamList = recipeJSON['geeksout-buzzer'] as List;
    List<TeamDetail> recipeList =
        teamList.map((data) => TeamDetail.fromJson(data)).toList();
    return recipeList;
  }

  factory TeamList.fromJSON(Map<dynamic, dynamic> json) {
    return TeamList(teamData: parseTeams(json));
  }
}
