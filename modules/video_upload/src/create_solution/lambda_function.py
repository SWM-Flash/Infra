import os

import json
import requests
import os

def send_to_backend(user_info, video_url):
    problem_id = user_info.get('problem_id')
    perceivedDifficulty = user_info.get('perceivedDifficulty')
    review = user_info.get('review')
    token = user_info.get('token')
    
    print(f"Problem ID: {problem_id}")
    print(f"Perceived Difficulty: {perceivedDifficulty}")
    print(f"Review: {review}")
    print(f"Token: {token}")
    print(video_url)
    
    nickname = user_info.get('nickname')
    instagram_id = user_info.get('instagram_id')
    print(f"nickname: {nickname}")
    print(f"instagram_id: {instagram_id}")
    
    thumbnailImageUrl = user_info.get('thumbnailImageUrl')
    solvedDate = user_info.get('solvedDate')
    print(f"thumbnailImageUrl: {thumbnailImageUrl}")
    print(f"solvedDate: {solvedDate}")
    
    problem_info = json.loads(user_info.get('problem_info', '{}'))
    gymId = problem_info.get('gymId')
    sectorId = problem_info.get('sectorId')
    holdId = problem_info.get('holdId')
    difficulty = problem_info.get('difficulty')
    print(f"gymId: {gymId}")
    print(f"sectorId: {sectorId}")
    print(f"holdId: {holdId}")
    print(f"difficulty: {difficulty}")
    
    # 어드민 업로드
    if nickname and instagram_id:
      if gymId:
        problem_create_api_url = os.environ['API_SERVER_URL'] + f"/gyms/{gymId}/sectors/{sectorId}/problems"
        data = {
            "imageUrl": None,
            "difficulty": difficulty,
            "imageSource": nickname,
            "thumbnailSolutionId": None,
            "holdId": holdId
        }
        headers = {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        }
        response = requests.post(problem_create_api_url, json=data, headers=headers)
        print(response.json())
        problem_id = response.json()["id"]

      api_url_full_path = os.environ['API_SERVER_URL'] + f"/admin/problems/{problem_id}/solutions"
      data = {
        "nickName": nickname,
        "instagramId": instagram_id,
        "perceivedDifficulty": perceivedDifficulty,
        "videoUrl": video_url,
        "review": review,
        "thumbnailImageUrl": thumbnailImageUrl,
        "solvedDate": solvedDate
      }
    elif gymId: # 문제를 생성하면서 업로드
        problem_create_api_url = os.environ['API_SERVER_URL'] + f"/gyms/{gymId}/sectors/{sectorId}/problems"
        data = {
            "imageUrl": None,
            "difficulty": difficulty,
            "imageSource": nickname,
            "thumbnailSolutionId": None,
            "holdId": holdId
        }
        headers = {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        }
        response = requests.post(problem_create_api_url, json=data, headers=headers)
        print(response.json())
        problem_id = response.json()["id"]
        
        api_url_full_path = os.environ['API_SERVER_URL'] + f"/problems/{problem_id}/solutions"
        data = {
            "thumbnailImageUrl": thumbnailImageUrl,
            "videoUrl": video_url,
            "solvedDate": solvedDate,
            "perceivedDifficulty": perceivedDifficulty,
            "review": review
        }
        
    else: # 기존 문제에 업로드
      api_url_full_path = os.environ['API_SERVER_URL'] + f"/problems/{problem_id}/solutions"
      data = {
          "thumbnailImageUrl": thumbnailImageUrl,
          "videoUrl": video_url,
          "solvedDate": solvedDate,
          "perceivedDifficulty": perceivedDifficulty,
          "review": review
      }

    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    response = requests.post(api_url_full_path, json=data, headers=headers)
    print(response.json())

    return response.json()

def lambda_handler(event, context):
    try:
        # Assuming 'userMetadata' is correctly accessed
        user_info = event["detail"]["userMetadata"]
        
        # Correcting access to 'outputGroupDetails'
        output_group_details = event["detail"]["outputGroupDetails"]
        
        # Check if outputGroupDetails is a list
        if isinstance(output_group_details, list) and len(output_group_details) > 0:
            # Accessing the first element in the list and then the 'playlistFilePaths'
            playlist_file_paths = output_group_details[0]["playlistFilePaths"]
            
            # Check if playlistFilePaths is a list and not empty
            if isinstance(playlist_file_paths, list) and len(playlist_file_paths) > 0:
                video_url = playlist_file_paths[0]
                # Extracting bucket name and file path
                bucket_name = os.environ['OUTPUT_BUCKET_NAME']
                cloudfront_domain = os.environ['CLOUDFRONT_DOMAIN']
                file_path = video_url.split(f"{bucket_name}/")[1]
                
                # Construct the new URL
                video_url = f"https://{cloudfront_domain}/{file_path}"
            else:
                raise ValueError("playlistFilePaths is empty or not a list")
        else:
            raise ValueError("outputGroupDetails is empty or not a list")
        

        response = send_to_backend(user_info, video_url)
        
        return {
            'statusCode': 200,
            'body': response
        }
        
    except KeyError as e:
        print(f"KeyError: {e}")
        return {
            'statusCode': 400,
            'body': json.dumps(f"Missing key: {e}")
        }
    except ValueError as e:
        print(f"ValueError: {e}")
        return {
            'statusCode': 400,
            'body': json.dumps(f"Value error: {e}")
        }
    except Exception as e:
        print(f"Unexpected error: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps(f"Unexpected error: {e}")
        }