from .extensions import db
from flask import render_template, redirect, url_for, flash, request,Blueprint,jsonify,make_response,session
from .models import User,Session, Assignment, Consultant, Achievement, Activity, Meeting
from flask_login import login_user, logout_user, current_user,login_required
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime, timedelta, date
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd



#routesa initten app geliyor 
main=Blueprint("main", __name__)

@main.route('/<int:user_id>')
@main.route('/home/<int:user_id>')
def home_page(user_id):
    render_template('home.html')

@main.route('/register', methods=['GET', 'POST'])
def register_page():

    data = request.get_json()
    unique_id=str(uuid.uuid4())
    if not data:
        return make_response("invalid content type",415)
    
    if User.query.filter_by(username=data["username"]).first():
        return jsonify(message="Bu kullanıcı adı zaten kullanılıyor."),409
    
    
    if User.query.filter_by(email_address=data["email_address"]).first():
        return jsonify(message="Bu email zaten kullanılıyor."),409
    
    hashed_password=generate_password_hash(data["password"])
    
    user_to_create = User(id=unique_id,
                        username=data['username'],
                          email_address=data['email_address'],
                          password_hash=hashed_password)  # Burada şifre hash'lenmelidir
     # Kullanıcıyı veritabanına ekle
    
    try:
        db.session.add(user_to_create)
        db.session.commit()
        return jsonify({"Message":"Success"})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'message': 'Kullanıcı kaydedilemedi.', 'error': str(e)}), 500
    # Başarılı kayıt için JSON cevabı döndür

@main.route('/login', methods=['GET', 'POST'])
def login_page():
    data=request.get_json()
    
    if not data:
        return make_response("invalid content type",415)
    
    user=User.query.filter_by(email_address=data["email_address"]).first()
    #kullanıcı adı bulunduysa
 
    if (user):    
        if check_password_hash(user.password_hash,data["password"]):
            session=create_session(user.id)
            return jsonify({"Message":"Success"})
        else:
            return jsonify(message="Şifreler uyuşmuyor"),406
    else:
        return jsonify(message="Başarısız"), 404
    

def create_session(user_id):
    new_session = Session(
        id=user_id,
        expires_at=datetime.utcnow() + timedelta(minutes=30),
        is_parent=True
    )
    db.session.add(new_session)
    db.session.commit()
    return new_session

def check_session_active(session_id):
    session = Session.query.get(session_id)
    if session and session.is_active:
        return True
    return False

            
@login_required
@main.route('/logout')
def logout_page():
    logout_user()
    flash("You have been logged out!", category='info')
    return redirect(url_for("home_page"))


@login_required
@main.route('/api/assignment', methods=['POST'])
def create_assignment():
    data = request.get_json()
    unique_id=str(uuid.uuid4())
    session=Session.query.first() 
    consultant = Consultant.query.filter_by(id=session.id).first() #Session id ile eşit id'si olan consultant alınır.

    new_assignment = Assignment(id=unique_id,
                        consultant_id=consultant.id,
                        subject_name=data["subject_name"],
                        objective=data["objective"],
                        #behaviour=data["behaviour"],
                        date=data["date"],
                        #time=data["time"])
    ) 
    db.session.add(new_assignment)
    db.session.commit()

  

    return jsonify({'message': 'new assignment created'}), 201







@main.route('/register/consultant', methods=['GET', 'POST'])
def register_page_consultant():

    data = request.get_json()
    unique_id=str(uuid.uuid4())
    if not data:
        return make_response("invalid content type",415)
    
    if Consultant.query.filter_by(name=data["name"]).first():
        return jsonify(message="Bu kullanıcı adı zaten kullanılıyor."),409
    
    
    hashed_password=generate_password_hash(data["password"])
    
    consultant_to_create = Consultant(id=unique_id,
                        name=data['name'],
                        password_hash=hashed_password)  # Burada şifre hash'lenmelidir
     # Kullanıcıyı veritabanına ekle
    
    try:
        db.session.add(consultant_to_create)
        db.session.commit()
        return jsonify({"Message":"Success"})
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'message': 'Kullanıcı kaydedilemedi.', 'error': str(e)}), 500
    # Başarılı kayıt için JSON cevabı döndür

@main.route('/login/consultant', methods=['GET', 'POST'])
def login_page_consultant():
    data=request.get_json()
    
    if not data:
        return make_response("invalid content type",415)
    
    consultant=Consultant.query.filter_by(name=data["name"]).first()
    #kullanıcı adı bulunduysa
 
    if (consultant):    
        if check_password_hash(consultant.password_hash,data["password"]):
            session=create_session(consultant.id)
            return jsonify({"Message":"Success"})
        else:
            return jsonify(message="Şifreler uyuşmuyor"),406
    else:
        return jsonify(message="Başarısız"), 404
    

def create_session(consultant_id):
    new_session = Session(
        id=consultant_id,
        expires_at=datetime.utcnow() + timedelta(minutes=30),
        is_parent=False
    )
    db.session.add(new_session)
    db.session.commit()
    return new_session

def check_session_active(session_id):
    session = Session.query.get(session_id)
    if session and session.is_active:
        return True
    return False


@main.route('/achievement', methods=['GET'])
def create_achievement():
    data=request.get_json()
    unique_id=str(uuid.uuid4())
    if not data:
        return make_response("invalid content type",415)
    
    new_achievement = Achievement(id=unique_id,
                        content=data["content"],
                        day=data["day"]
    ) 
    db.session.add(new_achievement)
    db.session.commit()

  

    return jsonify({'message': 'new achievement created'}), 202

@main.route('/achievement/add', methods=['GET']) #daha kodlanmaya başlanmadı
def add_achievement():
    data=request.get_json()
    unique_id=str(uuid.uuid4())
    if not data:
        return make_response("invalid content type",415)
    
    new_achievement = Achievement(id=unique_id,
                        content=data["content"],
                        day=data["day"]
    ) 
    db.session.add(new_achievement)
    db.session.commit()

  

    return jsonify({'message': 'new achievement created'}), 202
