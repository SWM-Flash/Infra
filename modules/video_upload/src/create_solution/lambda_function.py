import json
import requests
import os

def send_to_backend(user_info, video_url):
    problem_id = user_info.get('problem_id')
    uploader = user_info.get('uploader')
    review = user_info.get('review')
    instagram_id = user_info.get('instagram_id')
    
    print(f"Problem ID: {problem_id}")
    print(f"Uploader: {uploader}")
    print(f"Review: {review}")
    print(f"Instagram ID: {instagram_id}")
    print(video_url)

    api_url_full_path = os.environ['API_SERVER_URL'] + f"/problems/{problem_id}/solutions"
    data = {
      "videoUrl": video_url,
      "uploader": uploader,
      "review": review,
      "instagramId": instagram_id
    }
    response = requests.post(api_url_full_path, json=data)
    print(response)

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