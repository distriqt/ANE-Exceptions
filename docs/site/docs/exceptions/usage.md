---
title: Usage
sidebar_label: Usage
---

This extension is very simple in the implementation, having only 2 main functions.

To start catching exceptions you simply call `setUncaughtExceptionHandler()` at 
some point at the beginning of your application.

```actionscript
Exceptions.service.setUncaughtExceptionHandler();
```


To check if your application crashed previously you use the `hasPendingException()` function.

```actionscript
if (Exceptions.service.hasPendingException())
{
	var report:ExceptionReport = Exceptions.service.getPendingException();
	trace( "date: "+    new Date(report.timestamp).toLocaleString() );
	trace( "name: "+    report.name );
	trace( "reason: "+  report.reason );
	trace( "report: "+  report.report );
}
```

:::note 
You can generally only have **one** exception handler in an application.
 
So if you are using another library that tracks exceptions (Google Analytics or a bug tracker) then the functionality provided here may not work or may stop the library from working.

You should decide which is the more important method and ensure only one method is used in your application. 
:::
