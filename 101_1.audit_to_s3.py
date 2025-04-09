#-- coding: utf-8 --
import datetime
from datetime import datetime, timedelta
from os import path
import subprocess
import boto3


class s3:
    def __init__(self):
        self.access_key = ''
        self.secret_access = ''
        self.bucket = ''
        self.region = ''
        self.bucket_dir = ''          #####<<<Audit로그 저장할 S3 경로, 프로젝트별로 나눌지 
        
        self.s3_client = boto3.client(
             's3',
            aws_access_key_id=self.access_key,
            aws_secret_access_key=self.secret_access,
            region_name=self.region
        )
        
    def file_upload(self,source,date_str):
        try:
            self.s3_client.upload_file(source, self.bucket, f'{self.bucket_dir}/{date_str}_server_audit.log')
        except Exception as e:
            print(f"An error occurred: {e}")



if __name__ == "__main__":

    ##craete s3 connect instance
    S3Instance = s3()
    
    ##dir ini
    base_dir = f"/data"   ### 데이터베이스 데이터 디렉토리, 
    audit_log = f"/server_audit.log" 
    
    ## MariadbAuditPlugin, PerconaAuditPlugin audit_log 파일 이름이 다름 확인필요
    ## show global variables like '%audit%';    
    ## 위 명령어로 감사로그 파일 경로 및 파일명 확인 가능 
    # Mariadb - server_audit_file_path
    # Mysql(percona plugin) - audit_log_file              
    
    ## server_audit.log-20241202
    
    ## 금일 감사로그 파일명
    backup_date = datetime.now()
    backup_date_str = backup_date.strftime("%Y%m%d")    
    audit_log_file = f"{base_dir}{audit_log}-{backup_date_str}"
    
    ##upload compress backup to s3
    S3Instance.file_upload(audit_log_file,backup_date_str)