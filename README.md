# Baseline Model Selection Project

## Objective

This project automates the selection of the best baseline machine learning model based on F1-Score across seven different data versions. A Bash script processes the results and generates a clear, structured Markdown report highlighting the top-performing model.

## Project Workflow

1. Create a bash script named `result_comparison.sh` that automate model selection by extracting the best model from `baseline_model_results.csv` based on F1-Score.
2. Generate `baseline_model_report.md` with model details, performance metrics, and a confusion matrix image.

## Machine Learning Models

The project evaluates multiple classification models:

* Gaussian Naïve Bayes
* K-Nearest Neighbors
* Linear SVC
* Logistic Regression
* Random Forest Classifier

## Performance Metrics

To assess model performance, we consider:

* Precision
* Recall
* F1-Score
* ROC-AUC
