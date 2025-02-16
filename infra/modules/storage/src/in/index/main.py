import os
import smtplib
import logging
import functions_framework
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# 環境変数から設定を取得
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
SMTP_EMAIL = os.getenv("SMTP_EMAIL")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")
RECIPIENT_EMAIL = os.getenv("RECIPIENT_EMAIL")

# email_data.json の内容を直書き
def load_email_data():
    """email_data.json の内容を直書きで返す"""
    try:
        email_data = {
            "subject": "Test Email via Gmail SMTP",
            "content": "<p>Hello, this is a test email sent via Gmail SMTP!</p>"
        }
        return email_data
    except Exception as e:
        logging.error(f"Error loading email data: {str(e)}")
        return None

@functions_framework.cloud_event
def send_email(cloud_event):
    """Gmail SMTP を使ってメールを送信する"""
    try:
        # email_data.json の内容を直書きで読み込む
        email_info = load_email_data()
        if not email_info:
            logging.error("Failed to load email data")
            return "Error: Failed to load email data"

        # メールの作成
        msg = MIMEMultipart()
        msg["From"] = SMTP_EMAIL
        msg["To"] = RECIPIENT_EMAIL
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
