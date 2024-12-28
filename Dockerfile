# Utiliser l'image de base python:3.6-alpine
FROM python:3.6-alpine

# Définir le répertoire de travail
WORKDIR /opt

# Copier les fichiers de l'application dans l'image
COPY . /opt

# Installer les dépendances (Flask)
RUN pip install Flask

# Exposer le port 8020
EXPOSE 8020

# Définir les variables d'environnement
ENV ODOO_URL=""
ENV PGADMIN_URL=""

# Lancer l'application
ENTRYPOINT ["python", "app.py"]
