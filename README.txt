# Tr.ace() is a library for formatting and managing trace statements within AS3.

Tr.ace() is a static Class that uses the Singleton design pattern so you only need to define it's settings once within your application and you're all set.

With Tr.ace() you can manage all your output statements, restricting or ignoring your applications traces to specific users and/or even specific Classes. Or you can toggle tracing off entirely.

The output using Tr.ace() can also be formatted with timestamps, linebreaks, the name of the user tracing, the Class the trace resides within and can be automatically copied to the clipboard.

The output can also be output to a textfield within your application to allow a "console" at runtime.  You can also output your Tr.ace(...) statements to a .txt file with the new save log functionality.

For those using FlashDevelop you can prefix your username with "0:", "1:", "2:", "3:", or "4:" to trace in a different colour within the FlashDevelop output console, as shown with the 'FLASH_DEVELOP' username

New in version 2.0 is the TrConsole allowing you to view your traces within a console within your live application.


The main functions are:


### Tr.ace(...)
For managing standard trace statements

### Tr.aceArray(...)
For formatting Arrays when traced

### Tr.aceObject(...)
For formatting Objects when traced

### Tr.aceMulti(...)
For formatting multiple arguments


[Please view the docs for more information](http://docs.msfx.co.uk/as3/trace/)

[MSFX Matt Stuttard Parker](http://msfx.co.uk)