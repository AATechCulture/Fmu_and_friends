from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
import pandas as pd
# for saving model
from joblib import dump


# Load the expanded dataset into a pandas DataFrame
data = pd.read_csv('flight_data.csv')

# Display the first few rows of the dataframe to confirm
print(data.head())

# Selecting the target variable
target = data['bags_to_cabin']

# Define the features (drop the target variable and non-predictive columns)
features = data.drop(columns=['bags_to_cabin', 'customer_name', 'customer_email', 'customer_phone_number'])

# List of categorical features that need encoding
categorical_features = ['aircraft_type', 'day_of_travel', 'weather', 'season']
numeric_features = features.select_dtypes(include=['float64', 'int64']).columns.tolist()

# Creating a column transformer for preprocessing
preprocessor = ColumnTransformer(
    transformers=[
        ('num', StandardScaler(), numeric_features),
        ('cat', OneHotEncoder(), categorical_features)
    ])

# Creating the logistic regression model
logistic_regression_model = LogisticRegression(max_iter=1000)

# Creating a pipeline that first preprocesses the data and then applies the logistic regression model
pipeline = Pipeline(steps=[('preprocessor', preprocessor),
                           ('classifier', logistic_regression_model)])


# Splitting the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=42)

# Fit the pipeline with the training data
pipeline.fit(X_train, y_train)

# Save the pipeline to a file
dump(pipeline, 'log_re_model.joblib')

# Get probability predictions for the test set
y_pred_proba = pipeline.predict_proba(X_test)[:, 1]  # Probability of 'bags_to_cabin' being 1

# Show the first few probability predictions
print(y_pred_proba[:5])

