from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "<h1>Deployment Successful!</h1><p>Hello from SavyOps AI! Your Python application is running on AWS EC2.</p>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
