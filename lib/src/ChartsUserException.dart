class ChartsUserException implements Exception
{
    final String message;

    ChartsUserException(this.message);

    @override
    String toString() 
    => message;
}
