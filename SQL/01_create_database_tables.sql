
-- Customer Churn Analysis Project
-- Step 1: Create database

CREATE DATABASE IF NOT EXISTS customer_churn_analysis;

USE customer_churn_analysis;

-- Step 2: Create the raw data table if it does not exist
-- This definition matches the imported Telco dataset.

CREATE TABLE IF NOT EXISTS customer_churn_analysis_raw (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DOUBLE,
    TotalCharges DOUBLE,
    Churn VARCHAR(10)
);

-- Step 3: Verify the table exists
SHOW TABLES;

-- Step 4: Verify the table structure
DESCRIBE customer_churn_analysis_raw;
