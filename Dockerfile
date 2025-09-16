# Use Python slim image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Copy your backend code into the container
COPY tb_detect/tb_detect/ ./tb_detect/

# Copy the model file explicitly into the container root
COPY tb_detect/tb_detect/tb_model.h5 ./tb_model.h5

# Copy requirements.txt into the container
COPY requirements.txt .

# Upgrade pip and essential build tools
RUN pip install --upgrade pip setuptools wheel setuptools_scm

# Install dependencies
RUN pip install --prefer-binary -r requirements.txt

# Expose the port
EXPOSE 5000

# Run your app
CMD ["python", "tb_detect/app.py"]
