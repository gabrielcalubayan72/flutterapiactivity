import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cadetbank/core/res/values/dimens.dart';
import 'package:cadetbank/core/res/values/strings.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/back_button.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/pokemon_card.dart';
import 'package:cadetbank/presentation/screens/registration/widgets/register_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // 1. Logic Controllers
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();

  // 2. State Variables (Initial Data)
  String name = 'Bulbasaur';
  List<String> types = ['Grass', 'Poison'];
  String spriteUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png';
  bool isLoading = false;

  // 3. The API Function
  Future<void> fetchPokemon(String query) async {
    if (query.isEmpty) return;

    setState(() => isLoading = true);

    try {
      // PokeAPI is case-sensitive (needs lowercase)
      final cleanQuery = query.toLowerCase().trim();
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon/$cleanQuery');

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          name = data['name'].toString().toUpperCase();
          spriteUrl = data['sprites']['front_default'] ?? '';
          types = (data['types'] as List)
              .map((t) => t['type']['name'].toString())
              .toList();
          isLoading = false;
        });
      }
    } on DioException catch (e) {
      setState(() => isLoading = false);
      String errorMsg = e.response?.statusCode == 404 
          ? "Pokemon not found!" 
          : "Check your internet connection";
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg), backgroundColor: Colors.redAccent),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose(); // Good practice to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
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
                      // Orbitron will apply from your global TextTheme
                    ),
                    children: [
                      TextSpan(text: Strings.pokepedia),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.s20),
                
                // --- SEARCH SECTION ---
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: RegisterTextField(
                          controller: _searchController, // Now this works!
                          keyboardType: TextInputType.name,
                          hintText: Strings.search,
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

                // 4. THE CARD (Updates when API returns data)
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
    bottomNavigationBar: const Padding(
      padding: EdgeInsets.all(Dimens.s20),
      child: BackButtonSearch()
    )
  );
}