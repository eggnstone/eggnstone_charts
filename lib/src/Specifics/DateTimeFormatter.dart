import 'package:intl/intl.dart';

import '../Generics/GenericFormatter.dart';

class DateTimeFormatter implements GenericFormatter<DateTime>
{
    final DateFormat dateTimeFormat;

    const DateTimeFormatter(this.dateTimeFormat);

    @override
    String format(dynamic value)
    {
        if (value is DateTime) 
        {
            return dateTimeFormat.format(value);
            //return '$value ${value.isUtc ? 'UTC' : 'not-utc'}\n' + dateTimeFormat.format(value);
        }

        return 'DateTimeFormatter ?';
    }
}
