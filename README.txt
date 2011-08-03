Tr.ace() is a library for managing trace statements within AS3.

Tr.ace() is a static Class that uses the Singleton design pattern so you only need to define it's settings once within your application and you're all set.

With Tr.ace() you can manage all your output statements, restricting your applications traces to specific users and/or even specific Classes. Or you can toggle tracing off entirely.

The output using Tr.ace() can also be formatted with timestamps, linebreaks, the name of the user tracing, the Class the trace resides within and can be automatically copied to the clipboard.

For those using FlashDevelop you can prefix your username with "0:", "1:", "2:", "3:", or "4:" to trace in a different colour within the FlashDevelop output console, as shown with the 'FLASH_DEVELOP' usernam


The main functions are:


- Tr.ace(...)
- For managing standard trace statements


- Tr.aceArray(...)
- For formatting Arrays when traced


- Tr.aceObject(...)
- For formatting Objects when traced


- Tr.aceMulti(...)
- For formatting multiple arguments


Please view the docs for more information.

MSFX Matt Stuttard
http://msfx.co.uk