#!/bin/bash
source env/bin/activate
#gunicorn -b :5000 --access-logfile - --error-logfile - wsgi:app
poetry show --tree
exec gunicorn cfehome.wsgi:application --bind 0.0.0.0:$PORT
