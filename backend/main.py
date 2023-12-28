from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session, joinedload

from database import SessionLocal, engine
from models import Base, Card, User, AccountCard, UserCard, Equipment, AccountEquipment
from pydantic import BaseModel
from typing import Union, List
from sqlalchemy import func, and_ 

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
    level: Union[int, None] = None
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

@app.get("/equipment/")
def get_all_equipment(db: Session = Depends(get_db)):
    equipment = db.query(Equipment).all()
    return equipment

@app.get("/equipment/{equipment_id}")
def get_equipment(equipment_id: int, db: Session = Depends(get_db)):
    equipment = db.query(Equipment).filter(Equipment.id == equipment_id).first()

    if equipment is None:
        raise HTTPException(status_code=404, detail="Equipment not found")

    return equipment

@app.post("/account_equipments/add")
def add_account_equipment(user_id: int, equipment_id: int, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.id == user_id).first()
    db_equipment = db.query(Equipment).filter(Equipment.id == equipment_id).first()

    if db_user is None or db_equipment is None:
        raise HTTPException(status_code=404, detail="User or equipment not found")

    account_equipment = AccountEquipment(id_user=user_id, id_equipment=equipment_id)
    db.add(account_equipment)
    db.commit()
    db.refresh(account_equipment)

    return account_equipment

@app.get("/account_equipments/{user_id}")
def get_user_account_equipments(user_id: int, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.id == user_id).first()

    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")

    account_equipments = (
        db.query(AccountEquipment)
        .filter(AccountEquipment.id_user == user_id)
        .options(joinedload(AccountEquipment.equipment))
        .all()
    )

    return account_equipments

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

@app.get("/user_cards/upgrades/{user_id}", response_model=List[dict])
def get_user_card_upgrades(user_id: int, db: Session = Depends(get_db)):
    upgrades = (
        db.query(UserCard)
        .filter(UserCard.user_id == user_id)
        .all()
    )

    return [{
        "user_id": upgrade.user_id,
        "card_id": upgrade.card_id,
        "attack_upgrade": upgrade.attack_upgrade,
        "defense_upgrade": upgrade.defense_upgrade,
        "speed_upgrade": upgrade.speed_upgrade,
    } for upgrade in upgrades]
    
@app.get("/account_cards/counts/{user_id}")
def get_account_card_counts(user_id: int, db: Session = Depends(get_db)):
    account_card_counts = (
        db.query(Card.id, func.count(AccountCard.id))
        .outerjoin(AccountCard, and_(Card.id == AccountCard.id_card, AccountCard.id_user == user_id))
        .group_by(Card.id)
        .all()
    )

    return [{"card_id": card_id, "count": count} for card_id, count in account_card_counts]

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

@app.put("/users/update-summon-stones/{user_id}")
def update_user_summon_stones(user_id: int, summon_stones: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()

    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    user.summon_stone = summon_stones
    db.commit()

    return {"message": "Summon stones updated successfully"}

@app.put("/users/update-coin/{user_id}")
def update_user_coin(user_id: int, coin: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()

    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    user.coin = coin
    db.commit()

    return {"message": "Coin updated successfully"}

@app.put("/users/update-equipment-stone/{user_id}")
def update_user_equipment_stone(user_id: int, equipment_stone: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()

    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    user.equipment_stone = equipment_stone
    db.commit()

    return {"message": "Equipment stone updated successfully"}

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
        "level": user_card.level,
        "attack_upgrade": user_card.attack_upgrade,
        "defense_upgrade": user_card.defense_upgrade,
        "speed_upgrade": user_card.speed_upgrade,
    }
    
@app.put("/user_cards/update-level/{user_id}/{card_id}", response_model=dict)
async def update_card_level(user_id: int, card_id: int, level: int, db: Session = Depends(get_db)):
    try:
        user_card = (
            db.query(UserCard)
            .filter(UserCard.user_id == user_id, UserCard.card_id == card_id)
            .first()
        )

        if user_card:
            user_card.level = level
            db.commit()

            return {"success": True, "message": "Card level updated successfully"}
        else:
            raise HTTPException(status_code=404, detail="User card not found")

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@app.post("/user_cards/upgrade/{user_id}/{card_id}")
def post_upgrade_card_stats(user_id: int, card_id: int, upgrade_data: UpgradeCardStats, db: Session = Depends(get_db)):
    user_card = (
        db.query(UserCard)
        .filter(UserCard.user_id == user_id, UserCard.card_id == card_id)
        .first()
    )

    if user_card is None:
        user_card = UserCard(user_id=user_id, card_id=card_id)
        db.add(user_card)
        db.commit()

    if upgrade_data.attack_upgrade:
        user_card.attack_upgrade = upgrade_data.attack_upgrade
    if upgrade_data.defense_upgrade is not None:
        user_card.defense_upgrade = upgrade_data.defense_upgrade
    if upgrade_data.speed_upgrade is not None:
        user_card.speed_upgrade = upgrade_data.speed_upgrade

    user_card.attack_upgrade = min(user_card.attack_upgrade, 100)
    user_card.defense_upgrade = min(user_card.defense_upgrade, 100)
    user_card.speed_upgrade = min(user_card.speed_upgrade, 100)

    db.commit()

    return {"message": "User card stats upgraded successfully"}

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