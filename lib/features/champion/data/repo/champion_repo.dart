import '../model/champion_player_model.dart';
import '../service/champion_service.dart';

class ChampionRepo {
  final ChampionService championService;

  ChampionRepo({required this.championService});

  Future<List<ChampionPlayerModel>> getTopThree() async {
    try {
      return await championService.fetchTopThree();
    } catch (e) {
      throw Exception("Failed to fetch top 3: $e");
    }
  }
}
