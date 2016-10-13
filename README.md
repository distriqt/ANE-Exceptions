This extension was built by [distriqt //](http://airnativeextensions.com) 


![Exceptions](images/promo.png)


# Exceptions

Exceptions is an AIR Native Extension to enable a global exception handler for iOS and Android.

This will catch and store information about crashes of your application allowing you to process
them on the next application run. In using this extension you can report crashes and errors in 
your application to your own error logging server. 


### Features

- Catch exceptions 
- Process exceptions on startup 
- Single API interface - your code works across supported platforms with no modifications
- Sample project code and ASDocs reference



## Documentation

This extension is very simple in the implementation, having only 2 main functions.

To start catching exceptions you simply call `setUncaughtExceptionHandler()` at 
some point at the beginning of your application.

```as3
Exceptions.service.setUncaughtExceptionHandler();
```


To check if your application crashed previously you use the `hasPendingException()` function.

```as3
if (Exceptions.service.hasPendingException())
{
	var report:ExceptionReport = Exceptions.service.getPendingException();
	trace( "date: "+    new Date(report.timestamp).toLocaleString() );
	trace( "name: "+    report.name );
	trace( "reason: "+  report.reason );
	trace( "report: "+  report.report );
}
```

>
> ### Note
>
> You can generally only have **one** exception handler in an application.
> 
> So if you are using another library that tracks exceptions (Google Analytics or a bug tracker)
> then the functionality provided here may not work or may stop the library from working.
>
> You should decide which is the more important method and ensure only one method is used 
> in your application. 
>


## Native Extensions

The highest quality and widest range of Native Extensions for Adobe AIR

With many native extensions available, we are the largest provider of native extensions for AIR developers. 
Our mobile solutions allow developers to fast-forward development and focus on building great games and apps.

http://airnativeextensions.com



## Acknowledgements

This extension was made possible with support by [MovieStarPlanet](http://corporate.moviestarplanet.com/) 

![MovieStarPlanet](images/msp_logo.png)

