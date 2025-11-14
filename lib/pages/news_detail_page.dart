import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/news_article.dart';
import '../domain/usecases/get_publisher_details_usecase.dart';
import '../domain/entities/publisher_details_entity.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsArticle article;

  const NewsDetailPage({super.key, required this.article});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isFollowing = false;
  bool isLoading = true;
  String? errorMessage;
  PublisherDetailsEntity? publisherDetails;

  @override
  void initState() {
    super.initState();
    _loadPublisherDetails();
  }

  Future<void> _loadPublisherDetails() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final useCase = Get.find<GetPublisherDetailsUseCase>();
      final details = await useCase.execute();

      setState(() {
        publisherDetails = details;
        isFollowing = details.publisher.isFollowing;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load publisher details: $e';
      });
      print('Error loading publisher details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              widget.article.source.toLowerCase().replaceAll(' ', ''),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),

          // Content
          if (isLoading)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Loading publisher details...',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            )
          else if (errorMessage != null)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _loadPublisherDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Publisher Header (Logo + Stats)
                  _buildPublisherHeader(),

                  // Follow Button
                  _buildFollowButton(),

                  // Publisher Info
                  _buildPublisherInfo(),

                  // "News by" Header
                  _buildNewsHeader(),

                  // Search Bar
                  _buildSearchBar(),

                  SizedBox(height: 12),

                  // ARTICOLUL SELECTAT (din pagina principală)
                  _buildSelectedArticleCard(),

                  // LISTA DE ARTICOLE (din API /feed/details)
                  if (publisherDetails != null)
                    ...publisherDetails!.articles.map((article) =>
                        _buildArticleCard(article)
                    ),

                  SizedBox(height: 20),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPublisherHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              // Logo articolului SELECTAT
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildLogo(
                  widget.article.logoUrl,
                  80,
                  publisherName: widget.article.source,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat(
                        publisherDetails?.publisher.stats.newsCount ?? '6.8k',
                        'News'
                    ),
                    _buildStat(
                        publisherDetails?.publisher.stats.followers ?? '2.5k',
                        'Followers'
                    ),
                    _buildStat(
                        publisherDetails?.publisher.stats.following.toString() ?? '100',
                        'Following'
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isFollowing = !isFollowing;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isFollowing ? Colors.grey[200] : Colors.black,
            foregroundColor: isFollowing ? Colors.black87 : Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            isFollowing ? 'Following' : 'Follow',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPublisherInfo() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.article.source,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              if (widget.article.isVerified) ...[
                SizedBox(width: 6),
                Icon(Icons.verified, size: 20, color: Colors.blue),
              ],
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Empowering your business journey with expert insights and influential perspectives.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'News by ${widget.article.source}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Sort by: ',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                publisherDetails?.activeSortOption ?? 'Newest',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xffF9FCFE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.search, size: 20, color: Colors.grey[600]),
            SizedBox(width: 12),
            Text(
              'Search "News"',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CARD PENTRU ARTICOLUL SELECTAT (din pagina principală)
  Widget _buildSelectedArticleCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffF9FCFE),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _buildLogo(
                  widget.article.logoUrl,
                  32,
                  publisherName: widget.article.source,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.article.source,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        if (widget.article.isVerified) ...[
                          SizedBox(width: 4),
                          Icon(Icons.verified, size: 14, color: Colors.blue),
                        ],
                      ],
                    ),
                    Text(
                      widget.article.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, size: 20),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 16),

          // Article Title
          Text(
            widget.article.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),

          // Category Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xffF9FCFE),
              border: Border.all(
                color: Color(0xFF2ABAFF),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.article.category,
              style: TextStyle(
                color: Color(0xFF2ABAFF),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 16),

          // Article Image (din articolul selectat)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildImage(widget.article.imageUrl),
          ),
        ],
      ),
    );
  }

  // CARD PENTRU ARTICOLELE DIN API /feed/details
  Widget _buildArticleCard(dynamic articleEntity) {
    // Determină logo-ul: folosește din API sau fallback la logo-ul publisher-ului
    String logoToUse = articleEntity.publisherIcon;

    // Dacă logo-ul lipsește din API, folosește logo-ul publisher-ului principal
    if (logoToUse.isEmpty && publisherDetails != null) {
      logoToUse = publisherDetails!.publisher.logo;
    }

    // Dacă și ăla lipsește, folosește logo-ul articolului selectat
    if (logoToUse.isEmpty) {
      logoToUse = widget.article.logoUrl;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffF9FCFE),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _buildLogo(
                  logoToUse,
                  32,
                  publisherName: articleEntity.publisher,  // ← IMPORTANT: Folosește publisher-ul din API
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          articleEntity.publisher,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        if (articleEntity.isVerified) ...[
                          SizedBox(width: 4),
                          Icon(Icons.verified, size: 14, color: Colors.blue),
                        ],
                      ],
                    ),
                    Text(
                      articleEntity.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, size: 20),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 16),

          // Article Title
          Text(
            articleEntity.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),

          // Category Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xffF9FCFE),
              border: Border.all(
                color: Color(0xFF2ABAFF),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              articleEntity.category,
              style: TextStyle(
                color: Color(0xFF2ABAFF),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 16),

          // Article Image (din API)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildImage(articleEntity.image),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(String logoUrl, double size, {String? publisherName}) {
    // Dacă logo-ul e gol, folosește fallback direct
    if (logoUrl.isEmpty) {
      return _buildLogoFallback(size, publisherName: publisherName);
    }

    final bool isNetworkLogo = logoUrl.startsWith('http');

    if (isNetworkLogo) {
      return Image.network(
        logoUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: size,
            height: size,
            color: Colors.grey[300],
            child: Center(
              child: SizedBox(
                width: size / 3,
                height: size / 3,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildLogoFallback(size, publisherName: publisherName);
        },
      );
    } else {
      return Image.asset(
        logoUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildLogoFallback(size, publisherName: publisherName);
        },
      );
    }
  }

  Widget _buildLogoFallback(double size, {String? publisherName}) {
    // Folosește publisherName dacă e disponibil, altfel widget.article.source
    String publisher = publisherName ?? widget.article.source;
    String firstLetter = publisher.isNotEmpty
        ? publisher[0].toUpperCase()
        : 'N';

    Color backgroundColor = Colors.black;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size > 50 ? 12 : 10),
      ),
      child: Center(
        child: Text(
          firstLetter,
          style: TextStyle(
            color: Colors.white,
            fontSize: size / 2.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    final bool isNetworkImage = imageUrl.startsWith('http');

    if (isNetworkImage) {
      return Image.network(
        imageUrl,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 220,
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildImagePlaceholder();
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildImagePlaceholder();
        },
      );
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 220,
      color: Colors.grey[200],
      child: Center(
        child: Icon(Icons.image, size: 60, color: Colors.grey[400]),
      ),
    );
  }
}