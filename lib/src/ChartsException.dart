class ChartsException implements Exception
{
    final String message;

    ChartsException(this.message);

    @override
    String toString() 
    => message;
}
