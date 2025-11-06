FROM python:3.11-slim
WORKDIR /app

# instala deps
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# copia código
COPY . /app

# puerto estándar para CF Containers
ENV PORT=8080
EXPOSE 8080

# arranque uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]