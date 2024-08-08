import boto3
import os
import uuid

s3 = boto3.client('s3')
BUCKET_NAME = os.environ['BUCKET_NAME']

def generate_presigned_url(file_name, expiration=3600):
    response = s3.generate_presigned_url('put_object',
                                         Params={'Bucket': BUCKET_NAME,
                                                 'Key': file_name},
                                         ExpiresIn=expiration)
    return response

def lambda_handler(event, context):
    # 고유한 파일 이름 생성
    unique_filename = f"{uuid.uuid4()}.mp4"
    
    # Pre-signed URL 생성
    presigned_url = generate_presigned_url(unique_filename)
    
    return {
        'statusCode': 200,
        'body': {
            'upload_url': presigned_url,
            'file_name': unique_filename
        }
    }
