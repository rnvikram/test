from flask import Flask, render_template, url_for, flash, redirect
from forms import Login,Password_Setup,Password,Request_asset,New_ticket,Filters_list_view,Reply_module,Create_article,Link_article_asset,Asset_accept
import sqlite3
import base64

conn = sqlite3.connect('AssetManagement.db')
app = Flask(__name__)
app.config['SECRET_KEY'] = '5791628bb0b13ce0c676dfde280ba245'
global logged_in
logged_in=False

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

@app.route("/")
@app.route("/home")
def home():
    if(logged_in!=True):
        return redirect(url_for('login'))
    global status_filter
    global priority_filter
    
    status_filter=None
    priority_filter=None
    conn = sqlite3.connect('AssetManagement.db')
    conn.row_factory = dict_factory
    c = conn.cursor()
    c.execute("SELECT count(AID) FROM Asset WHERE EID={0}".format(eid))
    posts = c.fetchall()
    asset_count=(posts[0]['count(AID)'])
    c = conn.cursor()
    c.execute("SELECT count(TID) FROM SupportTicket WHERE EID={0}".format(eid))
    posts = c.fetchall()
    print(posts)
    ticket_count=(posts[0]['count(TID)'])
    c = conn.cursor()
    c.execute("SELECT count(NARID) FROM NewAssetRequest WHERE EID={0}".format(eid))
    posts = c.fetchall()
    Asset_requests=(posts[0]['count(NARID)'])
    data=[]
    data.append({"name":"Assets bac owned","value":asset_count})
    data.append({"name":"Support requests","value":ticket_count})
    data.append({"name":"Assets Requested","value":Asset_requests})
    data.append({"name":"Team Support requests","value":15})

    c = conn.cursor()
    query="SELECT DISTINCT A.ARTID, A.Title, A.ArtCont FROM Article A ,RecommendedArticles ATy, Asset OA WHERE ATy.ATID=OA.ATId AND  OA.EID={0} AND ATy.ARTID=A.ARTID".format(eid)
    c.execute(query)
    recommended_article = c.fetchall()
    print(recommended_article)

    query="SELECT COUNT(AID), ATID FROM Asset A, Employee E WHERE A.Eid=E.EID AND E.Team='{0}' GROUP BY ATID;".format(team)
    c.execute(query)
    recommended_assets = c.fetchall()
    print('Assets')
    print(recommended_assets)


    



    return render_template('home.html',data=data,articles=recommended_article,recommended_assets=recommended_assets)


@app.route("/login", methods=['GET', 'POST'])
def login():
    login_form=Login()

    if login_form.validate_on_submit():
        conn = sqlite3.connect('AssetManagement.db')
        c = conn.cursor()
        c.execute("SELECT Name,Password,DOJ,EID,Team,Admin FROM Employee WHERE EID='{0}'".format(login_form.eid.data))
        results = c.fetchall()
        global doj
        global new_user
        global logged_user
        global eid
        global team
        global admin
        print(results)
        if len(results)==0:
            logged_user=None
            doj=None
            new_user=None
            eid=None
            flash("No User Found")
            return redirect(url_for('login'))
        elif results[0][1]==None:
            doj=results[0][2]
            new_user=results[0][0]
            eid=results[0][3]
            team=results[0][4]
            
            print(results)
            return redirect(url_for('password_setup'))
        else:
            logged_user=results[0][0]
            eid=results[0][3]
            team=results[0][4]
            admin=results[0][5]
            return redirect(url_for('password'))
    return render_template('login.html', title='Login',login_form=login_form)


@app.route("/password_setup", methods=['GET', 'POST'])
def password_setup():
    password_setup_form = Password_Setup()
    #On submission of the form check for DOJ
    if password_setup_form.validate_on_submit():
        #If they don't match, redirect the users to the login page
        if(password_setup_form.doj.data!=doj):
            logged_user=""
            return redirect(url_for('login'))
        #if the DOJ matches with records, update the record with the password
        if(password_setup_form.doj.data==doj):
            conn = sqlite3.connect('AssetManagement.db')
            c = conn.cursor()
            query="UPDATE Employee SET Password = '{0}' WHERE eid = '{1}'".format(password_setup_form.password.data,eid)
            c.execute(query) #Execute the query
            conn.commit()
            global logged_in    
            logged_in=True   #used as a validator to check if the user is logged in
            return redirect(url_for('home'))
    return render_template('password_setup.html', title='password', password_setup_form=password_setup_form)   


@app.route("/password", methods=['GET', 'POST'])
def password():
    password_form=Password()
    #check for password in the record with matching employee id
    if password_form.validate_on_submit():
        conn = sqlite3.connect('AssetManagement.db')
        c = conn.cursor()
        c.execute("SELECT Name,Password FROM Employee WHERE eid='{0}'".format(eid))
        results = c.fetchall()
        if(password_form.password.data==results[0][1]):
            global logged_in
            logged_in=True
            return redirect(url_for('home'))
        else:
            flash("Password is incorrect")
        return redirect(url_for('login'))
    return render_template('password.html', title='password', password_form=password_form)


@app.route("/catalogue",methods=['GET', 'POST'])
def catalogue():
    if(logged_in!=True):
        return redirect(url_for('login'))
    request_form=Request_asset()
    conn = sqlite3.connect('AssetManagement.db')
    conn.row_factory = dict_factory
    c = conn.cursor()
    c.execute("SELECT * FROM AssetType") #Pull all assets offered
    Asset_types = c.fetchall()
    #On submit, create a record in the new asset table
    if request_form.validate_on_submit():
        conn.row_factory = dict_factory
        query=("INSERT INTO NewAssetRequest (EID,ATID,ApprovalStatus,NARStatus)  VALUES ({0}, '{1}', 'False','Open' )".format(eid,request_form.asset.data))
        c.execute(query) 
        conn.commit()
        flash("Request successfull")
        return redirect(url_for('home'))
    return render_template('catalogue.html', Asset_types=Asset_types,user_name=logged_user,request_form=request_form)


@app.route("/new_ticket",methods=['GET', 'POST'])
def new_ticket(): 
    if(logged_in!=True):
        return redirect(url_for('login'))
    new_ticket_form=New_ticket()
    if new_ticket_form.validate_on_submit():
        conn = sqlite3.connect('AssetManagement.db')
        query="INSERT INTO SupportTicket (ProblemDescription,CreatedTime,TStatus,Priority,EID)  VALUES ('{0}' ,'{1}', 'Open','{2}',{3})".format(new_ticket_form.description.data,"12/12/2018",new_ticket_form.priority.data,eid)
        c = conn.cursor()
        c.execute(query) 
        conn.commit()
        return redirect(url_for('support_tickets'))
    return render_template('new_ticket.html', title='New Ticket', new_ticket_form=new_ticket_form)


@app.route("/support_tickets",methods=['GET', 'POST'])
def support_tickets():
    reply_form=Reply_module()
    filters_form=Filters_list_view()
    if(logged_in!=True):
        return redirect(url_for('login'))
    conn = sqlite3.connect('AssetManagement.db')
    global status_filter
    global priority_filter
    conn.row_factory = dict_factory
    c = conn.cursor()
    query="SELECT * FROM SupportTicket WHERE EID='{0}'".format(eid)
    #create addtional filters on  query if a value is choosen in the filters sections
    if status_filter!= None:
        query=query + " AND TStatus='{0}'".format(status_filter)
    if priority_filter!= None:
        query=query + " AND Priority='{0}'".format(priority_filter)  

    print(query)
    c.execute(query)
    support_tickets = c.fetchall()
    reply={}

    #Skim through each ticket and pull the replies in them
    for i in range(len(support_tickets)):
        query="SELECT * FROM Reply WHERE TID='{0}'".format(support_tickets[i]["TID"])
        c.execute(query)
        reply[support_tickets[i]["TID"]]=c.fetchall()
    
    if filters_form.validate_on_submit():
        status_filter=filters_form.status_filter.data
        priority_filter=filters_form.priority_filter.data
        return redirect(url_for('support_tickets'))
    
    #push reply to db on submit
    if reply_form.validate_on_submit():
        test=1
        reply_ticket=reply_form.reply_ticket.data
        reply_content=reply_form.reply_text.data
        query="INSERT INTO Reply (EID,TID,RContent) VALUES ({0},{1},'{2}')".format(eid,reply_ticket,reply_content)
        c = conn.cursor()
        c.execute(query) 
        conn.commit()
        return redirect(url_for('support_tickets'))
        
    return render_template('support_tickets.html', support_tickets=support_tickets,user_name=logged_user,filters_form=filters_form,reply=reply,reply_form=reply_form)


@app.route("/solutions")
def solutions():
    conn = sqlite3.connect('AssetManagement.db')
    conn.row_factory = dict_factory
    c = conn.cursor()
    #pull out all categories
    c.execute("SELECT CName,  CDescription,CID FROM Category")
    categories = c.fetchall()
    final_data=[]
    for category in categories:
        c = conn.cursor()
        #pull out articles in each category
        c.execute("SELECT Title, ArtCont, ARTID FROM Article WHERE CID={0}".format(category["CID"]))
        articles = c.fetchall()
        final_data.append({"Title":category["CName"],"AContent":category["CDescription"],"CID":category["CID"],"Articles":articles})
    return render_template('solutions.html', data=final_data)



@app.route("/admin", methods=['GET', 'POST'])
def admin():
    print("final")
    print(admin)
    if(admin!="1"):
        return redirect(url_for('home'))
    
    asset_accept_form=Asset_accept()
    create_article_form=Create_article()
    link_asset=Link_article_asset()
    conn = sqlite3.connect('AssetManagement.db')
    conn.row_factory = dict_factory
    c = conn.cursor()
    c.execute("SELECT NARID, ATID, EID FROM NewAssetRequest WHERE NARStatus='Open'")
    assets_requests = c.fetchall()
    final_data=[]
    for assets_request in assets_requests:
        conn = sqlite3.connect('AssetManagement.db')
        conn.row_factory = dict_factory
        c = conn.cursor()
        c.execute("SELECT Name,Team, EID FROM Employee WHERE EID={0}".format(assets_request["EID"]))
        employee = c.fetchall()[0]
        final_data.append({"NARID":assets_request["NARID"],"ATID":assets_request["ATID"],"Employee":employee})

    if create_article_form.validate_on_submit():
        title=create_article_form.article_title.data
        content=create_article_form.article_content.data
        category=create_article_form.categories.data
        c.execute("SELECT CID FROM Category WHERE CName='{0}'".format(category))
        category_id=c.fetchall()
        category_id=(category_id[0]["CID"])
        query="INSERT INTO Article (CID,Title,ArtCont)  VALUES ('{0}' ,'{1}','{2}')".format(category_id,title,content)
        
        c = conn.cursor()
        c.execute(query) #Execute the query
        conn.commit()
        flash("Created successfully")
        return render_template('home.html')


    if link_asset.validate_on_submit():
        article_title=link_asset.articles_new.data
        asset_name=link_asset.assets.data
        c = conn.cursor()
        c.execute("SELECT ARTID FROM Article WHERE Title='{0}'".format(article_title))
        
        article_id = c.fetchall()
        article_id=article_id[0]["ARTID"]
        query="INSERT INTO RecommendedArticles (ARTID,ATID)  VALUES ({0} ,'{1}')".format(article_id,asset_name)
        c = conn.cursor()
        c.execute(query) #Execute the query
        conn.commit()



    if asset_accept_form.validate_on_submit():
        if(asset_accept_form.choice.data=="Accept"):
            query="UPDATE NewAssetRequest SET NARStatus = 'Granted' WHERE NARID = '{0}'".format(asset_accept_form.asset_request_id.data)
            c = conn.cursor()
            c.execute(query) #Execute the query
            conn.commit()
            c = conn.cursor()
            c.execute("SELECT NARID, ATID, EID FROM NewAssetRequest WHERE NARID={0}".format(asset_accept_form.asset_request_id.data))
            asset_details=c.fetchall()[0]
            query="Insert INTO Asset ('ATID','EID') VALUES ('{0}',{1})".format(asset_details["ATID"],asset_details["EID"])
            c = conn.cursor()
            c.execute(query) #Execute the query
            conn.commit()
        else:
            query="UPDATE NewAssetRequest SET NARStatus = 'Rejected' WHERE NARID = '{0}'".format(asset_accept_form.asset_request_id.data)
            c = conn.cursor()
            c.execute(query) #Execute the query
            conn.commit()
        print(asset_accept_form.asset_request_id.data)
        
    
        
    return render_template('admin.html',assets_requests=final_data,asset_accept_form=asset_accept_form,create_article_form=create_article_form,link_asset=link_asset)





if __name__ == '__main__':
    app.run(debug=True)
