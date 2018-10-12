# Next Train Home

Next Train Home is a small Ruby app built on [Sinatra](http://sinatrarb.com/) that shows the next few train departures from a chosen station to another chosen station.

SOAP communication with OpenLDBWS uses [Savon](http://savonrb.com/).

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## How to run locally

`ruby nth.rb`

## Environment variables

* `NRE_TOKEN`: a token obtained by [registering](http://realtime.nationalrail.co.uk/OpenLDBWSRegistration/) for National Rail Enquiries' OpenLDBWS.

## Data files

* `data/station_codes.csv`: a CSV list of all National Rail stations and their three-letter CRS codes, obtained from the [National Rail Enquiries website](http://www.nationalrail.co.uk/stations_destinations/48541.aspx).
