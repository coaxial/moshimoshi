[![Code
Climate](https://codeclimate.com/github/Coaxial/moshimoshi/badges/gpa.svg)](https://codeclimate.com/github/Coaxial/moshimoshi)
[![Test
Coverage](https://codeclimate.com/github/Coaxial/moshimoshi/badges/coverage.svg)](https://codeclimate.com/github/Coaxial/moshimoshi/coverage)

# MoshiMoshi

MoshiMoshi is a voice application. A voice application is similar to a web application but deals with VoIP and voice
instead of websites and webpages.

MoshiMoshi is written in Ruby and uses the [Adhearsion](https://adhearsion.com) framework.

It is essentially a clean rewrite of the spaghetti mess that [Oysterisk](https://github.com/coaxial/oysterisk) has
become.

MoshiMoshi is running on FreeSWITCH but because Adhearsion is multi-platform, it will also likely run on Asterisk with
some config tweaks in `config/adhearsion.rb` and throughout the app (dialstring formats come to mind).

# Getting started

## Requirements

You should have a running Docker and fig/docker-compose set up. For a detailed installation guide, please refer to the
[official Docker installation instructions](https://docs.docker.com/installation/#installation).  You should also have
an account with a VoIP provider to be able to receive and make calls.

## Secrets

Every username and password used in the FreeSWITCH config files is fetched from
`lib/freeswitch_conf/hosts/secrets.xml`. The `secrets.example.xml` can be used as a template.

Adhearsion environment variables also need to be set in `lib/ahn/.env`. The provided `.env.example` file should be
used as a template.

## Starting MoshiMoshi

`git clone https://github.com/Coaxial/moshimoshi.git`

`fig up -d && fig logs`

boot2docker users should know that the [startup script included in
MoshiMoshi](https://github.com/Coaxial/moshimoshi/blob/master/lib/freeswitch_conf/start.sh) checks whether the app is
running in a b2d virtual machine. If that's the case, IPs are set accordingly for FreeSWITCH to work.

# Features

## Outbound Calling

### Call recording to email

To record an outgoing call, press `*7` at any time during the call. A beep will play (audible only to the caller, i.e.
the party who initiated the call) and the recording will start.

Once the call is hung up, the recording is uploaded to the cloud (Amazon S3) and an email is sent with the link to
download it. Recordings are kept on S3 for 9 months, after which they are deleted.

## Local DIDs

### Filtering calls

### Missed calls notifications


## PSTN Callback

### Busy tone to avoid billing

### ACL with Caller ID

### Password


## Email to Fax

### PDF, images, text


## User accounts


## Notifications

### Telegram

### Whatsapp

### SMS
