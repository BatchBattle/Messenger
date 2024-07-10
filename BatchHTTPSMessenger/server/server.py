from flask import Flask, request, jsonify
import datetime
import os

app = Flask(__name__)

MESSAGE_FILE = 'messages'
USERLOG_FILE = 'userLogs'

def append_to_file(filename, content):
    with open(filename, 'a') as file:
        file.write(content + '\n')

def read_file(filename):
    if os.path.exists(filename):
        with open(filename, 'r') as file:
            return file.readlines()
    return []

def truncate_file(filename, lines_to_keep):
    lines = read_file(filename)
    if len(lines) > lines_to_keep:
        with open(filename, 'w') as file:
            file.writelines(lines[-lines_to_keep:])

@app.route('/send_message', methods=['POST'])
def send_message():
    data = request.get_json()
    username = data.get('username')
    message_text = data.get('message')
    
    if not username or not message_text:
        return jsonify({'error': 'Invalid input'}), 400

    message_entry = f"{username}: {message_text}"
    append_to_file(MESSAGE_FILE, message_entry)
    truncate_file(MESSAGE_FILE, 50)
    return jsonify({'status': 'Message sent'})

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    
    if not username:
        return jsonify({'error': 'Invalid input'}), 400

    login_entry = f"{username} Joined the chatroom ({datetime.datetime.now().strftime('%H:%M:%S.%f::%a %m/%d/%Y')})"
    append_to_file(USERLOG_FILE, login_entry)
    truncate_file(USERLOG_FILE, 10)
    return jsonify({'status': 'Login recorded'})

@app.route('/get_logs', methods=['GET'])
def get_logs():
    messages = read_file(MESSAGE_FILE)
    userlogs = read_file(USERLOG_FILE)
    
    return jsonify({
        'messages': messages,
        'userlogs': userlogs
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
