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
register_matplotlib_converters()
import mysql.connector
from mysql.connector import Error
import pandas as pd

connection = mysql.connector.connect(host='localhost',
                                    database='sys',
                                    user='root',
                                    password='123456',
                                    auth_plugin='mysql_native_password')

id = sys.argvs;
sql_select_Query = "SELECT sql_query FROM querytable where id=%s;"
cursor = connection.cursor(buffered=True)
cursor.execute(sql_select_Query, (id,))
record = cursor.fetchone()
for row in record:
    sql_select_Query = row
    print(row)
print(sql_select_Query)
# sql_select_Query="SELECT concat( year,Month) as Date , unit_price  as data FROM oildata"
df = pd.read_sql(sql_select_Query, connection);
 
columnsNamesArr = df.columns.values
    
listOfColumnNames = list(columnsNamesArr)
print(listOfColumnNames)
print(len(listOfColumnNames))
for y in range(1, len(listOfColumnNames)):
    df1=df.iloc[:,[0,y]]
    df1[listOfColumnNames[0]] = pd.to_datetime(df.iloc[:, 0], format='%Y-%m')   
    print( df1[listOfColumnNames[y]][:2])
#     df['Date'] = pd.to_datetime(df['Date'])
    df1.set_index(listOfColumnNames[0], inplace=True)
# 
    data = df1.sort_index(ascending=True, axis=0) 
    from pmdarima.arima import auto_arima

# split into train and test sets
    train_size = int(len(df1) * 0.80)
    test_size = len(df1) - train_size

    train = data[listOfColumnNames[y]][:train_size]
    valid = data[listOfColumnNames[y]][train_size:]

    valid.is_copy = False

    print(len(train), len(valid)) 
 
#     training = train[listOfColumnNames[y]]
#     validation = valid[listOfColumnNames[y]]
#  
# model = auto_arima(training, start_p=1, start_q=1,max_p=3, max_q=3, m=12,start_P=0, seasonal=False,d=1, D=1, trace=True,error_action='ignore',suppress_warnings=True)
# # model = auto_arima(training,seasonal=True,trace=True,error_action='ignore',suppress_warnings=True)
# model.fit(training)
# forecast = model.predict(n_periods=test_size)
# # rms=np.sqrt(np.mean(np.power((np.array(valid['Close'])-np.array(forecast['Prediction'])),2)))
# last_row = df.iloc[-1]
# print(last_row)
#  
# last_date = pd.DataFrame()
#  
# last_date['Predictions'] = 0
#  
# # last_date['Date'] = pd.date_range(last_row['Date'], periods = 12, freq ='M')
# # last_date.set_index('Date',inplace=True)
# # print(last_date)
# # print( last_date.index)
# forecast = pd.DataFrame(forecast,index = valid.index,columns=['Prediction'])
# plt.plot(train['data'])
# plt.plot(valid['data'])
# print(forecast)
# plt.plot(forecast['Prediction'])
# plt.show()
# 

    from sklearn.preprocessing import MinMaxScaler
    from keras.models import Sequential
    from keras.layers import Dense, Dropout, LSTM

    from keras.callbacks import ModelCheckpoint, EarlyStopping
    print(data)
    train_size = int(len(df1) * 0.80)
    test_size = len(df1) - train_size
    train = data[0:train_size]
    valid = data[train_size:]

# converting dataset into x_train and y_train
    scaler = MinMaxScaler(feature_range=(0, 1))
    scaled_data = scaler.fit_transform(data)

    x_train, y_train = [], []
    for i in range(6, len(train)):
            x_train.append(scaled_data[i - 6:i, 0])
            y_train.append(scaled_data[i, 0])
    x_train, y_train = np.array(x_train), np.array(y_train)

    x_train = np.reshape(x_train, (x_train.shape[0], x_train.shape[1], 1))


    def get_val():
        X1, y1 = [], []
        print(train_size + 6)
        print(len(df))
        for i in range(train_size + 6, len(df)):   
            X1.append(scaled_data[i - 6:i, 0])
            y1.append(scaled_data[i, 0])
        X1, y1 = np.array(X1), np.array(y1)
        print(X1)
        print(len(X1))
        X1 = np.reshape(X1, (X1.shape[0], X1.shape[1], 1))
        return X1, y1
 
 
    valX, valY = get_val()
# create and fit the LSTM network
    from pandas import DataFrame
    train1 = DataFrame()
    val1 = DataFrame()
# for i in range(5):
    model = Sequential()
    model.add(LSTM(units=300, return_sequences=True, input_shape=(x_train.shape[1], 1)))
    model.add(LSTM(units=25))
    model.add(Dropout(0.15))
    model.add(Dense(1))

    model.compile(loss='mean_squared_error', optimizer='adam')
    history_callback = model.fit(x_train, y_train, epochs=80, batch_size=12, validation_data=(valX, valY), verbose=1)

    loss_history = history_callback.history["loss"]
    train1[str(i)] = pd.Series(history_callback.history['loss'])
    val1[str(i)] = pd.Series(history_callback.history['val_loss'])
# plot train and validation loss across multiple runs
    plt.plot(train1, color='blue', label='train')
    plt.plot(val1, color='orange', label='validation')
    plt.title('model train vs validation loss')
    plt.ylabel('loss')
    plt.xlabel('epoch')
    plt.show()
# predicting 246 values, using past 60 from the train data
    inputs = data[len(data) - len(valid) - 6:].values
    inputs = inputs.reshape(-1, 1)
    inputs = scaler.transform(inputs)

    X_test = []
    for i in range(6, inputs.shape[0]):
        X_test.append(inputs[i - 6:i, 0])
    X_test = np.array(X_test)

    print("-----------------")
    print(X_test)
    X_test = np.reshape(X_test, (X_test.shape[0], X_test.shape[1], 1))

    closing_price = model.predict(X_test)
    print("----------------+++==-")
    print(len(closing_price))
    closing_price = scaler.inverse_transform(closing_price)

    rms = np.sqrt(np.mean(np.power((valid - closing_price), 2)))
    print(rms)
    train = data[:train_size]
    valid = data[train_size:]
    valid['Predictions'] = closing_price

# last_date['Predictions']=closing_price
    plt.plot(train[listOfColumnNames[y]])
    plt.plot(valid[[listOfColumnNames[y], 'Predictions']])
    plt.show()
# save the model to disk.=
    import pickle
    dateTimeObj = datetime.now()
    date_time = dateTimeObj.strftime("%m-%d-%Y_%H-%M-%S")
    filename = "Query_"+str(id)+"_ p_value_"+str(y)+"_"+date_time
    pickle.dump(model, open(filename, 'wb'))
    print(valid[[listOfColumnNames[y], 'Predictions']])
    mySql_insert_query = "INSERT INTO prediction_model (sql_id, p_value_"+str(y)+") VALUES ("+str(id)+",'"+filename+"')ON DUPLICATE KEY UPDATE  p_value_"+str(y)+"='"+filename+"';"
    cursor.execute(mySql_insert_query)
    connection.commit()
 
connection.commit()
###############
# train = df
# print(train)
# from keras.preprocessing.sequence import TimeseriesGenerator
# scaler.fit(train)
# train = scaler.transform(train)
# n_input = 6
# n_features = 1
# generator = TimeseriesGenerator(train, train, length=n_input, batch_size=12)
# model.fit_generator(generator,epochs=30)
# pred_list = []  
# batch = train[-n_input:].reshape((1, n_input, n_features))
# for i in range(n_input):
#     pred_list.append(model.predict(batch)[0])      
#     batch = np.append(batch[:,1:,:],[[pred_list[i]]],axis=1)
# 
# 
# from pandas.tseries.offsets import DateOffset
# add_dates = [df.index[-1] + DateOffset(months=x) for x in range(0,7) ]
# future_dates = pd.DataFrame(index=add_dates[1:],columns=df.columns)
# 
# df_predict = pd.DataFrame(scaler.inverse_transform(pred_list),
#                           index=future_dates[-n_input:].index, columns=['Prediction'])
# 
# df_proj = pd.concat([df,df_predict], axis=1)
# 
# print(df_proj)
#  
# plt.figure(figsize=(20, 5))
# plt.plot(df_proj.index, df_proj['data'])
# plt.plot(df_proj.index, df_proj['Prediction'], color='r')
# plt.legend(loc='best', fontsize='xx-large')
# plt.xticks(fontsize=18)
# plt.yticks(fontsize=16)
# plt.show()
# #  
# # scaler = MinMaxScaler(feature_range=(0, 1))
# # train = scaler.fit_transform(dataset)
# # scaler.fit(train)
# # train = scaler.transform(train)
# # n_input = 6
# # n_features = 1
# # from keras.preprocessing.sequence import TimeseriesGenerator
# # 
# # pred_list = []
# # 
# # batch = train[-n_input:].reshape((1, n_input, n_features))
# # 
# # for i in range(n_input):   
# #     pred_list.append(model.predict(batch)[0]) 
# #     batch = np.append(batch[:,1:,:],[[pred_list[i]]],axis=1)
# #     
# # df_predict = pd.DataFrame(scaler.inverse_transform(pred_list),index=df[-n_input:].index, columns=['Prediction'])
# # df_test = pd.concat([df,df_predict], axis=1)    
# # 
# # 
# # generator = TimeseriesGenerator(train, train, length=n_input, batch_size=6)
# # model.fit_generator(generator,epochs=25)
# # pred_list = []  
# # batch = train[-n_input:].reshape((1, n_input, n_features))
# # for i in range(n_input):
# #     pred_list.append(model.predict(batch)[0])      
# #     batch = np.append(batch[:,1:,:],[[pred_list[i]]],axis=1)
# #  
# # from pandas.tseries.offsets import DateOffset
# # add_dates = [df.index[-1] + DateOffset(months=x) for x in range(0,7) ]
# # future_dates = pd.DataFrame(index=add_dates[1:],columns=df.columns)
# #  
# #  
# # df_predict = pd.DataFrame(scaler.inverse_transform(pred_list),
# #                           index=future_dates[-n_input:].index, columns=['Prediction'])
# #  
# # valid = pd.concat([df,df_predict], axis=1)
# #  
# # print(valid)
#  
# plt.plot(df['data'])
# plt.plot(valid['Prediction'])
# plt.show()


# return training data
def get_train(): 
    X1, y1 = list(), list()  
    for i in range(6, len(train)):   
       X1.append(scaled_data[i - 6:i, 0])
       y1.append(scaled_data[i, 0])
    X1, y1 = np.array(X1), np.array(y1)
    print(X1)
    print(len(X1))
    X1 = np.reshape(X1, (X1.shape[0], X1.shape[1], 1))
    return X1, y1

 
# return validation data
def get_val():
    X1, y1 = [], []
    print(train_size + 6)
    print(len(df))
    for i in range(train_size + 6, len(df)):   
        X1.append(scaled_data[i - 6:i, 0])
        y1.append(scaled_data[i, 0])
    X1, y1 = np.array(X1), np.array(y1)
    print(X1)
    print(len(X1))
    X1 = np.reshape(X1, (X1.shape[0], X1.shape[1], 1))
    return X1, y1


X2, y2 = get_train()
print(X2)
print(y2)
valX, valY = get_val()

print(valX)
print(valY)
