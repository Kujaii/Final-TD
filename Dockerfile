# 1. Image de base (Imposée)
FROM python:3.11-slim-bookworm

# 2. Sécurité : Création de l'utilisateur avant de copier les fichiers
RUN useradd -m -r appuser

WORKDIR /app

# 3. Optimisation du CACHE (Point 1.4)
# On copie UNIQUEMENT le fichier des dépendances d'abord
COPY requirements.txt .

# 4. Optimisation TAILLE (Point 1.3)
# Utilisation de --no-cache-dir pour ne pas stocker les fichiers d'installation
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copie du reste du code
# Note : C'est ici que le .dockerignore (créé à part) agira pour exclure Scripts/ et test_app.py
COPY . .

# 6. Sécurité : Gestion des permissions
RUN chown -R appuser:appuser /app

# 7. Sécurité : Passage en utilisateur non-root (Point 1.4)
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
