from joblib import load
import pandas as pd
# Load the saved model
pipeline = load('log_re_model.joblib')

def predict_probability(input_data):
    # Convert input data to DataFrame
    df = pd.DataFrame([input_data])
    # Make prediction
    probability = pipeline.predict_proba(df)[0][1]
    return probability
