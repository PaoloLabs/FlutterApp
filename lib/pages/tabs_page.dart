
import 'package:flutter/material.dart';
import 'package:flutter_news_apps/pages/tab_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navegacionModel.paginaActual,
      onTap: (index) => navegacionModel.paginaActual = index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Top'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.science),
          label: 'Science'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports),
          label: 'Sports'
        )
      ],
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.amber,
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: const [
        TabPage(), 
        TabPage(category: 'business'), // Categoría "Business que no estaba implementada"
        TabPage(category: 'science'), // Categoría "Science"
        TabPage(category: 'sports'),// Categoría "Sports"
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {

  int _paginaActual = 0;

  final PageController _pageController = PageController();

  int get paginaActual => this._paginaActual;

  PageController get pageController => this._pageController;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    this._pageController.animateToPage(
      valor, 
      duration: Duration(milliseconds: 200), 
      curve: Curves.easeInOut
    );
    notifyListeners();
  }

}