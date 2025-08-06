# Use Python base image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y python3-tk

# Copy requirements and install pip dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy project files (make sure sslcommerz_lib/ exists)
COPY . /app/

# Copy and set permissions for entrypoint script
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Expose the port Django runs on
EXPOSE 8000

# Set default command
CMD ["/app/entrypoint.sh"]

