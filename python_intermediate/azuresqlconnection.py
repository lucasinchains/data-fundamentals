# CONNECT TO A AZURE SQL DATABASE

import pyodbc  # importing pyodbc library to work with pyodbc class
import pandas as pd

# creates an connection with connect() method (instance of pyodbc class)
cn = pyodbc.connect(
    "Driver={ODBC Driver 18 for SQL Server};Server=tcp:lvtestserver.database.windows.net,1433;Database=lucasvdb;Uid=lucasvitantonio;Pwd=lucas089Vita.;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;")
# store the query into query variable
query = "SELECT productID, Name, ListPrice, SellStartDate FROM SalesLT.Product WHERE ListPrice > (SELECT AVG(ListPrice) FROM SalesLT.Product) ORDER BY ListPrice DESC"

# creating cursor and executing query inside the 'with cn:' allows me to run queries with the same connection without having to close the conn.
with cn:
    # creates a cursor to work with
    cursor = cn.cursor()
    # executes query
    cursor.execute(query)

# creates and stores the query into a table called 'table'
# read_sql() takes 2 param, the query string and the connection instance
table = pd.read_sql(query, cn)
print(table)
table.info()
