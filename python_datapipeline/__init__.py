# importing classes from the same directory
from datapipeline.extract import Extract
from datapipeline.transform import Transform
from datapipeline.load import Load

# azure cloud storage credentials
container_name = 'testcontainer'
connection_string = "DefaultEndpointsProtocol=https;AccountName=storagelucasv;AccountKey=nfshKMTaX1gRybJy+o4SYnrrqJJYAm5ooBwUKaZi7cm0V8PG4w7pQrn40O2qlRGhbJiH2iahS6sm+AStAJFMTA==;EndpointSuffix=core.windows.net"

# initializing the classes
e = Extract()
t = Transform()
l = Load()


# extracting a json file from the cloud
dataset = e.fromJSON(connection_string, container_name, 'EmployeeData.json')

copy_EmployeeData = t.transform(dataset, 'csv')  # converting it into csv

l.toCloud(connection_string, container_name, 'copyEmployeeData.csv',
          copy_EmployeeData)  # uploading a new blob into the cloud
