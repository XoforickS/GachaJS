![logo app](https://github.com/XoforickS/GachaJS/assets/89140908/7606adfe-5cfb-4fa6-b586-0abe7cb8b409)

## Sommaire
 ### Installer en local et tester l'application !
 
 - [Backend](#backend)
   - [Developpement](#developpement)
 - [Preview de l'application !](#preview)


### Compte de test à utiliser pour tester l'application rapidement !

```sh
CompteTest
1234
```

```sh
git clone https://github.com/XoforickS/GachaJS.git
```

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


## Preview

Page de Login/Register : 

![Login](https://github.com/XoforickS/GachaJS/assets/89140908/e58eea0a-dc6b-4d90-b409-e9ebad1c9cbd)

Menu :

![MainMenu](https://github.com/XoforickS/GachaJS/assets/89140908/75f1ce64-54d6-4184-ba24-fbdb11506cbb)

Page des invocations :

![Invocations](https://github.com/XoforickS/GachaJS/assets/89140908/a21707f0-c4f9-44dc-9c4f-69041b75da1b)

Catalogue :

![Catalogue](https://github.com/XoforickS/GachaJS/assets/89140908/c038488e-7b7a-4220-b7c3-e8ccabd56701)

Prévisualisation des cartes : 

![CardPreview](https://github.com/XoforickS/GachaJS/assets/89140908/038613bd-4220-4e61-83fe-cc799c149a1e)

### Combat

Map : 

![Map](https://github.com/XoforickS/GachaJS/assets/89140908/6416d099-99a9-4c06-95f8-6bdcc181cf76)

Pré-Combat : 

![PreviewFight](https://github.com/XoforickS/GachaJS/assets/89140908/2321aab7-b77d-4453-9822-4bda5798016c)

Combat :

![Fight](https://github.com/XoforickS/GachaJS/assets/89140908/102f5d12-6a9a-4ae3-8a71-a1ab975fe99b)
