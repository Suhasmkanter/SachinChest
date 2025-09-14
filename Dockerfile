# Use Python 3.12 slim image
FROM python:3.12.6-slim

# Set working directory
WORKDIR /tb_detect/tb_detect

# Copy all your project files into the container
COPY . .

# Upgrade pip, setuptools, wheel
RUN pip install --upgrade pip setuptools wheel

# Install your requirements
RUN pip install -r requirements.txt

# Command to run your app (replace app.py with your main file)
CMD ["python", "tb_detect/tb_detect/app.py"]
