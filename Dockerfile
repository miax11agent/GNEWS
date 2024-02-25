#Qué versión e imagen de docker
FROM python:3.11.8-slim


# Qué código debemos llevar y documentos / ficheros
COPY ./src /app/
COPY requirements.txt /app/requirements.txt
WORKDIR /app/

# Instalaciones por defecto de linux para asegurarnos que tenemos todo lo que necesitamos

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    python3-dev \
    python3-setuptools \
    gcc \
    make


# Crear el virtual environment
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/python -m pip install pip --upgrade && \
    /opt/venv/bin/python -m pip install -r /app/requirements.txt
    

# Purgar lo que no usamos para hacer el contenedor más ligero
RUN apt-get remove -y --purge make gcc build-essential && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*


RUN chmod +x ./entrypoint.sh
# Ejecutar la aplicación, en nuestro caso este shell script

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]

#CMD ["./entrypoint.sh"]