import 'package:cadetbank/presentation/cubits/pokemon_cubit.dart';
import 'package:cadetbank/presentation/cubits/pokemon_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:cadetbank/core/res/values/dimens.dart';
import 'package:cadetbank/core/res/values/strings.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/back_button.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/pokemon_card.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/register_text_field.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/pokemon_names.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _searchController = TextEditingController();

  final LayerLink _layerLink = LayerLink();
  final GlobalKey _searchFieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  String name = 'Search for a Pokemon...';
  List<String> types = [];
  String spriteUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png';
  bool isLoading = false;
  List<String> suggestions = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final q = _searchController.text.trim();
    if (q.isEmpty) {
      setState(() => suggestions = []);
      _removeOverlay();
      return;
    }

    final ql = q.toLowerCase();
    final matches = pokemonNames
        .where((p) => p.toLowerCase().contains(ql))
        .take(8)
        .toList();

    setState(() => suggestions = matches);

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

  void fetchPokemon(String query) {
    if (query.isEmpty) return;
    
    _removeOverlay();
    FocusScope.of(context).unfocus();
    
    context.read<PokemonCubit>().search(query.toLowerCase().trim());
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _removeOverlay();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
        child: BlocListener<PokemonCubit, PokemonState>(
          listener: (context, state) {
            if (state is PokemonLoading) {
              setState(() => isLoading = true);
            } else if (state is PokemonLoaded) {
              if (state.pokemonList.isNotEmpty) {
                final pokemon = state.pokemonList.first;
                setState(() {
                  name = pokemon.name!.toUpperCase();
                  spriteUrl = pokemon.spriteUrl!;
                  types = pokemon.types;
                  isLoading = false;
                });
              }
            } else if (state is PokemonError) {
              setState(() => isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pokemon not found!'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.s20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.black,
                        ),
                        children: [TextSpan(text: Strings.pokepedia)],
                      ),
                    ),
                    const SizedBox(height: Dimens.s20),

                    // --- SEARCH SECTION ---
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: CompositedTransformTarget(
                              link: _layerLink,
                              child: Container(
                                key: _searchFieldKey,
                                child: RegisterTextField(
                                  controller: _searchController,
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
                                onPressed: () => fetchPokemon(_searchController.text),
                                icon: isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    : const Icon(Icons.search, size: 20, color: Colors.black87),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimens.s20),

                    PokemonCard(
                      pokemonName: name,
                      types: types,
                      spriteUrl: spriteUrl,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(Dimens.s20), child: BackButtonSearch()));
}