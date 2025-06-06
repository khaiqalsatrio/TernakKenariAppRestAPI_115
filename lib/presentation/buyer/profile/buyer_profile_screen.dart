import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_115/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:project_115/presentation/buyer/widget/profile_buyer_form.dart';
import 'package:project_115/presentation/buyer/widget/profile_view_buyer.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Ambil profil pembeli saat halaman dimuat
    context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil Pembeli")),
      body: BlocListener<ProfileBuyerBloc, ProfileBuyerState>(
        listener: (context, state) {
          if (kDebugMode) {
            print("Current state: $state");
          }
          if (state is ProfileBuyerAdded) {
            // Refresh profil setelah tambah
            context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profil berhasil ditambahkan")),
            );
          }
        },
        child: BlocBuilder<ProfileBuyerBloc, ProfileBuyerState>(
          builder: (context, state) {
            if (state is ProfileBuyerLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ProfileBuyerLoaded &&
                state.profile.data?.name != null &&
                state.profile.data!.name!.isNotEmpty) {
              final profile = state.profile.data!;
              return ProfileViewBuyer(profile: profile);
            }

            // Default ke form jika tidak ada data atau error
            return ProfileBuyerInputForm();
          },
        ),
      ),
    );
  }
}
