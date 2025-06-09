/// An exception class for handling errors in the charts library.
class ChartsUserException implements Exception
{
    final String message;

    ChartsUserException(this.message);

    @override
    String toString() 
    => message;
}
