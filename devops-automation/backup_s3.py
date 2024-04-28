import os
import boto3

S3_BUCKET_NAME = 'assignment-tf-statefile-s3'

BACKUP_DIR = '/home/raushan/Desktop/EKS/bkp'

# Create AWS S3 client
s3 = boto3.client('s3')

response = s3.list_objects_v2(Bucket=S3_BUCKET_NAME)

os.makedirs(BACKUP_DIR, exist_ok=True)
for obj in response.get('Contents', []):
    key = obj['Key']
    local_file_path = os.path.join(BACKUP_DIR, key)
    
    os.makedirs(os.path.dirname(local_file_path), exist_ok=True)

    if not key.endswith('/'):
        s3.download_file(S3_BUCKET_NAME, key, local_file_path)

print(f'Backup completed to: {BACKUP_DIR}')
