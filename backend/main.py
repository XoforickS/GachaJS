from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from database import SessionLocal, engine
from models import Base, Card, User, AccountCard

Base.metadata.create_all(bind=engine)

app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:8000",
    "http://localhost:8080",
    "http://127.0.0.1:5173",
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

@app.get("/")
def read_root():
    return {"message": "Bienvenue sur l'API du Gacha!"}

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

    account_cards = db.query(AccountCard).filter(AccountCard.id_user == user_id).all()
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