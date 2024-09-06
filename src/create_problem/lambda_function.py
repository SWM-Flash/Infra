import boto3
import os
import requests
import json

# 환경 변수에서 값을 가져옵니다.
DOMAIN_URL = os.environ['DOMAIN_URL']
API_URL = os.environ['API_URL']

def send_to_backend(image_url, difficulty, gym_id, sector_id):
    image_url_full_path = f"https://{DOMAIN_URL}/{image_url}"
    api_url_full_path = API_URL + f"/gyms/{gym_id}/sectors/{sector_id}/problems"
    data = {
        'imageUrl': image_url_full_path,
        'difficulty': difficulty
    }

    response = requests.post(api_url_full_path, json=data)
    print(f"Response status code: {response.status_code}")
    print(f"Response content: {response.content}")

    return response.json()

def lambda_handler(event, context):
    try:
        body = event
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps(f'Invalid input format: {str(e)}')
        }

    image_url = body.get('image_url')
    difficulty = body.get('difficulty')
    gym_id = body.get('gym_id')
    sector_id = body.get('sector_id')

    if not image_url or not difficulty or not gym_id or not sector_id:
        return {
            'statusCode': 400,
            'body': json.dumps('Missing one or more required fields: image_url, difficulty, gym_id, sector_id')
        }

    try:
        response = send_to_backend(image_url, difficulty, gym_id, sector_id)
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error sending to backend: {str(e)}')
        }

    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }