# Use the official Python base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY hostname_display.py .

# Set the port that the Flask app will listen on
EXPOSE 8080

# Set the command to run the Flask application
CMD [ "python", "hostname_display.py" ]
