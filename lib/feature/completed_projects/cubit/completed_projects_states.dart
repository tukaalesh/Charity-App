abstract class CompletedProjectsStates {}

class CompletedProjectsInit extends CompletedProjectsStates {}

class CompletedProjectsLoading extends CompletedProjectsStates {}

class CompletedProjectsSuccess extends CompletedProjectsStates {
}

class CompletedProjectsError extends CompletedProjectsStates {
  final String message;
  CompletedProjectsError(this.message);
}
