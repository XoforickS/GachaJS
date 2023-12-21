from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class AccountCard(Base):
    __tablename__ = "account_cards"

    id = Column(Integer, primary_key=True, index=True)
    id_user = Column(Integer)
    id_card = Column(Integer)

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, index=True)
    email = Column(String, unique=True, index=True)
    password = Column(Integer)
    
class Card(Base):
    __tablename__ = "cards"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    image = Column(String)
    attack = Column(Integer)
    defense = Column(Integer)
    speed = Column(Integer)
    