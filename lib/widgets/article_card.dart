import 'package:flutter/material.dart';

import '../models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          return isTablet
              ? WideCard(article: article)
              : TallCard(article: article);
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final isPortrait =
  //       MediaQuery.of(context).orientation == Orientation.portrait;
  //   return Card(
  //     margin: const EdgeInsets.all(16),
  //     elevation: 4,
  //     child:
  //         isPortrait
  //           ? TallCard(article: article)
  //           : WideCard(article: article),
  //   );
  // }
}

class TallCard extends StatelessWidget {
  const TallCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CardBanner(imageUr1: article.urlToImage),
        CardDetail(article: article),
      ],
    );
  }
}

class WideCard extends StatelessWidget {
  const WideCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CardBanner(
          imageUr1: article.urlToImage,
          isWideCard: true,
        ),
        Expanded(
          child: CardDetail(article: article),
        ),
      ],
    );
  }
}

class CardBanner extends StatelessWidget {
  final String? imageUr1;
  final bool isWideCard;

  const CardBanner({Key? key, this.imageUr1, this.isWideCard = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          child: SizedBox(
            height: isWideCard ? 150 : 200,
            width: isWideCard ? 150 : double.infinity,
            child: Image.network(
              imageUr1!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        Positioned(
          top: isWideCard ? 2 : 10,
          right: isWideCard ? 2 : 10,
          child: IconButton(
            icon: const Icon(Icons.bookmark_border, size: 32),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class CardDetail extends StatelessWidget {
  final Article? article;

  const CardDetail({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      height: isPortrait ? 130 : 150,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            article!.title,
            style: Theme.of(context).textTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: <Widget>[
              Text(article!.source),
              const Spacer(),
              const Text('45 Comments'),
            ],
          )
        ],
      ),
    );
  }
}
