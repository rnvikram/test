from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, BooleanField, TextField, TextAreaField, SelectField,DateField,RadioField
from wtforms.validators import DataRequired, Length, Email, EqualTo


def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

class Login(FlaskForm):
    eid = StringField('Employee ID', validators=[DataRequired(), Length(min=1, max=5)])
    submit = SubmitField('Proceed')


class Password_Setup(FlaskForm):
    password = PasswordField('Password', validators=[DataRequired()])
    confirm_password = PasswordField('Confirm Password', validators=[DataRequired(),EqualTo("password")])
    doj=StringField('Date of joining(dd/mm/yyyy)', validators=[DataRequired()])
    submit = SubmitField('Login')

class Password(FlaskForm):
    password = StringField('Password')
    submit = SubmitField('Login')


class Request_asset(FlaskForm):
    import sqlite3
    conn = sqlite3.connect('AssetManagement.db')
    def dict_factory(cursor, row):
        d = {}
        for idx, col in enumerate(cursor.description):
            d[col[0]] = row[idx]
        return d
    conn.row_factory = dict_factory
    c = conn.cursor()
    c.execute("SELECT ATID, AvailableQuantity FROM AssetType")
    assets = c.fetchall()
    asset_array=[]
    quantity_array=[]
    
    for each in assets:
        asset_array.append((each["ATID"],each["ATID"]))
        quantity_array.append((each["AvailableQuantity"],each["AvailableQuantity"]))
    
    asset=SelectField('Asset',choices=asset_array)
    asset_submit = SubmitField('Request Item')


class New_ticket(FlaskForm):
    priority= SelectField('Priority', choices = [('Low','Low'),('Medium','Medium'),('High','High')])
    description = TextAreaField('Description')
    submit_ticket = SubmitField('Submit Ticket')

class Filters_list_view(FlaskForm):
    submit = SubmitField('Submit')
    status_filter = RadioField('Status', choices = [('Open','Open'),('Pending','Pending'),('Waiting on third party','Waiting on third party'),('Closed','Closed')])
    priority_filter = RadioField('Priority', choices = [('Low','Low'),('Medium','Medium'),('High','High'),('Urgent','Urgent')])
    #reply_text = TextField('Reply')
    #reply_button = SubmitField('Reply')
class Reply_module(FlaskForm):
    reply_ticket = TextField('Reply')
    reply_text = TextAreaField('Reply')
    reply_button = SubmitField('Reply')


class Create_article(FlaskForm):
    article_title=TextField('Article Title')
    article_content=TextAreaField('Article Content')
    asset_submit=SubmitField('Create article')
    import sqlite3
    conn = sqlite3.connect('AssetManagement.db')
    def dict_factory(cursor, row):
        d = {}
        for idx, col in enumerate(cursor.description):
            d[col[0]] = row[idx]
        return d
    conn.row_factory = dict_factory
    c = conn.cursor()
    c.execute("SELECT CName FROM Category")
    categories_pulled = c.fetchall()
    categories=[]
    for each in categories_pulled:
        categories.append((each["CName"],each["CName"]))
   
    categories=SelectField('Categories',choices=categories)

class Link_article_asset(FlaskForm):
    import sqlite3
    conn = sqlite3.connect('AssetManagement.db')
    def dict_factory(cursor, row):
        d = {}
        for idx, col in enumerate(cursor.description):
            d[col[0]] = row[idx]
        return d
    conn.row_factory = dict_factory
    c = conn.cursor()
    c.execute("SELECT Title FROM Article")
    articles_pulled = c.fetchall()
    articles_new=[]
    for each in articles_pulled:
        articles_new.append((each["Title"],each["Title"]))
    articles_new=SelectField('Article',choices=articles_new)
    c = conn.cursor()
    c.execute("SELECT ATID FROM AssetType")
    assets_pulled = c.fetchall()
    assets_new=[]
    for each in assets_pulled:
        assets_new.append((each["ATID"],each["ATID"]))
    assets=SelectField('Assets',choices=assets_new)
    asset_link=SubmitField('Link')



class Asset_accept(FlaskForm):
    asset_request_id=TextField('Request id')
    choice= SelectField('Choice', choices = [('Accept','Accept'),('Reject','Reject')])
    asset_accept=SubmitField('Submit')
   