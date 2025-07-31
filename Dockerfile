FROM python:3.12-slim

WORKDIR /app

# Installa dipendenze di sistema necessarie per psycopg2
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


COPY . .

CMD ["flask", "run", "--host=0.0.0.0"]
