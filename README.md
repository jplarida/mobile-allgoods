# allgoodsmangud Mobile Repository

the app is all about a multi tenant application (for now are the FF: LPG store, laundry shop, water refilling station, medical supply provider)

the app has 3 types of users. (client, admin, super admin) will all the resources needed for each type of users downloaded when the app is used? if yes, is there a way that if the user is a client, only client resources are downloaded, if admin, then client and admin resources are downloaded and if super admin, then that is the time that all resource.

 - client form should be created as a dynamic forms.
 - admin and super admin will be defined later.

dont give codes yet. I will notify you when to give codes. just wanted to lay the topic clearly
    

1st step.

once the app is downloaded and installed into a device, it should have a light weight local database that it can connect to.

2nd step.
once the app is open, it should start a splash screen that will display the app name and will last 5 second before loading a registration page or login page.

	-registration page is loaded when there is no users yet in the local database, after a successful registration, main page will be loaded. 
	-login page is loaded when there is at least 1 user in the local database. if there are more than 1 user, they will get a form username and pin, else it will just be a pin. once a successful login, main page will be loaded.
	
3rd step. 
main page is loaded, it will have a toolbar on top (mainly for main app functions). if there is no client listings on the database yet, it will do http request to get the list and store it into the local database
the client list in the database will then be displayed into the client listings on the main page.

