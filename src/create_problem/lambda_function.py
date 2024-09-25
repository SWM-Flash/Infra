import boto3
import os
import requests
import json

# 환경 변수에서 값을 가져옵니다.
DOMAIN_URL = os.environ['DOMAIN_URL']
API_URL = os.environ['API_URL']

def send_to_backend(image_url, difficulty, image_source, gym_id, sector_id, token):
    image_url_full_path = f"https://{DOMAIN_URL}/{image_url}"
    api_url_full_path = API_URL + f"/admin/gyms/{gym_id}/sectors/{sector_id}/problems"
    data = {
        'imageUrl': image_url_full_path,
        'difficulty': difficulty,
        'imageSource': image_source
    }
    
    headers = {
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    }

    response = requests.post(api_url_full_path, json=data, headers=headers)
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
    image_source = body.get('image_source')
    gym_id = body.get('gym_id')
    sector_id = body.get('sector_id')
    token = body.get('token')

    if not image_url or not difficulty or not image_source or not gym_id or not sector_id or not token:
        return {
            'statusCode': 400,
            'body': json.dumps('Missing one or more required fields: image_url, difficulty, gym_id, sector_id')
        }

    try:
        response = send_to_backend(image_url, difficulty, image_source, gym_id, sector_id, token)
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error sending to backend: {str(e)}')
        }

    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }