import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../blocs/pet_list_bloc.dart';
import '../repositories/pet_repository.dart';
import '../models/pet.dart';
import 'details_page.dart';
import '../blocs/adoption_cubit.dart';
import '../blocs/favorites_cubit.dart';
import 'favorites_page.dart';
import 'history_page.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/home_grid_widget.dart';
import '../widgets/pet_card.dart';
import '../utils/responsive.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PetListBloc(petRepository: PetRepository())..add(FetchPets()),
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatefulWidget {
  const _HomePageView({super.key});

  @override
  State<_HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<_HomePageView> {
    final List<IconData> _iconList = [Icons.home, Icons.favorite];
   final List<String> _labels = ['Home', 'Favorites', 'History'];
   int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      final bloc = context.read<PetListBloc>();
      final state = bloc.state;
      if (state is PetListLoaded && state.pets.length < state.pets.length) {
        _isLoadingMore = true;
        bloc.add(LoadMorePets());
      }
    }
  }

  void _onSearchChanged() {
    context.read<PetListBloc>().add(SearchPets(_searchController.text));
  }

  Widget _buildHomeBody() {
    return BlocBuilder<PetListBloc, PetListState>(
      builder: (context, state) {
        if (state is PetListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PetListLoaded || state is PetListLoadingMore) {
          final pets = state is PetListLoaded
              ? state.pets
              : (state as PetListLoadingMore).pets;
          if (state is PetListLoaded) _isLoadingMore = false;
          if (pets.isEmpty) return const Center(child: Text('No dogs found.'));
          return HomeGridWidget(
            pets: pets,
            isLoadingMore: state is PetListLoadingMore,
            scrollController: _scrollController,
          );
        } else if (state is PetListError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final pages = [
      Column(
        children: [
          const TopBarWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width < 600 ? 20 : 60, vertical: width < 600 ? 8 : 16),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _onSearchChanged(),
              style: TextStyle(fontSize: responsiveValue(context, 16, 20)),
              decoration: InputDecoration(
                hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(fontSize: responsiveValue(context, 16, 20)),
                hintText: 'Search dogs by name...',
                prefixIcon: Icon(Icons.search, color: theme.iconTheme.color, size: responsiveValue(context, 22, 28)),
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor,
                border: theme.inputDecorationTheme.border,
                enabledBorder: theme.inputDecorationTheme.enabledBorder,
                focusedBorder: theme.inputDecorationTheme.focusedBorder,
                errorBorder: theme.inputDecorationTheme.errorBorder,
                contentPadding: theme.inputDecorationTheme.contentPadding,
              ),
            ),
          ),
          Expanded(child: _buildHomeBody()),
        ],
      ),
      const FavoritesPage(),
      const HistoryPage(),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(child: pages[_selectedTab]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => setState(() => _selectedTab = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}


