import 'package:url_launcher/url_launcher.dart';

void openLink(String url) async => await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
