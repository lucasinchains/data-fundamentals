from azure.storage.blob import BlobServiceClient

container_name = 'testcontainer'
connection_string = "DefaultEndpointsProtocol=https;AccountName=storagelucasv;AccountKey=nfshKMTaX1gRybJy+o4SYnrrqJJYAm5ooBwUKaZi7cm0V8PG4w7pQrn40O2qlRGhbJiH2iahS6sm+AStAJFMTA==;EndpointSuffix=core.windows.net"


class Load:
    def toCloud(self, conn_str, container_name, blob_name, upload_file):

        # creats a connection client
        service_client = BlobServiceClient.from_connection_string(conn_str)

        # gets the client to interact with the container in my Azure suscription
        container_client = service_client.get_container_client(container_name)
        # gets the client to interact with the specified blob
        blob_client = container_client.get_blob_client(blob_name)

        # Creates a new blob from a data source with automatic chunking.
        blob_client.upload_blob(upload_file, overwrite=True)
