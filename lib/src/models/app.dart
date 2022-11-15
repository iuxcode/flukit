/// FluAppAuthor
/// This class will be used informations about author.
class FluAppAuthor {
  /// first and last names of the author.
  final String firstName, lastName;

  /// email address of the author.
  final String email;

  /// website of the author.
  final String? websiteUrl;

  /// github account of the author.
  final String? githubUrl;

  const FluAppAuthor({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.websiteUrl,
    this.githubUrl,
  });

  String get fullName => '$firstName $lastName';
}

/// App informations.
/// This class is used to store the informations of the app.
/// [AppAuthors] is an list of all authors. if there is only one author, it will be used to display the author name.
/// [AppName] is the name of the app.
/// [AppVersion] is the version of the app.
class FluAppInformations {
  /// Application name.
  final String name;

  /// Application version.
  final String version;

  /// Application authors.
  final List<FluAppAuthor> authors;

  FluAppInformations({
    this.name = 'Flukit',
    this.version = '0.0.1',
    this.authors = [],
  }) {
    authors += const [
      FluAppAuthor(
        firstName: 'charlot',
        lastName: 'tabade',
        email: 'charlottabade.pro@gmail.com',
        websiteUrl: 'https://github.com/charles9904',
        githubUrl: 'https://github.com/charles9904',
      )
    ];
  }
}
