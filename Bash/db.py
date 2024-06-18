from sqlalchemy import * 
import json
from sqlalchemy.orm import sessionmaker
from models import Base , Full_objet
import os



database_name = "banta"
user = "julien"
password = "pass"
database_URL=f"mysql+mysqlconnector://{user}:{password}@localhost:3306/{database_name}"


engine = create_engine(database_URL)


try:
     
    connexion = engine.connect()
    print("connexion a la bdd succes")
    Session = sessionmaker(bind=connexion)
    session = Session() #creation de l'instance session qui va nous permettre de stocker dans la bdd
    

except Exception as e :
     print(e)



#Base.metadata.create_all(bind=connexion) #creation des tables en fonction des models declarer dans models.py
# Base.metadata.drop_all(bind=engine)
Base.metadata.create_all(bind=engine)




def to_jsonify_object(objet):
    # Access the keys directly from the dictionary
    object_json = {
        'name': objet.get('name'),
        'language': objet.get('language'),
        'external_id': objet.get('id'),
        'bio': objet.get('bio'),
        'version': objet.get('version')
    }
    return object_json

# def to_jsonify_object(object):
#     object_json = {'name': data_list, 'language': data_list.language, 'external_id': data_list.external_id, 'bio': data_list.bio, 'version': data_list.version}
#     return object_json



with open('in/data.json', 'r') as file:
    data_list = json.load(file)

tab = []

for i in data_list:
    object = to_jsonify_object(i)
    tab.append(object)

os.makedirs("/home/molok/work/logs", exist_ok=True)
with open("/home/molok/work/logs/dataInsert.log", 'w') as file:
    for i in tab:
            
            name1 = i.get('name')
            language1 = i.get('language')
            external_id1 = i.get('external_id')
            bio1 = i.get('bio')
            version1 = i.get('version')

            existing_objet = session.query(Full_objet).filter_by(external_id=external_id1).first()
        
            if existing_objet :
                print("this id is aleady in bdd , update information in bdd")
                existing_objet.name = name1
                existing_objet.language = language1
                existing_objet.bio = bio1
                existing_objet.version = version1

            else :
                
                file.write(f"- {name1}\n")    

                object = Full_objet(name=name1,language=language1,external_id=external_id1,bio=bio1,version=version1)
                session.add(object)

session.commit() #ajoute les information a la session mais c local
session.close()
        
        
        
        
        
        
    
    