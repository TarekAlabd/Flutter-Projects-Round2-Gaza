import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view_models/address_cubit/address_cubit.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      body: BlocBuilder<AddressCubit, AddressState>(
        bloc: addressCubit,
        buildWhen: (previous, current) =>
            current is AddressesLoaded ||
            current is AddressesError ||
            current is AddressesLoading,
        builder: (context, state) {
          if (state is AddressesLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is AddressesError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AddressesLoaded) {
            final addresses = state.addresses;
            // if (addresses.isEmpty) {
            //   return const Center(
            //     child: Text('No addresses found'),
            //   );
            // }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose your location!',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Select your location to proceed with the order',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.grey,
                          ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: 'Address like this: City-Country',
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        prefixIconColor: AppColors.grey,
                        suffixIcon: BlocConsumer<AddressCubit, AddressState>(
                          bloc: addressCubit,
                          listenWhen: (previous, current) =>
                              current is AddingAddressError ||
                              current is AddressConfirmed,
                          listener: (context, state) {
                            if (state is AddingAddressError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            } else if (state is AddressConfirmed) {
                              Navigator.of(context).pop();
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is AddingAddressError ||
                              current is AddressAdding ||
                              current is AddressAdded,
                          builder: (context, state) {
                            if (state is AddressAdding) {
                              return const CircularProgressIndicator.adaptive();
                            }
                            return IconButton(
                              onPressed: () async => await addressCubit
                                  .addAddress(_addressController.text)
                                  .then(
                                (value) {
                                  _addressController.clear();
                                },
                              ),
                              icon: const Icon(
                                Icons.add,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Select location!',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    if (addresses.isEmpty)
                      const Center(
                        child: Text('No locations found!'),
                      ),
                    ListView.builder(
                      itemCount: addresses.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final address = addresses[index];

                        return BlocBuilder<AddressCubit, AddressState>(
                          bloc: addressCubit,
                          buildWhen: (previous, current) =>
                              current is AddressSelected,
                          builder: (context, selectedState) {
                            if (selectedState is AddressSelected) {
                              final selectedAddress = selectedState.address;

                              return InkWell(
                                onTap: () => addressCubit.selectItem(address),
                                child: Card(
                                  shape: selectedAddress?.id == address.id
                                      ? RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          side: const BorderSide(
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              address.city,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${address.city}, ${address.country}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.grey,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: address.imgUrl,
                                            fit: BoxFit.cover,
                                            height: 70,
                                            width: 70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<AddressCubit, AddressState>(
                      bloc: addressCubit,
                      buildWhen: (previous, current) =>
                          current is AddressConfirmed ||
                          current is ConfirmingAddress ||
                          current is ConfirmingAddressError,
                      builder: (context, state) {
                        if (state is ConfirmingAddress) {
                          return const MainButton(
                            isLoading: true,
                          );
                        }
                        return MainButton(
                          label: 'Confirm Address',
                          onPressed: addresses.isEmpty
                              ? null
                              : () async => await addressCubit.confirmAddress(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
