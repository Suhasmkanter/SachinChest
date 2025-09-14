# Use Python slim image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Copy your backend code into the container
COPY tb_detect/tb_detect/ ./tb_detect/

# Copy requirements.txt into the container
COPY requirements.txt .

# Upgrade pip and essential build tools
RUN pip install --upgrade pip setuptools wheel setuptools_scm

# Install dependencies
RUN pip install --prefer-binary -r requirements.txt

# Set environment variable for Python to find your app
ENV PYTHONPATH=/app/tb_detect

# Run your app
CMD ["python", "tb_detect/app.py"]
