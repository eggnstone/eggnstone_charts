/// A generic formatter interface that defines a method to format a value of type T.
// ignore: one_member_abstracts
abstract class GenericFormatter<T>
{
    String format(T value);
}
