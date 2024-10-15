import json
import boto3
import os

def lambda_handler(event, context):
  
    # API Gateway에서 전달된 파라미터 추출
    body = event

    problem_id = body.get('problem_id', 'unknown')
    video_name = body.get('video_name', 'unknown')
    perceivedDifficulty = body.get('perceivedDifficulty', 'unknown')
    review = body.get('review', 'unknown')
    token = body.get('token', 'unknown')
    
    # 사용자 메타데이터 설정
    job_metadata = {
        'problem_id': problem_id,
        'video_name': video_name,
        'perceivedDifficulty': perceivedDifficulty,
        'review': review,
        'token': token
    }
    
    nickname = body.get('nickname')
    instagramId = body.get('instagramId')
    if nickname and instagramId:
      job_metadata["nickname"] = nickname
      job_metadata["instagram_id"] = instagramId

    # MediaConvert 엔드포인트 가져오기
    mediaconvert_client = boto3.client('mediaconvert')
    endpoints = mediaconvert_client.describe_endpoints()
    endpoint_url = endpoints['Endpoints'][0]['Url']
    
    # MediaConvert 클라이언트의 엔드포인트 설정
    mediaconvert_client = boto3.client('mediaconvert', endpoint_url=endpoint_url)
    

    print(job_metadata)

    # MediaConvert 작업 설정
    job_settings = {
        "TimecodeConfig": {
          "Source": "ZEROBASED"
        },
        "OutputGroups": [
          {
            "Name": "Apple HLS",
            "Outputs": [
              {
                "ContainerSettings": {
                  "Container": "M3U8",
                  "M3u8Settings": {}
                },
                "VideoDescription": {
                  "Height": 360,
                  "CodecSettings": {
                    "Codec": "H_264",
                    "H264Settings": {
                      "MaxBitrate": 1200000,
                      "RateControlMode": "QVBR",
                      "SceneChangeDetect": "TRANSITION_DETECTION"
                    }
                  }
                },
                "AudioDescriptions": [
                  {
                    "CodecSettings": {
                      "Codec": "AAC",
                      "AacSettings": {
                        "Bitrate": 96000,
                        "CodingMode": "CODING_MODE_2_0",
                        "SampleRate": 48000
                      }
                    }
                  }
                ],
                "OutputSettings": {
                  "HlsSettings": {}
                },
                "NameModifier": "640x360_1.2mbps_qvbr"
              },
              {
                "ContainerSettings": {
                  "Container": "M3U8",
                  "M3u8Settings": {}
                },
                "VideoDescription": {
                  "Height": 480,
                  "CodecSettings": {
                    "Codec": "H_264",
                    "H264Settings": {
                      "MaxBitrate": 1500000,
                      "RateControlMode": "QVBR",
                      "SceneChangeDetect": "TRANSITION_DETECTION"
                    }
                  }
                },
                "AudioDescriptions": [
                  {
                    "CodecSettings": {
                      "Codec": "AAC",
                      "AacSettings": {
                        "Bitrate": 96000,
                        "CodingMode": "CODING_MODE_2_0",
                        "SampleRate": 48000
                      }
                    }
                  }
                ],
                "OutputSettings": {
                  "HlsSettings": {}
                },
                "NameModifier": "720x480_1.5mbps_qvbr"
              },
              {
                "ContainerSettings": {
                  "Container": "M3U8",
                  "M3u8Settings": {}
                },
                "VideoDescription": {
                  "Height": 720,
                  "CodecSettings": {
                    "Codec": "H_264",
                    "H264Settings": {
                      "MaxBitrate": 4000000,
                      "RateControlMode": "QVBR",
                      "SceneChangeDetect": "TRANSITION_DETECTION"
                    }
                  }
                },
                "AudioDescriptions": [
                  {
                    "CodecSettings": {
                      "Codec": "AAC",
                      "AacSettings": {
                        "Bitrate": 96000,
                        "CodingMode": "CODING_MODE_2_0",
                        "SampleRate": 48000
                      }
                    }
                  }
                ],
                "OutputSettings": {
                  "HlsSettings": {}
                },
                "NameModifier": "1280x720_4mbps_qvbr"
              }
            ],
            "OutputGroupSettings": {
              "Type": "HLS_GROUP_SETTINGS",
              "HlsGroupSettings": {
                "SegmentLength": 2,
                "Destination": f"s3://{os.environ['OUTPUT_BUCKET_NAME']}/videos/",
                "MinSegmentLength": 0
              }
            }
          }
        ],
        "FollowSource": 1,
        "Inputs": [
          {
            "AudioSelectors": {
              "Audio Selector 1": {
                "DefaultSelection": "DEFAULT"
              }
            },
            "VideoSelector": {
              "Rotate": "AUTO"
            },
            "TimecodeSource": "ZEROBASED",
            "FileInput": f"s3://{os.environ['INPUT_BUCKET_NAME']}/{video_name}"
          }
        ]
    }

    try:
        # MediaConvert 작업 생성
        response = mediaconvert_client.create_job(
            Role=os.environ['MEDIACONVERT_ROLE_ARN'],
            UserMetadata=job_metadata,
            Settings=job_settings,
            Queue=os.environ['MEDIACONVERT_QUEUE_ARN']
        )
        print(f"MediaConvert job created: {response['Job']['Id']}")
    except Exception as e:
        print(f"Error creating MediaConvert job: {str(e)}")

    return {
        'statusCode': 200,
        'body': json.dumps('MediaConvert job created successfully')
    }
