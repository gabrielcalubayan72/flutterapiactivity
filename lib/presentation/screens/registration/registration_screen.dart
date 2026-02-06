import 'package:flutter/material.dart';
import 'package:cadetbank/core/res/values/dimens.dart';
import 'package:cadetbank/presentation/cubits/pokemon_cubit.dart';
import 'package:cadetbank/presentation/cubits/pokemon_state.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/pokemon_card.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/register_text_field.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/pokemon_names.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/search_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // 1. Logic Controllers
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();

  // Overlay helpers so dropdown floats above everything
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _searchFieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  // 2. State Variables (Initial Data)
  String name = 'Search for a Pokemon...';
  List<String> types = [];
  String spriteUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png';
  bool isLoading = false;
  List<String> suggestions = [];
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final q = _searchController.text.trim();
    if (q.isEmpty) {
      setState(() {
        suggestions = [];
        showSuggestions = false;
      });
      _removeOverlay();
      return;
    }

    final ql = q.toLowerCase();
    final matches = pokemonNames
        .where((p) => p.toLowerCase().contains(ql))
        .take(8)
        .toList();

    setState(() {
      suggestions = matches;
      showSuggestions = matches.isNotEmpty;
    });

    if (matches.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

    void _showOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
      return;
    }

    final renderBox = _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
    final width = renderBox?.size.width ?? MediaQuery.of(context).size.width - 40;
    final offsetY = renderBox?.size.height ?? 56.0;

    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        width: width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, offsetY + 8),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(Dimens.s12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: suggestions.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final v = suggestions[i];
                  return ListTile(
                    title: Text(v),
                    onTap: () {
                      _searchController.text = v;
                      _searchController.selection = TextSelection.collapsed(offset: v.length);
                      FocusScope.of(context).unfocus();
                      _removeOverlay();
                      fetchPokemon(v);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // 3. The API Function
  Future<void> fetchPokemon(String query) async {
    if (query.isEmpty) return;

    setState(() => isLoading = true);

    try {
      // PokeAPI is case-sensitive (needs lowercase)
      final cleanQuery = query.toLowerCase().trim();
      final response =
          await _dio.get('https://pokeapi.co/api/v2/pokemon/$cleanQuery');

              Expanded(
                child: BlocBuilder<PokemonCubit, PokemonState>(
                  builder: (context, state) {
                    if (state is PokemonLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is PokemonError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _removeOverlay();
    _searchController.dispose(); // Good practice to prevent memory leaks
    super.dispose();
  }

                      return ListView.separated(
                        itemCount: state.pokemonList.length,
                        padding: const EdgeInsets.only(bottom: Dimens.s20),
                        separatorBuilder: (_, __) => const SizedBox(height: 40),
                        itemBuilder: (context, index) {
                          final pokemon = state.pokemonList[index];
                          
                          return PokemonCard(
                            pokemonName: pokemon.name,
                            spriteUrl: pokemon.spriteUrl,
                            types: pokemon.types,
                          );
                        },
                      );
                    }

                  // --- SEARCH SECTION ---
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Expanded(
                        //   child: RegisterTextField(
                        //     controller: _searchController, // Now this works!
                        //     keyboardType: TextInputType.name,
                        //     hintText: Strings.search,
                        //   ),
                        // ),
                        Expanded(
                          child: CompositedTransformTarget(
                            link: _layerLink,
                            child: Container(
                              key: _searchFieldKey,
                              child: RegisterTextField(
                                controller: _searchController, // Now this works!
                                keyboardType: TextInputType.name,
                                hintText: Strings.search,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimens.s10),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(Dimens.s12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: IconButton(
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                              // onPressed: () {
                              //   setState(() => showSuggestions = false);
                              //   FocusScope.of(context).unfocus();
                              //   fetchPokemon(_searchController.text);
                              // },
                              onPressed: () {
                                _removeOverlay();
                                FocusScope.of(context).unfocus();
                                fetchPokemon(_searchController.text);
                              },
                              icon: isLoading
                                  ? const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    )
                                  : const Icon(Icons.search,
                                      size: 20, color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: Dimens.s20),

                  // // Suggestions dropdown
                  // if (showSuggestions) ...[
                  //   const SizedBox(height: Dimens.s8),
                  //   Container(
                  //     constraints: const BoxConstraints(maxHeight: 220),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(Dimens.s12),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             color: Colors.black12,
                  //             blurRadius: 8,
                  //             offset: Offset(0, 2))
                  //       ],
                  //       border: Border.all(color: Colors.grey.shade300),
                  //     ),
                  //     child: ListView.separated(
                  //       padding: EdgeInsets.zero,
                  //       shrinkWrap: true,
                  //       itemCount: suggestions.length,
                  //       separatorBuilder: (_, __) => Divider(height: 1),
                  //       itemBuilder: (context, i) {
                  //         final v = suggestions[i];
                  //         return ListTile(
                  //           title: Text(v),
                  //           onTap: () {
                  //             _searchController.text = v;
                  //             _searchController.selection = TextSelection.collapsed(offset: v.length);
                  //             setState(() => showSuggestions = false);
                  //             FocusScope.of(context).unfocus();
                  //             fetchPokemon(v);
                  //           },
                  //         );
                  //       },
                  //     ),
                  //   ),
                  //   const SizedBox(height: Dimens.s20),
                  // ] else
                  //   const SizedBox(height: Dimens.s20),
                  const SizedBox(height: Dimens.s20),


                  // 4. THE CARD (Updates when API returns data)
                  PokemonCard(
                    pokemonName: name,
                    types: types,
                    spriteUrl: spriteUrl,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 