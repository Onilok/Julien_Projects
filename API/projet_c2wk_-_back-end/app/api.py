from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from datetime import timedelta
from flask_cors import CORS
import json

HTTP_NOT_FOUND = 404
HTTP_UNAUTHORIZED = 401
HTTP_BAD_REQUEST = 400
HTTP_OK = 200

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://julien:pass@molok:3306/Bubble'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = 'tutu'
db = SQLAlchemy(app)
jwt = JWTManager(app)
CORS(app)




@jwt.expired_token_loader
def expired_token_callback(jwt_header, jwt_payload):
    return jsonify({'message': 'Token has expired,please Log in again'}), HTTP_UNAUTHORIZED

@jwt.unauthorized_loader
def unauthorized_callback(callback):
    return jsonify({'message': 'Missing token, please Log in !'}), HTTP_UNAUTHORIZED





class Users(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), nullable=False)
    password = db.Column(db.String(255), nullable=False)
    is_admin = db.Column(db.Boolean, default=False, nullable=False)

class Product(db.Model):
    __tablename__ = 'products'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    bubble_tea = db.Column(db.String(255), nullable=False)

def to_jsonify_product(product_object):
    product_json = {'id': product_object.id, 'user_id': product_object.user_id, 'bubble_tea': product_object.bubble_tea}
    return product_json

  

@app.route('/register', methods=['POST'])
def create_user():
    data = request.get_json()
    username = data.get('username')
    email = data.get('email')
    password = data.get('password')
    is_admin = data.get('is_admin')
    

   
    existing_user = Users.query.filter_by(email=email).first() #check bdd if user exist
    if existing_user:
        return jsonify({'message': 'Users already registed'}), HTTP_BAD_REQUEST

   
    hashed_password = generate_password_hash(password, method='pbkdf2:sha256')
    new_user = Users(username=username, email=email, password=hashed_password, is_admin=is_admin)
    db.session.add(new_user)
    db.session.commit()  #add new user in BDD

    return jsonify({'message': 'Users created'}), 201


@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    expires = timedelta(hours=4)

    user = Users.query.filter_by(email=email).first()

    if user is None:
        return jsonify({"message": "User not found"}), HTTP_UNAUTHORIZED

    if user and check_password_hash(user.password, password):
        access_token = create_access_token(identity=user.id, expires_delta=expires)
        return jsonify(access_token=access_token), HTTP_OK
    else:
        return jsonify({"message": " wrong password"}), HTTP_BAD_REQUEST




@app.route('/all_users', methods=['GET'])
def get_all_users():
    users = Users.query.all()
    users_list = []
    for user in users:
        users_list.append({'id': user.id, 'username': user.username, 'email': user.email})
    return jsonify(users_list)


@app.route('/users/<int:user_id>', methods=['GET'])
@jwt_required()
def get_user(user_id):
    user = Users.query.get(user_id)
    if user:
        return jsonify({'id': user.id, 'username': user.username, 'email': user.email, 'is_admin': user.is_admin}), HTTP_OK 
    else:
        return jsonify({'message': 'Users not found'}), HTTP_NOT_FOUND
    
@app.route('/user_update/<int:user_id>', methods=['PUT'])
@jwt_required()
def update_user(user_id):
    current_user_id = get_jwt_identity()
    user = Users.query.get(user_id)
    if current_user_id == user_id or user_id.is_admin:
        if user:
            data = request.get_json()

            if 'username' in data:
                user.username = data['username']

            if 'email' in data:
                email = data['email']

                existing_user = Users.query.filter_by(email=email).first()
                if existing_user and existing_user.email == email:
                    return jsonify({'message': 'email already assigned'}), HTTP_BAD_REQUEST


                user.email = email


            if 'password' in data:
                hashed_password = generate_password_hash(data['password'], method='pbkdf2:sha256')
                user.password = hashed_password
            
                
            db.session.commit()
            return jsonify({'message': 'Users update with succes'}), HTTP_OK 
        else:
            return jsonify({'message': 'Users not found'}), HTTP_NOT_FOUND
    else:
        return jsonify({'message': 'No right to update'}), 403

    
@app.route('/user_delete/<int:user_id>/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_user(user_id,id):
    current_user_id = get_jwt_identity()
    
    user1 = Users.query.get(user_id)
    if current_user_id == user_id or user1.is_admin == 1:
        user = Users.query.get(id)
        if user:
            Product.query.filter_by(user_id=id).delete()
            db.session.delete(user)
            db.session.commit()
            return jsonify({'message': 'Users delete with succes'}), HTTP_OK 
        else:
            return jsonify({'message': 'Users not found'}), HTTP_NOT_FOUND
    else:
        return jsonify({'message': 'No right to update'}), 403
    


#---------------------------------------Product
@app.route('/add_product_admin/<int:user_id>/<int:user_id_to_add>', methods=['POST'])
@jwt_required()
def add_product(user_id,user_id_to_add):
    current_user_id = get_jwt_identity()
    if current_user_id == user_id:
        user = Users.query.get(user_id)
        if user.is_admin == 1:
            try:
                data = request.get_json()
                new_product = Product(user_id=user_id_to_add, bubble_tea=data['bubble_tea'])
                db.session.add(new_product)
                db.session.commit()
                new_product  = to_jsonify_product(new_product)
                return jsonify({'message': 'Product added by admin'}), HTTP_OK
            except:
                return jsonify({'message': 'Error adding product'}), 500
        else:
            return jsonify({'message': 'no right to update'}), 500
    else:
            return jsonify({'message': 'token invalide log again'}), 500
    
@app.route('/update_product_admin/<int:user_id>/<int:id_product>', methods=['PUT'])
@jwt_required()
def update_product(user_id, id_product):
    current_user_id = get_jwt_identity()
    user = Users.query.get(user_id)
    
    if current_user_id == user_id or user.is_admin == 1:
        try:
            data = request.get_json()
            product = Product.query.get(id_product)
            product.bubble_tea = data['bubble_tea']
            db.session.commit()
            return jsonify({'message': 'Product updated by admin'}), HTTP_OK
        except Exception as e:
            return jsonify({'message': 'Error updating product'}), 500
    return jsonify({'message': 'Token invalid. Log in again or no right'}), 500



    
@app.route('/product_delete/<int:user_id>/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_product(user_id,id):
    current_user_id = get_jwt_identity()
    
    
    if current_user_id == user_id:
        user = Users.query.get(user_id)
        product = Product.query.filter_by(id=id).first()
        if product:
            if product.user_id == user.id:
                
                Product.query.filter_by(id=id).delete()
                db.session.commit()
                return jsonify({'message': 'Product delete with succes'}), HTTP_OK 
            else:
                return jsonify({'message': 'no right to delete'}), 403
        else:
             return jsonify({'message': 'product not found'}), HTTP_NOT_FOUND
    else:
        return jsonify({'message': 'token invalide log again'}), 403
    
@app.route('/product_delete_admin/<int:user_id>/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_product_admin(user_id,id):
    current_user_id = get_jwt_identity()
    
    
    if current_user_id == user_id:
        user = Users.query.get(user_id)
        if user.is_admin == 1:
            product = Product.query.filter_by(id=id).first()
            if product:
                Product.query.filter_by(id=id).delete()
                db.session.commit()
            else:
                return jsonify({'message': 'Product not found'}), HTTP_NOT_FOUND 
            return jsonify({'message': 'Product delete with succes'}), HTTP_OK 
        else:
            return jsonify({'message': 'no right to delete'}), HTTP_NOT_FOUND
    else:
        return jsonify({'message': 'token invalide log again'}), 403

@app.route('/all_products', methods=['GET'])
def get_all_products():
    products = Product.query.all()
    products_list = []
    for product in products:
         products_list.append({'id': product.id, 'user_id': product.user_id, 'bubble_tea': product.bubble_tea})
    return jsonify(products_list),HTTP_OK

  


@app.route('/one_product/<int:user_id>/<int:id>', methods=['GET'])
@jwt_required()
def get_one_product(user_id, id):
    
        current_user_id = get_jwt_identity()
        
        if current_user_id == user_id:
            user = Users.query.get(user_id)

            if user:
                product = Product.query.filter_by(id=id).first()
            
                if product:
                    product  = to_jsonify_product(product)
                    return jsonify(product), HTTP_OK
                else:
                    return jsonify({'message': 'Product not found'}), HTTP_NOT_FOUND
            else:
                return jsonify({'message': 'User not found'}), HTTP_NOT_FOUND
        else:
            return jsonify({'message': 'No right to get this information'}), 403
        
@app.route('/user_product/<int:user_id>', methods=['GET'])
@jwt_required()
def get_user_product(user_id):
    
        current_user_id = get_jwt_identity()
        
        if current_user_id == user_id:
            user = Users.query.get(user_id)

            if user:
                
                products = Product.query.filter_by(user_id=user_id).all()
            
                if products:
                    products_list = []
                    for product in products:
                        products_list.append({'id': product.id, 'user_id': product.user_id, 'bubble_tea': product.bubble_tea})
                    return jsonify(products_list),HTTP_OK
                else:
                    return jsonify({'message': 'Product not found'}), HTTP_NOT_FOUND
            else:
                return jsonify({'message': 'User not found'}), HTTP_NOT_FOUND
        else:
            return jsonify({'message': 'No right to get this information'}), 403

   

    

if __name__ == '__main__':
    with app.app_context():
        db.create_all() # create table if not exit, by model
    
      
        existing_user = Users.query.filter_by(email='juju@hotmail.com').first()
        
        
        if not existing_user:
            hashed_password = generate_password_hash("pass", method='pbkdf2:sha256')
            user = Users(username='juju', email='juju@hotmail.com', password=hashed_password)
            db.session.add(user)
            db.session.commit()

            produit = Product(user_id=user.id, bubble_tea='Bubble 1')
            db.session.add(produit)
            db.session.commit()
            
        existing_user = Users.query.filter_by(email='juju2@hotmail.com').first()   
        if not existing_user:

            hashed_password = generate_password_hash("pass", method='pbkdf2:sha256')
            user = Users(username='juju2', email='juju2@hotmail.com', password=hashed_password)
            db.session.add(user)
            db.session.commit()
            product = Product(user_id=user.id, bubble_tea='Bubble 2')
            db.session.add(product)
            db.session.commit()


            
    app.run(debug=True)
