from flask_login import UserMixin
from .extensions import db,bcrypt
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, date
import matplotlib.pyplot as plt


class PCRelation(db.Model): #parent consultant relation
    __tablename__="pcrelations"
    id=db.Column(db.Text(), db.ForeignKey('users.id'), primary_key=True)
    consultant_id = db.Column(db.Text(), db.ForeignKey('consultants.id'))

class User(db.Model, UserMixin): #User=Parent
    __tablename__="users"
    id=db.Column(db.Text(),primary_key=True)
    username = db.Column(db.String(),nullable=False, unique=True)
    email_address = db.Column(db.String(), nullable=False, unique=True)
    password_hash = db.Column(db.Text(), nullable=False)
    image_url = db.Column(db.String(),nullable=True)
 

class Consultant(db.Model, UserMixin): 
    __tablename__ = "consultants"
    id = db.Column(db.Text(), primary_key=True)
    image_url = db.Column(db.String(),nullable=True)
    name = db.Column(db.String(),nullable=False)
    password_hash = db.Column(db.Text(), nullable=False)
    child_name = db.Column(db.String(),nullable=True)
    status = db.Column(db.String(),nullable=True)
  

class Child(db.Model):
    __tablename__ = "childs" 
    id = db.Column(db.Text(), primary_key=True)
    name = db.Column(db.String(),nullable=False)
    parent_id = db.Column(db.Text(), db.ForeignKey('users.id'), primary_key=True)


class Session(db.Model):
    __tablename__="sessions"
    id = db.Column(db.Text(), db.ForeignKey('consultants.id'), primary_key=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    expires_at = db.Column(db.DateTime)
    is_parent = db.Column(db.Boolean(), nullable=False)

@property
def is_active(self):
    return datetime.utcnow() < self.expires_at
     
class Assignment(db.Model):
    __tablename__="assignments"
    id=db.Column(db.Text(),primary_key=True)
    consultant_id= db.Column(db.Text(), db.ForeignKey('consultants.id'))
    parent_id = db.Column(db.Text(), db.ForeignKey('users.id'))
    subject_name=db.Column(db.String(),nullable=False)
    child_id = db.Column(db.Text(), db.ForeignKey('users.id'))
    achievement_id = db.Column(db.Text(),db.ForeignKey('achievements.id'))
    #table_vars= db.Column(db.Integer(),nullable=False)
    date=db.Column(db.DateTime, nullable=False)
    time=db.Column(db.DateTime, nullable=True)
    objective= db.Column(db.String(),nullable=False)


class Achievement(db.Model):
    __tablename__="achievements"
    id= db.Column(db.Text(), primary_key=True)
    content= db.Column(db.Text(),nullable=False)
    day=db.Column(db.Integer(),nullable=False)

class Activity(db.Model):
    __tablename__="activities"
    id = db.Column(db.Text(), primary_key=True)
    type = db.Column(db.Integer(),nullable=False)
    image_url = db.Column(db.String(),nullable=True)
    subject= db.Column(db.String(),nullable=False)
    consultant_id = db.Column(db.Text(), db.ForeignKey('consultants.id'))
    #notes

class Course(db.Model):
    __tablename__="courses"   
    id = db.Column(db.Text(), primary_key=True)
    name= db.Column(db.String(),nullable=False)
    consultant_id = db.Column(db.Text(), db.ForeignKey('consultants.id'))
    image_url= db.Column(db.String(),nullable=True)
    video_url= db.Column(db.String(),nullable=True)

class Note(db.Model):
    id = db.Column(db.Text(), primary_key=True)
    date=db.Column(db.DateTime, nullable=False)
    time=db.Column(db.DateTime, nullable=True)
    #content
    consultant_id = db.Column(db.Text(), db.ForeignKey('consultants.id'))
    parent_id = db.Column(db.Text(), db.ForeignKey('users.id'))

class Meeting(db.Model):
    __tablename__="meetings" 
    id = db.Column(db.Text(), primary_key=True)
    relation_id= db.Column(db.String(),db.ForeignKey('pcrelations.id'),nullable=True)
    subject= db.Column(db.String(),nullable=True)
    date= db.Column(db.DateTime, nullable=True)
    url=db.Column(db.String(),nullable=False) #Meet olusturma linki burda saklanır
