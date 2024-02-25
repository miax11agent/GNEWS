import os
from fastapi import FastAPI
from src.env import config

MODE=config("MODE", default="test")

app = FastAPI()  # La aplicación debe llamarse app 

@app.get("/")   # Decorador para el metodo GET HTTP
def home_page():
    return {"Hello":"World", "MODE":MODE}   # Json-dumps
