# Safe Husky

## Introduction
* An application that allows the user to report incident, crimes, or any difficult/dangerous situation that other people would like to avoid.
* As the user is walking around the campus, for example, and sees a dangerous situation he can immediately report it using text, pictures. The app tracks the location and create a report. Other users who have the app will be able to sees all the reported incidents/accidents. 
* Also if a user wanted to walk or go to a place in the area, he can check if anything was reported in that area.

## Authentication & Database

### Login & Authentication
* Firebase : User Authentication along with Google|GoogleSignIn

### Data Storage: 
* Firebase : Realtime database

### Pods
* GoogleSignIn
* Firebase
* Firebase/Auth
* Firebase/Phone

## Features 
### Emergency Call
* When you or another person nearby find yourselves in a situation where your personal safety is threatened or you are hurt or injured, tap the police button to call University Police.

### Help Call
* When you or another person nearby needs medical assistance, tap First Aid to be connected to the Response Team*. 
(At a University, this will normally be a member of the Campus Security team non-emergency services)

### Diagnostics Screen
* In this view you can see the a diagnostics overview of your phone and its connectivity.
  * Bluetooth Enabled / Disable
  * Cellular / Wifi & Speed
  * Battery %
  * Notifications
* Pods
  * CoreBluetooth
  * CoreMotion
  * AlamofireNetworkActivityIndicator
  * GaugeKit
 
### Reporting
* Report it using text, pictures. The app tracks the location and create a report. Other users who have the app will be able to sees all the reported incidents/accidents.
* Pods
  * Eureka
  * Google Maps
  * Firebase/Storage
  * Firebase/Database
  * Firebase
  * Image Row
* Users will be able to see a list of all the reported incidents
* A detailed view of all the incidents will be visible.
* The users will also be able to individually view the recorded incidents on a Google Map  











