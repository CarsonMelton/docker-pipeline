# ---- build stage ----
FROM python:3.12-slim AS builder
WORKDIR /app
ENV PIP_NO_CACHE_DIR=1 PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

# ---- runtime stage ----
FROM python:3.12-slim
WORKDIR /app
RUN useradd -u 10001 -m appuser
COPY --from=builder /install /usr/local
COPY app.py /app/app.py
EXPOSE 8080
USER appuser
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:8080", "app:app"]
