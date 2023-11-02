import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from statsmodels.tsa.arima.model import ARIMA
import statsmodels.api as sm
import statsmodels.tsa.api as smt
from statsmodels.tsa.stattools import adfuller
from statsmodels.tsa.seasonal import seasonal_decompose
from statsmodels.tsa.stattools import acf, pacf
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf
from sklearn.metrics import mean_squared_error, mean_absolute_error, mean_absolute_percentage_error
import itertools
import pmdarima as pm
from pmdarima import model_selection
from pmdarima.arima import auto_arima

train_df = pd.read_csv('D:\\BSTU\\4\\4-1\\SaTfIDP (python)\\Labs\\4\\DailyDelhiClimateTrain.csv', parse_dates=['date'], index_col=['date'])
train_df.info()

train_df['meanpressure'].max(), train_df['meanpressure'].min(), train_df['meanpressure'].mean()
print(train_df.loc[train_df['meanpressure'] == train_df['meanpressure'].max()].index)

# уберем ошибки датасета
data_df = train_df[(train_df['meanpressure'] > 950) & (train_df['meanpressure'] < 1090)]

# визуализируем признак
plt.figure(figsize=(16, 5))  
plt.plot(data_df['meantemp'], color='red');
plt.ylabel('meantemp', fontsize=16)
plt.xlabel('Date', fontsize=16)
plt.show()

#Можно сделать вывод, что признак средней температуры обладает сезонностью. Проверим, обладает ли этот признак трендом.
ts_decomposition = seasonal_decompose(x=train_df['meantemp'], model='additive', period=365)

trend_estimate = ts_decomposition.trend
plt.figure(figsize=(15,5))
plt.plot(trend_estimate, label='Trend')
plt.legend()
plt.show()

#По графику видно, что сезонная температура обладает возрастающим трендом.
#Проведем сглаживание временных рядов с помощью модели скользящего среднего ARIMA

train = pd.read_csv('D:\\BSTU\\4\\4-1\\SaTfIDP (python)\\Labs\\4\\DailyDelhiClimateTrain.csv')
train=train[:-100]
test=train[-100:]
# Model Evaluation 
train = pd.read_csv('D:\\BSTU\\4\\4-1\\SaTfIDP (python)\\Labs\\4\\DailyDelhiClimateTrain.csv')

# Fit a simple auto_arima model
arima = pm.auto_arima(train['meantemp'],X=train.drop(columns=['date','meantemp']), d=2,error_action='ignore', trace=True,
                      suppress_warnings=True, maxiter=500,m=4,stationary=False,test='adf')


pred=arima.predict(n_periods=100, X=test.drop(columns=['date','meantemp']), alpha=0.05)

plt.figure(figsize=(15,5))
plt.grid()
plt.plot(train['date'][-100:],test['meantemp'], marker='o', label='Test')
plt.plot(train['date'][-100:],pred, marker='v', label='Prediction')
plt.legend()
plt.xticks(rotation=90)
plt.show()
print("="*50)
print("="*50)
mape=mean_absolute_percentage_error(test['meantemp'], pred)
print("Mean Absolute Percentage Error", mape)
print("="*50)
mse=mean_squared_error(test['meantemp'], pred)
print("Mean Squared Error",mse)
print("="*50)
print("RMSE", (mse)**0.5)
print("="*50)
print("AIC values {}".format(arima.aic()))

#Построим атокорреляцию для ряда
def tsplot(y, lags=None, figsize=(12, 7), style='bmh'):
    if not isinstance(y, pd.Series):
        y = pd.Series(y)
    with plt.style.context(style):    
        fig = plt.figure(figsize=figsize)
        layout = (2, 2)
        ts_ax = plt.subplot2grid(layout, (0, 0), colspan=2)
        acf_ax = plt.subplot2grid(layout, (1, 0), colspan=2)

        y.plot(ax=ts_ax)
        ts_ax.set_title('Time series analysis')
        smt.graphics.plot_acf(y, lags=lags, ax=acf_ax, alpha=0.5)

        print("Dickey-Fuller criterion: p=%f" % sm.tsa.stattools.adfuller(y)[1])

        plt.tight_layout()
        plt.show()
    return 

tsplot(train.meantemp, lags=30)

#На основе полученного критерия Дики-Фуллера (p=0.277412) ряд является нестационарным. Преобразуем его в стационарный.
df_log=np.sqrt(data_df['meanpressure'])
df_diff=df_log.diff().dropna()

result=adfuller (df_diff)
print('p-value: %f' %result[1])
#После обработки p=0.000000, а значит, ряд стационарный.

ts_decomposition = seasonal_decompose(x=train_df['meantemp'], model='additive', period=365)

residual_estimate = ts_decomposition.resid
plt.figure(figsize=(15,5))
plt.plot(residual_estimate, label='Residual')
plt.legend()
plt.show()

ts_decomposition = seasonal_decompose(x=pred, model='additive', period=5)

residual_estimate = ts_decomposition.resid
plt.figure(figsize=(15,5))
plt.plot(residual_estimate, label='Residual')
plt.legend()
plt.show()