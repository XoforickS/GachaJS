from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session, joinedload

from database import SessionLocal, engine
from models import Base, Card, User, AccountCard, UserCard
from pydantic import BaseModel
from typing import Union

Base.metadata.create_all(bind=engine)

app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:8000",
    "http://localhost:8080",
    "http://localhost:5173",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
        
class UpgradeCardStats(BaseModel):
    attack_upgrade: Union[int, None] = None
    defense_upgrade: Union[int, None] = None
    speed_upgrade: Union[int, None] = None

@app.get("/")
def read_root():
    return {"message": "Bienvenue sur l'API du Gacha!"}

@app.post("/register/")
def register(username: str, email: str, password: str, db: Session = Depends(get_db)):
    new_user = User(username=username, email=email, password=password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@app.post("/login/")
def login(username: str, password: str, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.username == username, User.password == password).first()
    if user is None:
        raise HTTPException(status_code=401, detail="Invalid credentials")

    return {"message": "Login successful", "user_id": user.id, "username": user.username, "email": user.email}

@app.get("/cards/")
def get_all_cards(db: Session = Depends(get_db)):
    cards = db.query(Card).all()
    return cards

@app.get("/cards/{card_id}")
def get_card(card_id: int, db: Session = Depends(get_db)):
    card = db.query(Card).filter(Card.id == card_id).first()

    if card is None:
        raise HTTPException(status_code=404, detail="Card not found")

    return card

@app.get("/account_cards/{user_id}")
def get_user_account_cards(user_id: int, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.id == user_id).first()

    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")

    account_cards = (
        db.query(AccountCard)
        .filter(AccountCard.id_user == user_id)
        .options(joinedload(AccountCard.card))
        .all()
    )

    return account_cards

@app.post("/account_cards/add")
def add_account_card(user_id: int, card_id: int, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.id == user_id).first()
    db_card = db.query(Card).filter(Card.id == card_id).first()

    if db_user is None or db_card is None:
        raise HTTPException(status_code=404, detail="User or card not found")

    account_card = AccountCard(id_user=user_id, id_card=card_id)
    db.add(account_card)
    db.commit()
    db.refresh(account_card)

    return account_card

@app.get("/users/{user_id}")
def get_user(user_id: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()

    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    return user

@app.get("/users")
def get_all_users(db: Session = Depends(get_db)):
    users = db.query(User).all()
    return users

@app.put("/users/update-xp/{user_id}")
def update_user_xp(user_id: int, xp: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()

    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    user.xp = xp
    db.commit()

    return {"message": "XP updated successfully"}

@app.put("/users/update-level/{user_id}")
def update_user_level(user_id: int, level: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()

    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    user.level = level
    db.commit()

    return {"message": "Level updated successfully"}

@app.get("/user_cards/{user_id}/{card_id}")
def get_user_card_stats(user_id: int, card_id: int, db: Session = Depends(get_db)):
    user_card = (
        db.query(UserCard)
        .filter(UserCard.user_id == user_id, UserCard.card_id == card_id)
        .first()
    )

    if user_card is None:
        raise HTTPException(status_code=404, detail="User card not found")

    return {
        "user_id": user_card.user_id,
        "card_id": user_card.card_id,
        "attack_upgrade": user_card.attack_upgrade,
        "defense_upgrade": user_card.defense_upgrade,
        "speed_upgrade": user_card.speed_upgrade,
    }

@app.put("/user_cards/upgrade/{user_id}/{card_id}")
def upgrade_card_stats(user_id: int, card_id: int, upgrade_data: UpgradeCardStats, db: Session = Depends(get_db)):
    user_card = (
        db.query(UserCard)
        .filter(UserCard.user_id == user_id, UserCard.card_id == card_id)
        .first()
    )

    if user_card is None:
        raise HTTPException(status_code=404, detail="User card not found")

    if upgrade_data.attack_upgrade:
        user_card.attack_upgrade = upgrade_data.attack_upgrade
    if upgrade_data.defense_upgrade is not None:
        user_card.defense_upgrade = upgrade_data.defense_upgrade
    if upgrade_data.speed_upgrade is not None:
        user_card.speed_upgrade = upgrade_data.speed_upgrade

    db.commit()

    return {"message": "User card stats upgraded successfully"}