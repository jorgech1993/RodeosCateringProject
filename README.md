# RodeosCateringProject
Group Names/ Red ID's: 
/******************* NAMES *******************/
Omid Azodi (816736590))
& 
Jorge Chavez (815864498)

Project: CS 646- iOS iPhone & iPad mobile development
Professor: Dr. Whitney
Due Date: 12/20/2018
/******************* NAMES *******************/

/******************* DESCRIPTION *******************/
Project Description:
Catering application for Rodeo's. The mobile application will have the following criteria:

- Work for portrait mode iPhone 8 only
- Create a user account
- Allow users to login (or register for a new account)
- Display catering menu (which contains Meats & Juice's)
- Allow users to add corresponding menu items to a cart
- User has ability to checkout (which would send a confirmation order to both Rodeo's & the user themselves, via email.
- The email sent will be formatted neatly containing a receipt of the order including total price (tax, catering fee, etc.)
- Application will carry out a tab where there will be communication between the owner and the customer

Interesting features to look for:
- When logging in as owner notice that when pressing 'Contact Us' it takes you to a
  page with the list of all users created and can chat with any of them. And when logging in
  with a regular user and pressing 'Contact Us' it takes you straight to the chat page
  
  - When pressing just 'Menu' from the home page notice how it takes you to 
     the meats page and the cart functionality is gone, as well as the juice page being the final
     page the user can access. This is because we want anyone who has the application
     to freely be able to just look through the menu and what it has to offer, without any functionality or having
     to create an account
     
- When pressing 'Place order' it takes the user to a Login screen, or if they haven't created an account it can take them
to a register page. Once that is completed, it takes them to a slider page where they choose the number of guests. From there they continue to have add cart functionality and note there is error checking everywhere to ensure the correct amount of meats & juices are selected (utilizing both alerts & navigation titles to indicate how many must be chosen for the number of guests being catered to). From there, the user enters in their contact info. (Note how here we don't ask for City and State, because the caterer is for San Diego area only.) In order to partially validate this page we do the following. Make sure none of the fields are empty, and second compare the zip code entered to ALL san diego region zip codes, and if it doesn't match an Alert will popup notifying the user that this caterer is for San Diego only. Once all requirements are met it takes the user to an Order Info page where we NEATLY display a receipt and order info about everything that is included with this service and what they have ordered along with the personal info. The user then can press CONFIRM ORDER, and this will PROMPT them to an MAIL APP (if it exists on the iphone). NOTE: at this point the simulators are not able to prompt the mail app. (We tested this on a device (we had an iphone 5s which suffices just enough to see the button on the page and able to test core functionalities.) We added many checks to ensure and notify to the user what has happened when they order and press send on the email, or if they press Cancel, or if they save as draft, etc. When the user has sent the email then we take them back to the home screen and essentially log them out.

- When pressing the 'Contact Us' page the user is taken to a login page and then straight to a chat page where they can communicate with the owner in this case RODEO's. Note how if the owner is logged in and clicks it the user name of the person it shows like text message apps the user name on the top. We also added alignment and color coding of texts. 
/******************* DESCRIPTION *******************/

/******************* SPECIAL INSTRUCTIONS *******************/
When opening the zip file traverse all the way to the 
RodeosCateringProject/RodeosCateringProject and make sure you can see the 'podfile' inside the current directory. Open terminal and traverse to the same path mentioned above.

Then run the command 
'pod install' 

Once completed open up the RodeosCateringProject.xcworkspace file in xCode
Change iPhone target to iPhone 8 
Press PLAY and all should be built (There is no linking or direct paths to files or images)
That should be it, and use application.

Orientation: Our app is targeted for portrait mode iPhone 8

Some account infos to know:

In the app when pressing 'Contact Us' or 'Place Order' in the Login page use the following info for owner:
ID: RODEOSCATERING2018@GMAIL.COM
PASS: 12345678

Some users we have created (feel free to make your own)
ID: OMID@EMAIL.com  
PASS: 12345678

ID: JORGE@EMAIL.com
PASS: 12345678

The actual GMAIL account used (So you can see the email being sent for order confirmation (IF you are able to try this out on a decent size iphone, or you can just always enter your own email if you use the iPhone mail app and you will receive a copy of it to)

/******************* SPECIAL INSTRUCTIONS *******************/

/******************* THIRD PARTY LIBRARIES *******************/

We used Firebase and the specific libraries being:
Firebase
FirebaseAuth
FirebaseDatabase

This should already be as part of the pod install and everything already linked (since you are opening the .xcworkspace too)
Here is a link on where we got started if needed:
 https://firebase.google.com/docs/ios/setup

/******************* THIRD PARTY LIBRARIES *******************/

/******************* KNOWN ISSUES*******************/
The only known "issue" we have is we made the date picker have all dates, so essentially the user
can just put an older date than the current, (but to essentially aid with this we have the user going to a CONFIRMATION ORDER INFO page right after, and they should essentially stop it there and go back and change)
/******************* KNOWN ISSUES*******************/


/******************* THANK YOU*******************/
Thanks for an awesome semester, enjoy your winter break, (don't get to hungry looking at our app)

Best,
Omid & Jorge
/******************* THANK YOU*******************/
