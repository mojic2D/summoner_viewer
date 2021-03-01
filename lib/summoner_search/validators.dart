abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class SummonerSearchTextValidator {
  final StringValidator summonerNameValidator = NonEmptyStringValidator();
  final String invalidSummonerNameErrorText = 'Summoner name can\'t be empty';
}