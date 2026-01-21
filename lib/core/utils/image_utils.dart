class ImageUtils {
  /// Check if URL is a network image or asset
  static bool isNetworkImage(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  /// Check if URL is an asset
  static bool isAssetImage(String url) {
    return url.startsWith('assets/');
  }

  /// Get image path (handles both network and local)
  static String getImagePath(String url) {
    // If already a full URL or asset path, return as is
    if (isNetworkImage(url) || isAssetImage(url)) {
      return url;
    }
    
    // Otherwise, assume it's an asset
    return 'assets/images/$url';
  }

  /// Convert asset filename to full path
  static String assetPath(String filename) {
    if (filename.startsWith('assets/')) {
      return filename;
    }
    return 'assets/images/$filename';
  }
}