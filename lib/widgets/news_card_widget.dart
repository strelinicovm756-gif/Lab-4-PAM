import 'package:flutter/material.dart';
import '../list_items/news_card_item.dart';
import '../resources/app_colors.dart';
import '../pages/news_detail_page.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsCardItem item;

  const NewsCardWidget({super.key, required this.item});

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
        width: 240,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffF9FCFE),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack - Imagine + Badge categorie
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: _buildImage(),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(item.article.category),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.article.category,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titlu
                  Text(
                    item.article.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  // Row cu logo, sursă, dată
                  Row(
                    children: [
                      // ═══════════════════════════════════════════════
                      // LOGO - FIX AICI!
                      // ═══════════════════════════════════════════════
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _buildLogo(),  // ← Metodă nouă
                      ),
                      SizedBox(width: 6),
                      // Sursă
                      Expanded(
                        child: Text(
                          item.article.source,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Bifă verificat
                      if (item.article.isVerified)
                        Icon(Icons.verified, size: 14, color: Colors.blue),
                      SizedBox(width: 8),
                      // Dată
                      Text(
                        item.article.date,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BUILD LOGO - SUPORT LOCAL + NETWORK
  Widget _buildLogo() {
    // Verifică dacă e URL (începe cu http)
    final bool isNetworkLogo = item.article.logoUrl.startsWith('http');

    if (isNetworkLogo) {
      // Logo de pe internet
      return Image.network(
        item.article.logoUrl,
        width: 20,
        height: 20,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          // În timpul încărcării - spinner mic
          return Container(
            width: 20,
            height: 20,
            color: Colors.grey[300],
            child: Center(
              child: SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          // Eroare - fallback
          return _buildLogoFallback();
        },
      );
    } else {
      // Logo local din assets
      return Image.asset(
        item.article.logoUrl,
        width: 20,
        height: 20,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildLogoFallback();
        },
      );
    }
  }

  Widget _buildLogoFallback() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          item.article.source.isNotEmpty ? item.article.source[0] : 'N',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
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
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          // În timpul încărcării
          return Container(
            height: 150,
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    } else {
      // Imagine locală din assets
      return Image.asset(
        item.article.imageUrl,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 150,
      color: Colors.grey[200],
      child: Center(
        child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'environment':
        return AppColors.colorCyan;
      case 'technology':
        return AppColors.colorBlue;
      case 'business':
        return AppColors.colorOrange;
      case 'finance':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}