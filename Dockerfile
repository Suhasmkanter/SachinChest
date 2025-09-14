FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy the inner tb_detect folder contents into /app
COPY tb_detect/tb_detect/ .  

# Upgrade pip and setuptools
RUN pip install --upgrade pip setuptools wheel setuptools_scm

# Install dependencies from requirements.txt
COPY requirements.txt .   # make sure this points to the file in root
RUN pip install --prefer-binary -r requirements.txt

# Command to run your app
CMD ["python", "app.py"]
