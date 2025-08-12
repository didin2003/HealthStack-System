#!/bin/sh

set -e  # Stop the script if any command fails

echo "Applying database migrations..."
python manage.py migrate

echo "Starting Django server..."
python manage.py runserver 0.0.0.0:8000
