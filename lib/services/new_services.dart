
import 'package:flutter/material.dart';
import 'package:flutter_news_apps/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'newsapi.org';
final _HEAD_LINES = '/v2/top-headlines';
final _APIKEY = 'b10391596932442a87086436bb857ebc';
final _TOPKEY = 'top';

class NewsServices with ChangeNotifier{
  
  Map<String, List<Article>> _categorizedHeadlines = {};

  NewsServices();

  /// Función genérica para obtener noticias con parámetros dinámicos
  Future<void> getTopHeadlines({String? category}) async {
     // Construcción dinámica de la URL
    final queryParameters = {
      if (category != null) 'category': category,
      'country': 'us',
      'apiKey': _APIKEY    
    };

    final url = Uri.https(_URL_NEWS, _HEAD_LINES, queryParameters);    
    debugPrint("URL a consumir ${url}");
    
    try {
      final resp = await http.get(url);

      if (resp.statusCode == 200) {
        final newResponse = reqResListadoFromJson(resp.body);
        // Guarda las noticias en la categoría correspondiente
        final key = (category != null) ? category : _TOPKEY;
        _categorizedHeadlines[key] = newResponse.articles;
        notifyListeners(); // Notifica cambios
      } else {
        debugPrint('Error al cargar las noticias ${resp.statusCode}');
      }

    } catch (e) {
      debugPrint('Excepcion al cargar las noticias $e');
    }
  }

  List<Article> getHeadlinesByCategory(String? category) {
    // Devuelve la lista de noticias para la categoría específica o una lista vacía si no existe.
    final key = (category != null) ? category : _TOPKEY;
    return _categorizedHeadlines[key] ?? [];
  }
}