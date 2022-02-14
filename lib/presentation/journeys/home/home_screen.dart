import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/bloc/areas_bloc/areas_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/project_status/project_status_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/projects/fetch_projects_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_section.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/top_projects_widget.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/loading_animation_widget.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

const productsGraphQL = """
  {
  products(first: 10, channel: "default-channel") {
    edges {
      node {
        id
        name
        
      }
    }
  }
}""";

class ProductEdge {
  final String id;
  final String edgeName;

  const ProductEdge({
    required this.id,
    required this.edgeName,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProjectStatusBloc _projectStatusBloc;
  late ProjectStatusBackdropBloc _backdropBloc;
  late AreasBloc _areasBloc;

  @override
  void initState() {
    super.initState();

    _projectStatusBloc = getItInstance<ProjectStatusBloc>();

    _projectStatusBloc.add(const LoadProjectStatusEvent());

    _backdropBloc = _projectStatusBloc.backdropBloc;

    _areasBloc = getItInstance<AreasBloc>();
    _areasBloc.add(LoadAreasEvent());
  }

  @override
  void dispose() {
    _backdropBloc.close();
    _areasBloc.close();
    _projectStatusBloc.close();
    super.dispose();
  }

  void ss() async {
    List<ProductEdge> productEdges;
    try {
      final HttpLink httpLink = HttpLink(
        'https://demo.saleor.io/graphql/',
      );
      GraphQLClient client = GraphQLClient(
        link: httpLink,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: InMemoryStore()),
      );
      final result =
          await client.query(QueryOptions(document: gql(productsGraphQL)));
      if (result.hasException) {
        if (result.exception?.graphqlErrors != null) {
          print("ExceptionGraphqlErrors: ${result.exception?.graphqlErrors}");
        }

        if (result.exception?.linkException != null) {
          print("ExceptionLinkException: ${result.exception?.linkException}");
        }
      } else {
        final myEdges = result.data!["products"]["edges"] as List<dynamic>;

        productEdges = [];
        productEdges = myEdges.map((edgeNode) => ProductEdge(
            id: edgeNode['node']['id'] as String,
            edgeName: edgeNode['node']['name'] as String)).toList();

        productEdges.forEach((element) {
          print("Id: ${element.id} , Name: ${element.edgeName} \n");
        });

       /* print("Result myEdges >> ${myEdges[0]['node']['name']}");
        print("Result productEdges >> $productEdges}");*/
      }
    } on Exception catch (e) {
      print("Exception >> $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    ss();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _projectStatusBloc,
        ),
        BlocProvider(create: (context) => _backdropBloc),
        BlocProvider(create: (context) => _areasBloc),
      ],
      child: BlocBuilder<ProjectStatusBloc, ProjectStatusState>(
        builder: (context, state) {
          /// TopProjectsLoading
          if (state is FetchProjectsLoading) {
            return const Center(
              child: LoadingAnimationWidget(),
            );
          }

          /// TopProjectsLoadedState
          else if (state is ProjectStatusLoadedState) {
            return Stack(
              fit: StackFit.expand,
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.6,
                  child: TopProjectWidget(
                    projectStausList:  state.projectStatus,
                    defaultIndex: state.defaultIndex,
                  ),
                ),

                /// AreaSectionWidget
                const FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 0.4,
                  child: AreaSectionWidget(),

                  // child: Placeholder(color: AppColor.royalBlue,),
                ),
              ],
            );
          }

          /// ErrorLoadingTopProjects
          else if (state is ErrorLoadingProjectStatus) {
            return Center(
              child: Text(
                  "Error: ${state.appError.appErrorType}, Message: ${state.appError.message}"),
            );
          }

          return const Center(child: Text("Else To Show"));
        },
      ),
    );
  }
}
