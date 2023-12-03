import os
from flask import Flask, request, jsonify, json, send_from_directory
from flask_cors import cross_origin
from main import detecttext_pre, recognition_pre, detecttext_mat, recognition_mat
import time
import shutil
import pymysql
from datetime import datetime
import tensorflow as tf

os.environ['TF_CPP_MIN_LOG_LEVEL']='2'
app = Flask(__name__)
model = tf.keras.models.load_model(os.getcwd())

def mysql_connection():
    pool = pymysql.connect(host='127.0.0.1',user='root',password='_ook0105',db='springocr',charset='utf8')
    return pool

@app.route('/')
def hello():
    return 'Hello Flask Worldss!!'

@app.route('/api/register', methods=['POST','GET'])
@cross_origin()
def register():
    result = "fail"
    if(request.method == 'POST'):
        # print("REGISTER...")
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        name = request_data['name']
        email = request_data['email']
        password = request_data['password']

        conn = mysql_connection()
        cursor = conn.cursor()
        
        sql = ''
        sql = "insert into members values("
        sql += "%s,%s,%s"
        sql += ");"
        values = name,email,password
        try:
            cursor.execute(sql,values)
            conn.commit()
            result = "success"

        except Exception as error:
            print("error :",error)
        cursor.close
        conn.close
    return result

@app.route('/api/login', methods=['POST','GET'])
@cross_origin()
def login():
    result = False
    row = ''
    if (request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        email = request_data['email']
        password = request_data['password']
        conn = mysql_connection()
        cursor = conn.cursor()
        sql = "select * from members where email=%s"
        cursor.execute(sql, (email,))
        rv = cursor.fetchone()
        
        if rv != None:
            row_headers = [x[0] for x in cursor.description]
            row = dict(zip(row_headers, rv))    
            result = row['password']==password
            # print(result)
        else : 
            return jsonify("nouser")
    
    # print(result)
    if(result):
        return jsonify(row)
    else:
        return jsonify('fail')

 
@app.route('/api/ocrImageUploadmat', methods=['GET', 'POST'])
@cross_origin()
def ocrImageUploadmat():
    json_values = []
    filename=""
    if request.method == 'POST':
        start = time.time() 
        f = request.files['files']
        now = datetime.now().strftime('%Y_%m_%d_%H_%M_%S')
        filename="".join([now,".jpg"])
        f.save("".join(["./image/DBimg/",filename]))
        # shutil.copyfile("./image/inputimg/test.jpg", "./image/DBimg/"+filename)
        # shutil.rmtree("./image/crop_img/",ignore_errors=True)
        os.makedirs("/".join(["image","crop_img",now]), exist_ok=True)
        preparetime = time.time()# 시작 시간 저장   
        print("prepare time : ", preparetime-start)
        detecttext_mat(filename)
        detecttime = time.time()
        print("detect time :", detecttime - preparetime,"s")
        json_values = recognition_mat("".join(["./image/crop_img/",now]),model)
        print("recog time :", time.time() - detecttime,"s")  # 현재시각 - 시작시간 = 실행 시간
        print("total time :", time.time() - start,"s")  # 현재시각 - 시작시간 = 실행 시간
        # print(json_values)        
    return jsonify([filename,json_values])
#[['75431', '21', '01', '31', '21', '08', '28', '06', '09', '07', '17', '15', '04', '25', '07', '26', '03', '38', '09', '07', '02', '07', '07', '13', '03', '06']]
@app.route('/api/ocrImageUploadpre', methods=['GET', 'POST'])
@cross_origin()
def ocrImageUploadpre():
    json_values = []
    filename=""
    if request.method == 'POST':
        start = time.time() 
        f = request.files['files']
        now = datetime.now().strftime('%Y_%m_%d_%H_%M_%S')
        filename="".join([now,".jpg"])
        f.save("".join(["./image/DBimg/",filename]))
        # shutil.copyfile("./image/inputimg/test.jpg", "./image/DBimg/"+filename)
        # shutil.rmtree("./image/crop_img/",ignore_errors=True)
        os.makedirs("/".join(["image","crop_img",now]), exist_ok=True)
        preparetime = time.time()# 시작 시간 저장   
        print("prepare time : ", preparetime-start)
        detecttext_pre(filename)
        detecttime = time.time()
        print("detect time :", detecttime - preparetime,"s")
        json_values = recognition_pre("".join(["./image/crop_img/",now]),model)
        print("recog time :", time.time() - detecttime,"s")  # 현재시각 - 시작시간 = 실행 시간
        print("total time :", time.time() - start,"s")  # 현재시각 - 시작시간 = 실행 시간        
    return jsonify([filename,json_values])

@app.route('/api/ocrGetImage/<path:subpath>')
def download_File(subpath):
	return send_from_directory('./', subpath, as_attachment=True)
	# return send_file(subpath, as_attachment=True)

@app.route('/api/ocrmaternityInsert', methods=['POST','GET'])
@cross_origin()
def ocrmaternityInsert():
    if(request.method == 'POST'):
        # print("INSERT...")
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        sow_no = request_data['sow_no']
        sow_birth = request_data['sow_birth']
        sow_buy = request_data['sow_buy']
        sow_expectdate = request_data['sow_expectdate']
        sow_givebirth = request_data['sow_givebirth']
        sow_totalbaby = request_data['sow_totalbaby']
        sow_feedbaby = request_data['sow_feedbaby']
        sow_babyweight = request_data['sow_babyweight']
        sow_sevrerdate = request_data['sow_sevrerdate']
        sow_sevrerqty = request_data['sow_sevrerqty']
        sow_sevrerweight = request_data['sow_sevrerweight']
        vaccine1 = request_data['vaccine1']
        vaccine2 = request_data['vaccine2']
        vaccine3 = request_data['vaccine3']
        vaccine4 = request_data['vaccine4']

        nowdate =  datetime.now()
        input_date = nowdate.strftime("%Y-%m-%d")
        input_time = nowdate.strftime("%H:%M:%S")
        ocr_imgpath = request_data['ocr_imgpath']

        conn = mysql_connection()
        cursor = conn.cursor()
        
        sql = ''
        sql = "insert into ocr_maternity (ocr_seq,sow_no,sow_hang,sow_birth,sow_buy,sow_expectdate,"
        sql += "sow_givebirth,sow_totalbaby,sow_feedbaby,sow_babyweight,sow_sevrerdate,sow_sevrerqty,"
        sql += "sow_sevrerweight,vaccine1,vaccine2,vaccine3,vaccine4,input_date,input_time,ocr_imgpath"
        sql += ")values("
        sql += "(select IFNULL(MAX(T.ocr_seq),0) + 1 from ocr_maternity T),%s,"
        sql += "(select IFNULL(MAX(T.sow_hang),0) + 1 from ocr_maternity T where sow_no=%s),"
        sql += "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s"
        sql += ")"
        values = sow_no,sow_no,sow_birth,sow_buy,sow_expectdate,sow_givebirth,sow_totalbaby,sow_feedbaby,sow_babyweight,sow_sevrerdate,sow_sevrerqty,sow_sevrerweight,vaccine1,vaccine2,vaccine3,vaccine4,input_date,input_time,ocr_imgpath
        try:
            cursor.execute(sql,values)
            conn.commit()
        except Exception as error:
            print("error :",error)
        cursor.close
        conn.close
    return "good"

@app.route('/api/ocrpregnantInsert', methods=['POST','GET'])
@cross_origin()
def ocrpregnantInsert():
    if(request.method == 'POST'):
        print("INSERT...")
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        sow_no = request_data['sow_no']
        sow_birth = request_data['sow_birth']
        sow_buy = request_data['sow_buy']
        sow_estrus = request_data['sow_estrus']
        sow_cross = request_data['sow_cross']
        boar_fir = request_data['boar_fir']
        boar_sec = request_data['boar_sec']
        checkdate = request_data['checkdate']
        expectdate = request_data['expectdate']
        vaccine1 = request_data['vaccine1']
        vaccine2 = request_data['vaccine2']
        vaccine3 = request_data['vaccine3']
        vaccine4 = request_data['vaccine4']

        nowdate =  datetime.now()
        input_date = nowdate.strftime("%Y-%m-%d")
        input_time = nowdate.strftime("%H:%M:%S")
        ocr_imgpath = request_data['ocr_imgpath']

        conn = mysql_connection()
        cursor = conn.cursor()
        
        sql = "insert into ocr_pregnant(ocr_seq,sow_no,sow_hang,sow_birth,sow_buy,sow_estrus,"
        sql += "sow_cross,boar_fir,boar_sec,checkdate,expectdate,vaccine1,vaccine2,"
        sql += "vaccine3,vaccine4,input_date,input_time,ocr_imgpath"
        sql += ")values("
        sql += "(select IFNULL(MAX(T.ocr_seq),0) + 1 from ocr_pregnant T),%s,"
        sql += "(select IFNULL(MAX(T.sow_hang),0) + 1 from ocr_pregnant T where sow_no=%s),"
        sql += "%s,%s,%s,%s,%s,%s,%s,%s,%s ,%s,%s,%s,%s,%s,%s"
        sql += ")"
        values = sow_no,sow_no,sow_birth,sow_buy,sow_estrus,sow_cross,boar_fir,boar_sec,checkdate,expectdate,vaccine1,vaccine2,vaccine3,vaccine4,input_date,input_time,ocr_imgpath
        try:
            cursor.execute(sql,values)
            conn.commit()
        except Exception as error:
            print("error :",error)
        cursor.close
        conn.close
    return "good"

@app.route('/api/getOcr_maternity', methods=['POST', 'GET'])
@cross_origin()
def getOcr_maternity():
    rows = []
    if (request.method == 'GET'):
        conn = mysql_connection()
        cursor = conn.cursor()
        sql = ''
        sql = "select * from ocr_maternity order by ocr_seq DESC"
        cursor.execute(sql)
        rv = cursor.fetchall()
        # print(rv)
 
        row_headers = [x[0] for x in cursor.description]
        for result in rv:
            rows.append(dict(zip(row_headers,result)))
            
        conn.close()
    return jsonify(rows)

@app.route('/api/getOcr_pregnant', methods=['POST', 'GET'])
@cross_origin()
def getOcr_pregnant():
    rows = []
    if (request.method == 'GET'):
        conn = mysql_connection()
        cursor = conn.cursor()
        sql = ''
        sql = "select * from ocr_pregnant order by ocr_seq DESC"
        cursor.execute(sql)
        rv = cursor.fetchall()
        # print(rv)
 
        row_headers = [x[0] for x in cursor.description]
        for result in rv:
            rows.append(dict(zip(row_headers,result)))
            
        conn.close()
    return jsonify(rows)

@app.route('/api/getOcrSearch_maternity', methods=['POST', 'GET'])
@cross_origin()
def getOcrSearch_maternity():
    rows = []
    if (request.method == 'POST'):
        conn = mysql_connection()
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        text = request_data['text'].split(": ")[-1]
        # print(text)
        cursor = conn.cursor()
        sql = ''
        sql = "SELECT * FROM ocr_maternity WHERE sow_no LIKE '"+text + "%' ORDER BY ocr_seq DESC"
        cursor.execute(sql)
        # print(sql)
        rv = cursor.fetchall()
   
        # print(rv)
 
        row_headers = [x[0] for x in cursor.description]
        for result in rv:
            rows.append(dict(zip(row_headers,result)))

        conn.close()
    return jsonify(rows)

@app.route('/api/getOcrSearch_pregnant', methods=['POST', 'GET'])
@cross_origin()
def getOcrSearch_pregnant():
    rows = []
    if (request.method == 'POST'):
        conn = mysql_connection()
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        text = request_data['text'].split(": ")[-1]
        # print(text)
        cursor = conn.cursor()
        sql = ''
        sql = "SELECT * FROM ocr_pregnant WHERE sow_no LIKE '"+text + "%' ORDER BY ocr_seq DESC"
        cursor.execute(sql)
        # print(sql)
        rv = cursor.fetchall()
   
        # print(rv)
 
        row_headers = [x[0] for x in cursor.description]
        for result in rv:
            rows.append(dict(zip(row_headers,result)))

        conn.close()
    return jsonify(rows)

@app.route('/api/ocrmaternityUpdate', methods=['POST','GET'])
@cross_origin()
def ocrmaternityUpdate():
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        ocr_seq = request_data['ocr_seq']
        sow_no = request_data['sow_no']
        sow_hang = request_data['sow_hang']
        sow_birth = request_data['sow_birth']
        sow_buy = request_data['sow_buy']
        sow_expectdate = request_data['sow_expectdate']
        sow_givebirth = request_data['sow_givebirth']
        sow_totalbaby = request_data['sow_totalbaby']
        sow_feedbaby = request_data['sow_feedbaby']
        sow_babyweight = request_data['sow_babyweight']
        sow_sevrerdate = request_data['sow_sevrerdate']
        sow_sevrerqty = request_data['sow_sevrerqty']
        sow_sevrerweight = request_data['sow_sevrerweight']
        vaccine1 = request_data['vaccine1']
        vaccine2 = request_data['vaccine2']
        vaccine3 = request_data['vaccine3']
        vaccine4 = request_data['vaccine4']

        nowdate =  datetime.now()
        input_date = nowdate.strftime("%Y-%m-%d")
        input_time = nowdate.strftime("%H:%M:%S")

        conn = mysql_connection()
        cursor = conn.cursor()
        sql = ''
    
        sql = "update ocr_maternity set sow_no=%s,sow_hang=%s,sow_birth=%s,sow_buy=%s,sow_expectdate=%s,sow_givebirth=%s,sow_totalbaby=%s,"
        sql += "sow_feedbaby=%s,sow_babyweight=%s,sow_sevrerdate=%s,sow_sevrerqty=%s,sow_sevrerweight=%s,vaccine1=%s,vaccine2=%s,"
        sql += "vaccine3=%s,vaccine4=%s,input_date=%s,input_time=%s where ocr_seq=%s"
        try:
            cursor.execute(sql,(sow_no,sow_hang,sow_birth,sow_buy,sow_expectdate,sow_givebirth,sow_totalbaby,sow_feedbaby,sow_babyweight,sow_sevrerdate,sow_sevrerqty,sow_sevrerweight,vaccine1,vaccine2,vaccine3,vaccine4,input_date,input_time,ocr_seq))
            conn.commit()
        except Exception as error:
            print("error :",error)
        cursor.close
        conn.close
    return "good"

@app.route('/api/ocrpregnantUpdate', methods=['POST','GET'])
@cross_origin()
def ocrpregnantUpdate():
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        ocr_seq = request_data['ocr_seq']
        sow_no = request_data['sow_no']
        sow_hang = request_data['sow_hang']
        sow_birth = request_data['sow_birth']
        sow_buy = request_data['sow_buy']
        sow_estrus = request_data['sow_estrus']
        sow_cross = request_data['sow_cross']
        boar_fir = request_data['boar_fir']
        boar_sec = request_data['boar_sec']
        checkdate = request_data['checkdate']
        expectdate = request_data['expectdate']
        vaccine1 = request_data['vaccine1']
        vaccine2 = request_data['vaccine2']
        vaccine3 = request_data['vaccine3']
        vaccine4 = request_data['vaccine4']

        nowdate =  datetime.now()
        input_date = nowdate.strftime("%Y-%m-%d")
        input_time = nowdate.strftime("%H:%M:%S")

        conn = mysql_connection()
        cursor = conn.cursor()
        
        sql = "update ocr_pregnant set sow_no=%s,sow_hang=%s,sow_birth=%s,sow_buy=%s,sow_estrus=%s,"
        sql += "sow_cross=%s,boar_fir=%s,boar_sec=%s,checkdate=%s,expectdate=%s,vaccine1=%s,vaccine2=%s,"
        sql += "vaccine3=%s,vaccine4=%s where ocr_seq=%s"

        try:
            cursor.execute(sql,(sow_no,sow_hang,sow_birth,sow_buy,sow_estrus,sow_cross,boar_fir,boar_sec,checkdate,expectdate,vaccine1,vaccine2,vaccine3,vaccine4,ocr_seq))
            conn.commit()
        except Exception as error:
            print("error :",error)
        cursor.close
        conn.close
    return "good"

@app.route('/api/ocr_maternitySelectedRow', methods=['POST', 'GET'])
@cross_origin()
def ocr_maternitySelectedRow():
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        ocr_seq = request_data['ocr_seq']
        conn = mysql_connection()
        cursor = conn.cursor()
        sql = ''
        sql = "select * from ocr_maternity where ocr_seq=%s"
        cursor.execute(sql, (ocr_seq,))
        row = cursor.fetchone()
        rowlist = list(row)
        # print(rowlist)
        a=[]
        b=[]
        for i in rowlist:
            if type(i)==int:
                b.append(i)
            elif rowlist.index(i)==1:
                a.append(i.replace("-",""))
            elif (rowlist.index(i)==9)|(rowlist.index(i)==12):
                a.append(i.replace(".",""))
            elif '-' in i:
                a+=i.split("-")
            else:
                a.append(i)

        # print(rowlist[-1],a,b)
        return jsonify([rowlist[-1],a,b])
    
@app.route('/api/ocr_pregnantSelectedRow', methods=['POST', 'GET'])
@cross_origin()
def ocr_pregnantSelectedRow():
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        ocr_seq = request_data['ocr_seq']
        conn = mysql_connection()
        cursor = conn.cursor()
        sql = ''
        sql = "select * from ocr_pregnant where ocr_seq=%s"
        cursor.execute(sql, (ocr_seq,))
        row = cursor.fetchone()
        rowlist = list(row)
        # print(rowlist)
        a=[]
        b=[]
        for i in rowlist:
            if type(i)==int:
                b.append(i)
            elif rowlist.index(i)==1 or rowlist.index(i)==7 or rowlist.index(i)==8:
                a.append(i.replace("-",""))
            # elif (rowlist.index(i)==9)|(rowlist.index(i)==12):
            #     a.append(i.replace(".",""))
            elif '-' in i:
                a+=i.split("-")
            else:
                a.append(i)

        # print(rowlist[-1],a,b)
        return jsonify([rowlist[-1],a,b])
    
@app.route('/api/ocr_maternityDelete', methods=['POST','GET'])
@cross_origin()
def ocr_maternityDelete():
    result = "not"
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        ocr_seq = request_data['ocr_seq']

        conn = mysql_connection()
        cursor = conn.cursor()
        try:
            sql = ''
            sql = "delete from ocr_maternity where ocr_seq=%s"
            cursor.execute(sql,(ocr_seq,))
            conn.commit()
            result = "success"
        except Exception as error:
            result = "fail"
        cursor.close
        conn.close
    return result

@app.route('/api/ocr_pregnantDelete', methods=['POST','GET'])
@cross_origin()
def ocr_pregnantDelete():
    result = "not"
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        ocr_seq = request_data['ocr_seq']

        conn = mysql_connection()
        cursor = conn.cursor()
        try:
            sql = ''
            sql = "delete from ocr_pregnant where ocr_seq=%s"
            cursor.execute(sql,(ocr_seq,))
            conn.commit()
            result = "success"
        except Exception as error:
            result = "fail"
        cursor.close
        conn.close
    return result

@app.route('/api/ocrPregnantSendDate', methods=['POST','GET'])
@cross_origin()
def ocrPregnantSendDate():
    conn = mysql_connection()
    rows = []
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        everysundays = request_data['everysunday']
        for i in range(len(everysundays)):
            begindate = everysundays[i][0]
            enddate = everysundays[i][1]
            cursor = conn.cursor()
            sql = ''
            sql = "select %s as begindate,%s as enddate, count(sow_cross) as sow_cross  from ocr_pregnant where DATE(input_date) between  %s "
            sql += "and %s and ocr_seq in(select max(ocr_seq) "
            sql += "from ocr_pregnant group by sow_no) order by sow_hang"
            cursor.execute(sql, (begindate,enddate,begindate,enddate,))
            rv = cursor.fetchall()
            row_headers = [x[0] for x in cursor.description]

            for result in rv:
                rows.append(dict(zip(row_headers,result)))
    return jsonify(rows)

@app.route('/api/ocrMaternitySendDate', methods=['POST','GET'])
@cross_origin()
def ocr_MaternitySendDate():
    conn = mysql_connection()
    rows = []
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        everysundays = request_data['everysunday']

        for i in range(len(everysundays)):
            begindate = everysundays[i][0]
            enddate = everysundays[i][1]
            cursor = conn.cursor()
            sql = ''
            sql = "select  %s as begindate,%s as enddate,sum(sow_sevrerqty) as sevrer,sum(sow_totalbaby) as totalbaby,sum(sow_feedbaby) as feedbaby "
            sql += "from ocr_maternity where DATE(input_date) between  %s and %s and "
            sql += "ocr_seq in(select max(ocr_seq) from ocr_maternity group by sow_no) order by sow_hang"
            cursor.execute(sql, (begindate,enddate,begindate,enddate,))
            rv = cursor.fetchall()
            row_headers = [x[0] for x in cursor.description]

            for result in rv:
                rows.append(dict(zip(row_headers,result)))
        cursor.close
        conn.close
    return jsonify(rows)


@app.route('/api/ocrTargetSelectedRow', methods=['POST', 'GET'])
@cross_origin()
def ocrTargetSelectedRow():
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        yyyy = request_data['yyyy']
        mm = request_data['mm']
        conn = mysql_connection()
        cursor = conn.cursor()
        sql = ''
        sql = "select * from target where yyyy=%s and mm=%s"
        cursor.execute(sql, (yyyy,mm,))
        row = cursor.fetchone()
        return jsonify(row)

@app.route('/api/ocrTargetInsertUpdate', methods=['POST','GET'])
@cross_origin()
def ocrTargetInsertUpdate():
    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        yyyy = request_data['yyyy']
        mm = request_data['mm']
        sow_totalbaby = request_data['sow_totalbaby']
        sow_feedbaby = request_data['sow_feedbaby']
        sow_sevrer = request_data['sow_sevrer']
        sow_cross = request_data['sow_cross']
        conn = mysql_connection()
        cursor = conn.cursor()
        sql = ''
        sql = "insert into target (yyyy,mm,sow_totalbaby,sow_feedbaby,sow_sevrer,sow_cross)values(%s,%s,%s,%s,%s,%s) "
        sql += "ON DUPLICATE KEY UPDATE sow_totalbaby=%s,sow_feedbaby=%s,sow_sevrer=%s,sow_cross=%s"
        try:
            cursor.execute(sql, (yyyy, mm, sow_totalbaby, sow_feedbaby, sow_sevrer,sow_cross ,sow_totalbaby, sow_feedbaby, sow_sevrer,sow_cross))
            conn.commit()
            cursor.close
            conn.close
            return 'success'
        except Exception as error:
            cursor.close
            conn.close
            return 'fail'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)	

