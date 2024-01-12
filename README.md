Une fois le projet cloné :

## Backend

```sh
cd backend
```

## Installation des pré-requis (PAS REFAIRE A CHAQUE LANCEMENT)

```sh
python.exe -m pip install --upgrade pip
```

```sh
pip install "uvicorn[standard]"
```

```sh
pip install fastapi[all] uvicorn sqlalchemy
```

```sh
pip install mysql-connector-python
```

### Developpement

```sh
uvicorn main:app --reload
```
Ajouter --reload pour re-actualiser quand on save  

## Frontend

Ouvrir un autre terminal que le backend : 

```sh
cd frontend
```

```sh
npm install
```

```sh
npm run dev
```

