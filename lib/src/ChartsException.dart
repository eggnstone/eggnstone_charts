/// An exception class for handling errors in the charts library.
class ChartsException implements Exception
{
    final String message;

    ChartsException(this.message);

    @override
    String toString() 
    => message;
}
