from sqlalchemy import Column, Integer, String, ForeignKey, Float
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class AccountCard(Base):
    __tablename__ = "account_cards"

    id = Column(Integer, primary_key=True, index=True)
    id_user = Column(Integer, ForeignKey("users.id"))
    id_card = Column(Integer, ForeignKey("cards.id"))
    
    card = relationship("Card", back_populates="account_card")

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, autoincrement=True)
    username = Column(String(25), nullable=False)
    email = Column(String(255), nullable=False)
    password = Column(Integer, nullable=False)
    xp = Column(Integer, nullable=False, default=0)
    level = Column(Integer, nullable=False, default=1)
    
class Card(Base):
    __tablename__ = "cards"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    image = Column(String)
    attack = Column(Integer)
    defense = Column(Integer)
    speed = Column(Integer)
    percentage_drop = Column(Float)
    
    account_card = relationship("AccountCard", back_populates="card")
    user_card = relationship("UserCard", back_populates="cardUser")
    
class UserCard(Base):
    __tablename__ = "user_cards"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    card_id = Column(Integer, ForeignKey("cards.id"))
    attack_upgrade = Column(Integer, default=0)
    defense_upgrade = Column(Integer, default=0)
    speed_upgrade = Column(Integer, default=0)

    cardUser = relationship("Card", back_populates="user_card")