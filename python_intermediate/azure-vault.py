# pip install azure.identity
# pip install azure.keyvault
from azure.identity import DefaultAzureCredential, ClientSecretCredential
from azure.keyvault.secrets import SecretClient

keyvault_url = "https://trainkeyvaultc339.vault.azure.net/"
secret_name = "StorageKeyc339"

credential = DefaultAzureCredential()
client = SecretClient(vault_url=keyvault_url, credential=credential)

secret_value = client.get_secret(secret_name).value
print(f"the secret value ois {secret_value}")
keyvault_url = "https://trainkeyvaultc339.vault.azure.net/"
secret_name = "StorageKeyc339"

tenant_id = "6bfea97f-d038-4c9b-aca7-60b782f3214e"
client_id = "2509dcf5-8485-4ed6-9000-733af5e0cedc"
client_secret = "snz8Q~vrU3_PSRU3jylqsZ8awul5VVqs3OKhVcuH"

credential = ClientSecretCredential(
    tenant_id=tenant_id, client_id=client_id, client_secret=client_secret)
client = SecretClient(vault_url=keyvault_url, credential=credential)

secret_value = client.get_secret(secret_name).value
print(f"the secret value ois {secret_value}")
