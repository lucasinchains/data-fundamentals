from azure.storage.blob import BlobServiceClient
import pandas as pd
from collections import OrderedDict

container_name = 'testcontainer'
connection_string = "DefaultEndpointsProtocol=https;AccountName=storagelucasv;AccountKey=nfshKMTaX1gRybJy+o4SYnrrqJJYAm5ooBwUKaZi7cm0V8PG4w7pQrn40O2qlRGhbJiH2iahS6sm+AStAJFMTA==;EndpointSuffix=core.windows.net"


class Transform:
    def head(self, dataset: OrderedDict, step):  # return the top N records from the dataset
        return dataset[:step]

    def tail(self, dataset: OrderedDict, step):  # return the last N records from the dataset
        return dataset[:step]

    # rename a column in the dataset
    def rename_attribute(self, dataset: OrderedDict, old: str, new: str):
        df = pd.DataFrame(dataset, columns=dataset[0].keys())
        df = df.rename(columns={old: new})
        dd = OrderedDict()
        dataset = df.to_dict('records', into=dd)
        return dataset

    # remove a column from the dataset
    def remove_attribute(self, dataset: OrderedDict, attr: str):
        df = pd.DataFrame(dataset, columns=dataset[0].keys())
        del df[attr]
        dd = OrderedDict()
        dataset = df.to_dict('records', into=dd)
        return dataset

    # rename a list of columns in the dataset. Pass in the list all columns in order.
    def rename_attributes(self, dataset: OrderedDict, new: list):
        df = pd.DataFrame(dataset, columns=dataset[0].keys())
        df = df.set_axis(new, axis=1)
        dd = OrderedDict()
        dataset = df.to_dict('records', into=dd)
        return dataset

    # remove a list of columns in the dataset
    def remove_attributes(self, dataset: OrderedDict, columns: list):
        df = pd.DataFrame(dataset, columns=dataset[0].keys())
        df = df.drop(columns, axis=1)
        dd = OrderedDict()
        dataset = df.to_dict('records', into=dd)
        return dataset

    # returns a file with the specified transformation
    def transform(self, dataset, form: str):
        df = pd.DataFrame(dataset, columns=dataset[0].keys())
        if form == 'csv':
            df = df.to_csv(index=False)
        if form == 'json':
            df = df.to_json()
        if form != 'json' or form != 'csv':
            print('form must be type json or ')

        return df
