FROM python:3.11-slim

WORKDIR /app
COPY . .

# Upgrade pip and setuptools
RUN pip install --upgrade pip setuptools wheel setuptools_scm

# Install dependencies with prebuilt wheels
RUN pip install --prefer-binary -r requirements.txt

CMD ["python", "tb_detect/tb_detect/app.py"]
