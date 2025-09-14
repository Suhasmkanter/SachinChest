FROM python:3.11-slim

WORKDIR /app

# Copy inner tb_detect folder contents into /app
COPY tb_detect/tb_detect/ .

# Copy requirements.txt from inner folder
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip setuptools wheel setuptools_scm
RUN pip install --prefer-binary -r requirements.txt

CMD ["python", "app.py"]
