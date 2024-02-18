from flask_login import UserMixin
from .extensions import db,bcrypt
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, date
import matplotlib.pyplot as plt


class ParentConsultantRelation(db.Model):
    __tablename__="parentconsultantrelation"
    id=db.Column(db.Text(), db.ForeignKey('users.id'), primary_key=True)
    consultant_id = db.Column(db.Text(), db.ForeignKey('consultants.id'))

class User(db.Model, UserMixin): #User=Parent
    __tablename__="users"
    id=db.Column(db.Text(),primary_key=True)
    username = db.Column(db.String(),nullable=False, unique=True)
    email_address = db.Column(db.String(), nullable=False, unique=True)
    password_hash = db.Column(db.Text(), nullable=False)
    image_url = db.Column(db.String(),nullable=False)
 

class Consultant(db.Model, UserMixin): 
    __tablename__ = "consultants"
    id = db.Column(db.Text(), primary_key=True)
    image_url = db.Column(db.String(),nullable=True)
    name = db.Column(db.String(),nullable=False)
    title = db.Column(db.String(),nullable=True)
    password_hash = db.Column(db.Text(), nullable=False)
    child_name = db.Column(db.String(),nullable=True)
    status = db.Column(db.String(),nullable=True)


#class ParentProfile(db.Model):
 #   __tablename__ = "parents" 
  #  id = db.Column(db.String(length=30), db.ForeignKey('users.id'), primary_key=True)
  


class Child(db.Model):
    __tablename__ = "parents" 
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
    achievement = db.Column(db.Text(), db.ForeignKey('achivements.id'))
    #table_vars= db.Column(db.Integer(),nullable=False)
    date=db.Column(db.DateTime, nullable=False)
    time=db.Column(db.DateTime, nullable=True)
    objective= db.Column(db.String(),nullable=False)


class Achievement(db.Model):
    __tablename__="achievements"
    id= db.Column(db.Text(), primary_key=True)
    content= db.Column(db.Text(),nullable=False)
    day=db.Column(db.String(),nullable=False)

class Activity(db.Model):
    __tablename__="activities"
    id = db.Column(db.Text(), primary_key=True)
    type = db.Column(db.Integer(),nullable=False)
    image_url = db.Column(db.String(),nullable=False)
    subject= db.Column(db.String(),nullable=False)
    consultant_id = db.Column(db.Text(), db.ForeignKey('consultants.id'))
    #notes

class Course(db.Model):
    __tablename__="courses"   
    id = db.Column(db.Text(), primary_key=True)
    name= db.Column(db.String(),nullable=False)
    consultant_id = db.Column(db.Text(), db.ForeignKey('consultants.id'))
    image_url= db.Column(db.String(),nullable=False)
    video_url= db.Column(db.String(),nullable=False)

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
    consultant_name= db.Column(db.String(),nullable=False)
    subject= db.Column(db.String(),nullable=False)
    date= db.Column(db.DateTime, nullable=False)
    time= db.Column(db.DateTime, nullable=False)
    status= db.Column(db.Integer(), nullable=False)
    duration= db.Column(db.DateTime, nullable=False)
    meet_url=db.Column(db.String(),nullable=False) #Meet olusturma linki burda saklanır
