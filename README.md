# MushiMushi
MushiMushi is a voice application. A voice application is similar to a web 
application but deals with VoIP instead of websites.

MushiMushi is written in Ruby and uses the [Adhearsion](https://adhearsion.com) framework.

It is essentially a clean rewrite of the spaghetti mess that [Oysterisk](https://github.com/coaxial/oysterisk) has become.

MushiMushi is running on FreeSWITCH but because Adhearsion is multi-platform, it
will also likely run on Asterisk with some config tweaks in 
`config/adhearsion.rb`.

# Features
## Local DIDs
### Filtering calls
### Missed calls notifications

## PSTN Callback
### Busy tone to avoid billing
### ACL with Caller ID
### Password

## Email to Fax
### PDF, images, text

## Call recording to email

## User accounts

## Notifications
### Telegram
### Whatsapp
### SMS
