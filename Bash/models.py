from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import * 


Base = declarative_base() #base que je vais utiliser pour realiser les differente operation comme insert drop etc

class Full_objet(Base):
    __tablename__ = 'full_object'
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(100), nullable=False)
    language = Column(String(50), nullable=False)
    external_id = Column(String(50), nullable=False)
    bio = Column(String(1000), nullable=False)
    version = Column(DECIMAL(4, 2), nullable=False)