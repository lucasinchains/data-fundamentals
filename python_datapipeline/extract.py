from azure.storage.blob import BlobServiceClient
import io
import pandas as pd
from collections import OrderedDict


container_name = 'testcontainer'
connection_string = "DefaultEndpointsProtocol=https;AccountName=storagelucasv;AccountKey=nfshKMTaX1gRybJy+o4SYnrrqJJYAm5ooBwUKaZi7cm0V8PG4w7pQrn40O2qlRGhbJiH2iahS6sm+AStAJFMTA==;EndpointSuffix=core.windows.net"


class Extract:
    def fromCSV(self, conn_str, container_name, path: str):
        try:
            service_client = BlobServiceClient.from_connection_string(conn_str)
            blob_client = service_client.get_blob_client(container_name, path)
            blob_data = blob_client.download_blob()
            data = blob_data.content_as_text()

            try:
                df = pd.read_csv(io.StringIO(data))
            except Exception as ex:
                print('Looks like its not a CSV file: ', ex)
            else:
                dd = OrderedDict()
                result = df.to_dict('records', into=dd)
                return result

        except Exception as ex:
            print('Looks like the file does not exist: ', ex)

    def fromJSON(self, conn_str, container_name, path: str):
        try:
            service_client = BlobServiceClient.from_connection_string(conn_str)
            blob_client = service_client.get_blob_client(container_name, path)
            blob_data = blob_client.download_blob()
            data = blob_data.content_as_text()

            try:
                df = pd.read_json(io.StringIO(data))
            except Exception as ex:
                return print('Looks like its not a JSON file: ', ex)
            else:
                dd = OrderedDict()
                result = df.to_dict('records', into=dd)
                return result

        except Exception as ex:
            print('Looks like the file does not exist: ', ex)
