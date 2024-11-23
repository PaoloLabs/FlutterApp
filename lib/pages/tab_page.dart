import 'package:flutter/material.dart';
import 'package:flutter_news_apps/services/new_services.dart';
import 'package:flutter_news_apps/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class TabPage extends StatefulWidget {
  final String? category; // Categoría opcional para el tab

  const TabPage({Key? key, this.category}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // Cargar noticias según la categoría
    final newsService = Provider.of<NewsServices>(context, listen: false);
    newsService.getTopHeadlines(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Necesario para mantener el estado en tabs

    final newsService = Provider.of<NewsServices>(context);
    // Obtener las noticias de la categoría correspondiente
    final headlines = newsService.getHeadlinesByCategory(widget.category);

    return Scaffold(
      body: (headlines.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : ListaNoticias(headlines), // Mostrar las noticias
    );
  }

  @override
  bool get wantKeepAlive => true;
}