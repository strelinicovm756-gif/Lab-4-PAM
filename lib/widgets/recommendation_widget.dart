import 'package:flutter/material.dart';
import '../list_items/recommendation_item.dart';
import '../resources/strings.dart';
import '../pages/news_detail_page.dart';

class RecommendationWidget extends StatelessWidget {
  final RecommendationItem item;

  const RecommendationWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(article: item.article),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
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
            // Header - Logo, sursă, dată, buton follow
            Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  // Logo sursă
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildLogo(),  // ← Metodă separată
                  ),
                  SizedBox(width: 12),
                  // Info sursă
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.article.source,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            if (item.article.isVerified) ...[
                              SizedBox(width: 4),
                              Icon(Icons.verified, size: 16, color: Colors.blue),
                            ],
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          item.article.date,
                          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  // Buton follow
                  if (item.showFollowButton)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0x12131414),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        Strings.follow,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  SizedBox(width: 8),
                  Icon(Icons.more_vert, size: 22, color: Colors.grey[600]),
                ],
              ),
            ),
            // Titlu articol
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                item.article.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Badge categorie
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xffF9FCFE),
                  border: Border.all(color: Color(0xFF2ABAFF), width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.article.category,
                  style: TextStyle(
                    color: Color(0xFF2ABAFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              child: _buildImage(),  // ← Metodă nouă cu suport network
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    // Verifică dacă e URL (începe cu http)
    final bool isNetworkLogo = item.article.logoUrl.startsWith('http');

    if (isNetworkLogo) {
      return Image.network(
        item.article.logoUrl,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 40,
            height: 40,
            color: Colors.grey[300],
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildLogoFallback();
        },
      );
    } else {
      return Image.asset(
        item.article.logoUrl,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildLogoFallback();
        },
      );
    }
  }

  Widget _buildLogoFallback() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          item.article.source.isNotEmpty ? item.article.source[0] : 'N',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    // Verifică dacă e URL (începe cu http)
    final bool isNetworkImage = item.article.imageUrl.startsWith('http');

    if (isNetworkImage) {
      // Imagine de pe internet
      return Image.network(
        item.article.imageUrl,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            // Încărcat complet
            return child;
          }
          // În timpul încărcării - arată progress
          return Container(
            height: 220,
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Loading image...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return _buildImagePlaceholder();
        },
      );
    } else {
      // Imagine locală din assets
      return Image.asset(
        item.article.imageUrl,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildImagePlaceholder();
        },
      );
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 220,
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 60, color: Colors.grey[400]),
            SizedBox(height: 8),
            Text(
              'Image not available',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}