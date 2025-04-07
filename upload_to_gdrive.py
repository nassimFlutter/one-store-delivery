import os
import base64
import json
import requests
from google.oauth2.service_account import Credentials
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
from datetime import datetime
import yaml
def get_flutter_version(pubspec_path='pubspec.yaml'):
    with open(pubspec_path, 'r') as f:
        pubspec = yaml.safe_load(f)
        return pubspec.get('version', 'unknown')
def authenticate_gdrive():
    base64_creds = os.environ.get('GDRIVE_CREDENTIALS')
    if not base64_creds:
        raise Exception("GDRIVE_CREDENTIALS not found in environment variables")

    creds_json = base64.b64decode(base64_creds).decode('utf-8')
    with open('credentials.json', 'w') as f:
        f.write(creds_json)

    creds = Credentials.from_service_account_file('credentials.json')
    return build('drive', 'v3', credentials=creds)

def upload_file(service, file_path, custom_name, drive_folder_id="1FqYGSdhQML5Fg3lwsdjQSdKldkHsbfhc"):
    file_metadata = {
        'name': custom_name,
        'parents': [drive_folder_id] if drive_folder_id else []
    }
    media = MediaFileUpload(file_path, resumable=True)
    file = service.files().create(
        body=file_metadata,
        media_body=media,
        fields='id, webViewLink'
    ).execute()
    print(f"File ID: {file.get('id')} uploaded successfully.")
    
    permission = {'type': 'anyone', 'role': 'reader'}
    service.permissions().create(fileId=file.get('id'), body=permission).execute()

    return file.get('webViewLink')

def send_telegram_message(message, telegram_token):
    url = f"https://api.telegram.org/bot{telegram_token}/sendMessage"
    # Use getUpdates method to fetch your user ID dynamically
    response = requests.get(f"https://api.telegram.org/bot{telegram_token}/getUpdates")
    if response.status_code != 200:
        raise Exception(f"Failed to get updates: {response.text}")
    
    updates = response.json().get('result', [])
    if updates:
        chat_id = updates[0]['message']['chat']['id']  # Default to first chat if no specific chat ID is set
    else:
        raise Exception("No chat found for bot to send message.")

    payload = {'chat_id': chat_id, 'text': message}
    response = requests.post(url, json=payload)
    if response.status_code != 200:
        raise Exception(f"Failed to send message: {response.text}")
    print("Message sent successfully to Telegram.")
    return response.json()['result']['message_id']

def send_telegram_file(file_path, telegram_token, custom_file_name):
    url = f"https://api.telegram.org/bot{telegram_token}/sendDocument"
    # Use getUpdates method to fetch your user ID dynamically
    response = requests.get(f"https://api.telegram.org/bot{telegram_token}/getUpdates")
    if response.status_code != 200:
        raise Exception(f"Failed to get updates: {response.text}")
    
    updates = response.json().get('result', [])
    if updates:
        chat_id = updates[0]['message']['chat']['id']  # Default to first chat if no specific chat ID is set
    else:
        raise Exception("No chat found for bot to send file.")

    with open(file_path, 'rb') as file:
        response = requests.post(url, data={'chat_id': chat_id}, files={'document': (custom_file_name, file)})
    if response.status_code != 200:
        raise Exception(f"Failed to send file: {response.text}")
    print("File sent successfully to Telegram.")
    return response.json()['result']['message_id']

def sanitize_filename(filename):
    return filename.replace(':', '_').replace('/', '_')

if __name__ == '__main__':
    telegram_token = os.environ.get('TELEGRAM_BOT_TOKEN')
    current_date = datetime.now().strftime("%-d-%-m-%Y")
    flutter_version = get_flutter_version()
    # Paths and custom names
    apk_path = 'build/app/outputs/flutter-apk/app-release.apk'
    apk_name = sanitize_filename(f"one store delivery-APK_{flutter_version}_{current_date}.apk")

    aab_path = 'build/app/outputs/bundle/release/app-release.aab'
    aab_name = sanitize_filename(f"one store delivery-AAB_1.0.2+1_{current_date}.aab")

    gdrive_service = authenticate_gdrive()

    # Upload APK and send notifications
    apk_drive_link = upload_file(gdrive_service, apk_path, apk_name)
    send_telegram_message(f"✅ one store delivery APK uploaded successfully!\nGoogle Drive Link: {apk_drive_link}", telegram_token)
    send_telegram_file(apk_path, telegram_token, apk_name)

    # Upload AAB and send notifications
    # aab_drive_link = upload_file(gdrive_service, aab_path, aab_name)
    # send_telegram_message(f"✅ Weisro AAB uploaded successfully!\nGoogle Drive Link: {aab_drive_link}", telegram_token)
    # send_telegram_file(aab_path, telegram_token, aab_name)
