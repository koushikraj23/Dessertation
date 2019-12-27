'''
Created on 18-Nov-2019

@author: 91984
'''
import pandas as pd
import numpy as np
import sys
# from datetime import datetime
import statsmodels.api as sm
import matplotlib.pylab as plt
from audioop import rms
# df = pd.read_csv('C:\\Users\\91984\\Desktop\\shampoo.csv')
from datetime import datetime
from pandas.plotting import register_matplotlib_converters
from sklearn import neighbors
from sklearn.model_selection import GridSearchCV
from sklearn.preprocessing import MinMaxScaler
# from adodbapi.test.adodbapitest import str

register_matplotlib_converters()
import mysql.connector
from mysql.connector import Error
import pandas as pd

connection = mysql.connector.connect(host='localhost',
                                         database='sys',
                                         user='root',
                                         password='123456' ,auth_plugin='mysql_native_password')

from pmdarima.arima import auto_arima


from sklearn.preprocessing import MinMaxScaler
from keras.models import Sequential
from keras.layers import Dense, Dropout, LSTM

id=1
# sql_select_Query = "SELECT concat(year ,Month) as Date,price as data FROM oildata;"
# sql_select_Query="SELECT concat( year,Month) as Date , unit_price  as data FROM oildata"
sql_select_Query = "SELECT sql_query FROM querytable where id=%s;"
cursor = connection.cursor(buffered=True)
cursor.execute(sql_select_Query, (id,))
record = cursor.fetchone()
for row in record:
    sql_select_Query = row
    print(row)
print(sql_select_Query)


df1  = pd.read_sql(sql_select_Query,connection);

 
columnsNamesArr = df1.columns.values
    
listOfColumnNames = list(columnsNamesArr)
print(listOfColumnNames)
print(len(listOfColumnNames))
for y in range(1, len(listOfColumnNames)):
    df=df1.iloc[:,[0,y]]
    df[listOfColumnNames[0]] = pd.to_datetime(df1.iloc[:, 0], format='%Y%m')   
    print( df1[listOfColumnNames[y]][:2])
#     df['Date'] = pd.to_datetime(df['Date'])
    df.set_index(listOfColumnNames[0], inplace=True)
# 
    data = df.sort_index(ascending=True, axis=0) 
# df['Date'] = pd.to_datetime(df.iloc[:,0], format='%Y%m')
# df['Date']=pd.to_datetime(df['Date'])
# df.set_index('Date', inplace=True)
# 
# data = df.sort_index(ascending=True, axis=0)


    mySql_insert_query = "INSERT INTO prediction (sql_id, p_value, p_date) VALUES (10, 'Lenovo ThinkPad P71', 6459, '2019-08-14') "


 
    scaler = MinMaxScaler(feature_range=(0, 1))
    scaled_data = scaler.fit_transform(data)

# create and fit the LSTM network


# print(loss_history)
#predicting 246 values, using past 60 from the train data

# last_date = pd.DataFrame()
# last_row = df.iloc[-1]
# last_date['Predictions'] = 0
 
# last_date['Date'] = pd.date_range(last_row['Date'], periods = 6, freq ='M')
# last_date.set_index('Date',inplace=True)
# print(last_date)
# print( last_date.index)
    sql_select_Query="SELECT * FROM sys.prediction_model where sql_id=1;"
    sql_select_Query="SELECT col_no FROM sys.querytable where id=1;"
    cursor = connection.cursor(buffered=True)
    cursor.execute(sql_select_Query)
    col_no = cursor.fetchone()
    for row in col_no:
        col_no = row
# 
# 
# for y in range(1, col_no+1):
    sql_select_Query="SELECT p_value_"+str(y)+" FROM sys.prediction_model where sql_id=1;"
    cursor.execute(sql_select_Query)
    
    filename = cursor.fetchone()
    for row in filename:
        filename = row
    print(filename)
# last_date['Predictions']=closing_price
# save the model to disk.=
    import pickle
    model = pickle.load(open(filename, 'rb'))
###############
    train = df
# print(train)
    from keras.preprocessing.sequence import TimeseriesGenerator
    scaler.fit(train)
    train = scaler.transform(train)
    n_input = 6
    n_features = 1
    generator = TimeseriesGenerator(train, train, length=n_input, batch_size=6)
    history_callback=model.fit_generator(generator,epochs=25)
    loss_history = history_callback.history["loss"]
# print(loss_history)
    pred_list = []  
    batch = train[-n_input:].reshape((1, n_input, n_features))
    for i in range(n_input):
        pred_list.append(model.predict(batch)[0])      
        batch = np.append(batch[:,1:,:],[[pred_list[i]]],axis=1)
    from pandas.tseries.offsets import DateOffset
    add_dates = [df.index[-1] + DateOffset(months=x) for x in range(0,7) ]
    future_dates = pd.DataFrame(index=add_dates[1:],columns=df.columns)

    df_predict = pd.DataFrame(scaler.inverse_transform(pred_list),
                          index=future_dates[-n_input:].index, columns=['Prediction'])

    df_proj = pd.concat([df,df_predict], axis=1)
    print(df_predict)
    x = df_predict.to_string(header=False,
                  index=False,
                  index_names=False).split('\n')
    dy=pd.DataFrame()
    dy['year'] = df_predict.index
    x1 = dy.to_string(header=False,
                  index=False,
                  index_names=False).split('\n')
    dates = [','.join(ele.split()) for ele in x1]
    dates1=",".join(map(str,dates))
    vals = [','.join(ele.split()) for ele in x]
    vals1=",".join(map(str,vals))

    mySql_insert_query = "INSERT INTO prediction (sql_id, p_values_1, p_dates) VALUES (1, '"+vals1+"','"+dates1+"') on duplicate key update p_values_"+str(y)+"='"+vals1+"';"

    print(mySql_insert_query)
    cursor = connection.cursor()
    cursor.execute(mySql_insert_query)
    if cursor.lastrowid:
        print('last insert id', cursor.lastrowid)
    else:
        print('last insert id not found')
 
    connection.commit()
# print(df_predict)
    print(df_proj)
    plt.figure(figsize=(20, 5))
    plt.plot(df_proj.index, df_proj[listOfColumnNames[y]])
    plt.plot(df_proj.index, df_proj['Prediction'], color='r')
    plt.legend(loc='best', fontsize='xx-large')
    plt.xticks(fontsize=18)
    plt.yticks(fontsize=16)
    plt.show()
#  
# scaler = MinMaxScaler(feature_range=(0, 1))
# train = scaler.fit_transform(dataset)
# scaler.fit(train)
# train = scaler.transform(train)
# n_input = 6
# n_features = 1
# from keras.preprocessing.sequence import TimeseriesGenerator
# 
# pred_list = []
# 
# batch = train[-n_input:].reshape((1, n_input, n_features))
# 
# for i in range(n_input):   
#     pred_list.append(model.predict(batch)[0]) 
#     batch = np.append(batch[:,1:,:],[[pred_list[i]]],axis=1)
#     
# df_predict = pd.DataFrame(scaler.inverse_transform(pred_list),index=df[-n_input:].index, columns=['Prediction'])
# df_test = pd.concat([df,df_predict], axis=1)    
# 
# 
# generator = TimeseriesGenerator(train, train, length=n_input, batch_size=6)
# model.fit_generator(generator,epochs=25)
# pred_list = []  
# batch = train[-n_input:].reshape((1, n_input, n_features))
# for i in range(n_input):
#     pred_list.append(model.predict(batch)[0])      
#     batch = np.append(batch[:,1:,:],[[pred_list[i]]],axis=1)
#  
# from pandas.tseries.offsets import DateOffset
# add_dates = [df.index[-1] + DateOffset(months=x) for x in range(0,7) ]
# future_dates = pd.DataFrame(index=add_dates[1:],columns=df.columns)
#  
#  
# df_predict = pd.DataFrame(scaler.inverse_transform(pred_list),
#                           index=future_dates[-n_input:].index, columns=['Prediction'])
#  
# valid = pd.concat([df,df_predict], axis=1)
#  
# print(valid)
 
