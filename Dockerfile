# Use an official Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy app code
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirement.txt

# Expose port Flask runs on
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
