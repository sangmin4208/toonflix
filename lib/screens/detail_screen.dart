import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_tail_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.webtoon});

  final Webtoon webtoon;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late final SharedPreferences prefs;
  late bool isFavorite;
  @override
  void initState() {
    super.initState();
    isFavorite = false;
    initPref();
    webtoon = ApiService.getToonById(widget.webtoon.id);
    episodes = ApiService.getLatestEpisodesById(widget.webtoon.id);
  }

  void initPref() async {
    prefs = await SharedPreferences.getInstance();
    final favoriteWebtoons = prefs.getStringList('favoriteWebtoons') ?? [];
    isFavorite = favoriteWebtoons.contains(widget.webtoon.id);
    setState(() {});
  }

  onEpisodesClick(String episodeId) async {
    final String webtoonId = widget.webtoon.id;
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=$episodeId");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, webOnlyWindowName: '_blank');
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          title:
              Text(widget.webtoon.title, style: const TextStyle(fontSize: 24)),
          actions: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () async {
                final favoriteWebtoons =
                    prefs.getStringList('favoriteWebtoons') ?? [];
                if (isFavorite) {
                  favoriteWebtoons.remove(widget.webtoon.id);
                } else {
                  favoriteWebtoons.add(widget.webtoon.id);
                }
                prefs.setStringList('favoriteWebtoons', favoriteWebtoons);
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ]),
      body: SingleChildScrollView(
        primary: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.webtoon.id,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 3,
                              offset: const Offset(5, 5),
                              spreadRadius: 0.1,
                            ),
                          ],
                        ),
                        child: Image.network(
                          widget.webtoon.thumb,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final WebtoonDetailModel webtoonDetail =
                        snapshot.data as WebtoonDetailModel;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            webtoonDetail.title,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          webtoonDetail.about,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${webtoonDetail.genre} / ${webtoonDetail.age}',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<WebtoonEpisodeModel> episodes =
                        snapshot.data as List<WebtoonEpisodeModel>;
                    return ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: episodes.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            onEpisodesClick(episodes[index].id);
                          },
                          child: ListTile(
                            mouseCursor: SystemMouseCursors.click,
                            title: Text(episodes[index].title),
                            subtitle: Text(episodes[index].date),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
