import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jastipie_app/src/viewmodels/request_vm.dart';
import 'package:jastipie_app/src/widgets/request_card.dart';
import 'package:jastipie_app/app_router.dart';
import 'package:jastipie_app/src/models/request_model.dart';
import 'package:jastipie_app/theme.dart';

class RequestListPage extends StatelessWidget {
  const RequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestViewModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Daftar Request")),
        body: Consumer<RequestViewModel>(
          builder: (context, vm, child) {
            return StreamBuilder<List<RequestModel>>(
              stream: vm.requestsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Terjadi kesalahan: ${snapshot.error}"),
                  );
                }

                final requests = snapshot.data ?? [];

                if (requests.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.playlist_remove,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Belum ada request titipan.",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return RequestCard(
                      request: request,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRouter.requestDetailRoute,
                          arguments:
                              request, // Mengirim object request ke halaman detail
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouter.createRequestRoute);
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
