import requests

def get_data_from_api(url):
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print(f"Failed to retrieve data: {response.status_code}")
        return None

api_url = "http://34.42.212.39/api/books"

data = get_data_from_api(api_url)

if data:
    print("Data retrieved successfully:")
    print(data)
else:
    print("No data retrieved.")
