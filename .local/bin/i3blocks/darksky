#!/usr/bin/env python

import os
import forecastio

def get_options():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option('-f', '--farenheit', dest='farenheit',
                      action='store_true', default=False,
                      help='Report degrees in Farenheit')
    parser.add_option('-c', '--celsius', dest='celsius',
                      action='store_true', default=False,
                      help='Report degrees in Celsius')
    parser.add_option('-k', '--api-key', dest='api_key',
                      action='store', help='Dark Sky API key')
    parser.add_option('-a', '--address', dest='address',
                      action='store', help='Your address')

    (options, args) = parser.parse_args()

    # Validate options
    if not options.api_key:
        raise RuntimeError('A Dark Sky API key is required. Go to darksky.net/dev')
    if options.farenheit and options.celsius:
        raise RuntimeError('Only one degree unit may be specified')

    return options

def get_ip_location():
    '''Get location as determined by IP address'''

    import requests
    import json

    send_url = 'http://ip-api.com/json'
    r = requests.get(send_url)
    j = json.loads(r.text)
    lat = j['lat']
    lon = j['lon']
    location = "{}, {}".format(j['city'], j['region'])
    return (lat, lon, location)

def get_addr_location(address):
    '''Get location from input string'''

    from geopy.geocoders import Nominatim
    geolocator = Nominatim(user_agent='i3blocks-weather')
    location = geolocator.geocode(address)
    return (location.latitude, location.longitude, address)

def convert_temp(options, temp):
    '''Convert temperature between units'''

    # Dark Sky output is in Farenheit.
    if options.celsius:
        temp = round((temp - 32) * 5/9)
    elif options.farenheit:
        temp = round(temp)
    else:
        raise RuntimeError('A degree unit must be specified')
    return temp

def get_current_forecast(options, forecast):
    '''Get the forecast from the Dark Sky API'''

    currently = forecast.currently()
    temp = convert_temp(options, currently.temperature)
    icon_str = currently.icon
    return (temp, icon_str)

def notify_forecast(location, daily_summary, hourly_summary):
    '''Send notification with detailed forecast'''

    import subprocess
    title = u"Weather - {}".format(location)
    message = u"Hourly Summary:\n{0}\n\n".format(hourly_summary)
    message += u"Daily Summary:\n{0}".format(daily_summary)
    subprocess.Popen(['notify-send', title, message])

def get_icon_hex(options, icon_str):
    ''' Returns the appropriate icons for current weather and unit indication
       All Hex Codes from https://erikflowers.github.io/weather-icons/'''

    # Hex codes for the "degrees F" or "degrees C" icons.
    if options.farenheit:
        degrees_hex = 'f045'
    elif options.celsius:
        degrees_hex = 'f03c'
    else:
        raise RuntimeError('A degree unit must be specified')

    # Hex codes for the icon which indicates the current weather.
    if icon_str == 'clear-day':
        icon_hex='f00d'
    elif icon_str == 'clear-night':
        icon_hex='f02e'
    elif icon_str == 'rain':
        icon_hex='f019'
    elif icon_str == 'snow':
        icon_hex='f01b'
    elif icon_str == 'sleet':
        icon_hex='f0b5'
    elif icon_str == 'wind':
        icon_hex='f050'
    elif icon_str == 'fog':
        icon_hex='f014'
    elif icon_str == 'cloudy':
        icon_hex='f013'
    elif icon_str == 'partly-cloudy-day':
        icon_hex = 'f002'
    elif icon_str == 'partly-cloudy-night':
        icon_hex = 'f083'
    elif icon_str == 'thunderstorm':
        icon_hex = 'f016'
    elif icon_str == 'hail':
        icon_hex = 'f015'
    elif icon_str == 'tornado':
        icon_hex = 'f056'
    else:
        icon_hex = 'f07b' # N/A
    return (degrees_hex, icon_hex)

def main ():
    # Parse command line arguments
    options = get_options()

    # Get user's location either from IP address or command line arguments
    if options.address:
        (lat, lon, location) = get_addr_location(options.address)
    else:
        (lat, lon, location) = get_ip_location()

    # Load the forecast from Dark Sky (aka forecastio)
    forecast = forecastio.load_forecast(options.api_key, lat, lon, units='us')
    (temp, icon_str) = get_current_forecast(options, forecast)

    # If the weather icon is pressed, this environment variable will be set.
    buttonPressed = os.environ.get('BLOCK_BUTTON', None)
    
    # Send a notification with a more detailed forecast
    if buttonPressed:
        notify_forecast(location, forecast.daily().summary, forecast.hourly().summary)

    # Translate icon & unit information into hex codes
    (degrees_hex, icon_hex) = get_icon_hex(options, icon_str)

    # i3blocks uses pango to render the following output into the desired icons
    print("<span font='Weather Icons'>&#x{0}; {1}&#x{2};</span>".format(icon_hex, temp, degrees_hex))

if __name__ == "__main__":
    main()
    
