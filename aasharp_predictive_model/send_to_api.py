from flask import Flask, request, jsonify
from joblib import load


from predict_probability import predict_probability

# cmd: flask --app send_to_api run

app = Flask(__name__)

# Load the trained model (as shown above)
pipeline = load('log_re_model.joblib')

@app.route('/predict', methods=['POST'])
def predict():
    input_data = request.get_json()
    probability = predict_probability(input_data)
    return jsonify({'probability': probability})

if __name__ == '__main__':
    app.run(debug=True)
