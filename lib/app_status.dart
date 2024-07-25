
enum AppStatus{
  Loading,
  Failure ,
  Success ,
  pure ,
}


extension conditionalHandler on AppStatus {
  bool  get isLoading => this == AppStatus.Loading ;
  bool  get isFailure => this == AppStatus.Failure ;
  bool  get isSuccess => this == AppStatus.Success ;
  bool  get isPure => this == AppStatus.pure ;
}