from flask_login import UserMixin
from .extensions import db,bcrypt
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, date
import matplotlib.pyplot as plt

class User(db.Model, UserMixin):
    __tablename__="users"
    id=db.Column(db.String(),primary_key=True)
    username = db.Column(db.String(length=30),nullable=False, unique=True)
    email_address = db.Column(db.String(length=50), nullable=False, unique=True)
    password_hash = db.Column(db.String(length=256), nullable=False)
    events = db.relationship('Event', backref='owned_user', lazy=True)
    is_consultant = db.Column(db.Boolean(), nullable=False)

class ConsultantProfile(db.Model): 
    __tablename__="consultants"
    image_url= db.Column(db.String(length=30),nullable=False)
    consultant_name= db.Column(db.String(length=30),nullable=False)
    child_name= db.Column(db.String(length=30),nullable=False)

class Event(db.Model):
    __tablename__="events"
    id = db.Column(db.String(), primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date = db.Column(db.DateTime, nullable=False)
    start_time = db.Column(db.DateTime, nullable=False)
    end_time = db.Column(db.DateTime, nullable=False)
    duration = db.Column(db.String(), nullable=False)
    owner = db.Column(db.String(), db.ForeignKey('users.id'),nullable=True)
    category = db.Column(db.String(), nullable=False)

class Session(db.Model):
    __tablename__="sessions"
    user_id = db.Column(db.String(), db.ForeignKey('users.id'),primary_key=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    expires_at = db.Column(db.DateTime)

@property
def is_active(self):
    return datetime.utcnow() < self.expires_at
     
class Assignment(db.Model):
    __tablename__="assignments"
    consultant_id= db.Column(db.String(length=30), db.ForeignKey('users.id'))
    consultant_name =db.Column(db.String(length=30),nullable=False)
    subject_name=db.Column(db.String(length=30),nullable=False)
    date=db.Column(db.DateTime, nullable=False)
    time=db.Column(db.DateTime, nullable=False)

class Category(db.Model):
    category_name= db.Column(db.String(length=30),nullable=False, unique=True)
    category_color= db.Column(db.String(length=30),nullable=False)
    category_url= db.Column(db.String(length=30),nullable=False)

class Course(db.Model):   
    course_name= db.Column(db.String(length=30),nullable=False)
    teacher_name= db.Column(db.String(length=30),nullable=False)
    course_image_url= db.Column(db.String(length=30),nullable=False)
    completion_rate = db.Column(db.Integer(),nullable=False)

class Meeting(db.Model): 
    consultant_name= db.Column(db.String(length=30),nullable=False)
    subject= db.Column(db.String(length=30),nullable=False)
    date= db.Column(db.DateTime, nullable=False)
    time= db.Column(db.DateTime, nullable=False)
    status= db.Column(db.Integer(), nullable=False)
    duration= db.Column(db.DateTime, nullable=False)

class ParentProfile(db.Model): 
    image_url= db.Column(db.String(length=30),nullable=False)
    parent_name= db.Column(db.String(length=30),nullable=False)
    child_name= db.Column(db.String(length=30),nullable=False)