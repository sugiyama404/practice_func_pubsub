import os
import smtplib
import json
import base64
import functions_framework
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import logging

# ログ設定
logging.basicConfig(level=logging.INFO)

SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
SMTP_EMAIL = os.getenv("SMTP_EMAIL")  # 環境変数から取得
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")
RECIPIENT_EMAIL = os.getenv("RECIPIENT_EMAIL")  # 送信先メールアドレス

@functions_framework.cloud_event
def send_email(cloud_event):
    """Gmail SMTP を使ってメールを送信する"""
    try:
        # Pub/Sub メッセージのデコード
        message_data = base64.b64decode(cloud_event.data["message"]["data"]).decode("utf-8")
        logging.info(f"Decoded message: {message_data}")  # メッセージデータをログに出力
        email_info = json.loads(message_data)
        logging.info(f"Email info: {email_info}")  # JSONデータをログに出力

        # メールの作成
        msg = MIMEMultipart()
        msg["From"] = SMTP_EMAIL
        msg["To"] = RECIPIENT_EMAIL  # Terraformで設定した送信先アドレスを使用
        msg["Subject"] = email_info["subject"]
        msg.attach(MIMEText(email_info["content"], "html"))

        # SMTPサーバーへ接続し、メール送信
        with smtplib.SMTP(SMTP_SERVER, SMTP_PORT) as server:
            server.starttls()
            server.login(SMTP_EMAIL, SMTP_PASSWORD)
            server.sendmail(SMTP_EMAIL, RECIPIENT_EMAIL, msg.as_string())

        logging.info(f"Email successfully sent to {RECIPIENT_EMAIL}")
        return f"Email successfully sent to {RECIPIENT_EMAIL}"

    except Exception as e:
        logging.error(f"Error sending email: {str(e)}")
        return f"Error sending email: {str(e)}"
