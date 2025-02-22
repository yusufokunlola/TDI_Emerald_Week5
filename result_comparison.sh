#!/bin/bash

# Define file path and filenames
REPORTS_DIR="reports"
MODEL_RESULTS="${REPORTS_DIR}/baseline_model_results.csv"
OUTPUT_MARKDOWN_FILE="${REPORTS_DIR}/baseline_model_report.md"

# Check if results file exists
if [[ ! -f "$MODEL_RESULTS" ]]; then
    echo "Error: The input file '$MODEL_RESULTS' not found!"
    echo "Please provide the correct file name and retry."
    exit 1
fi

# The model results file should have the following columns: 
# DataVersion, Model, Precision, Recall, F1-Score, ROC-AUC 

# The columns have the following column index:
# 1, 2, 3, 4, 5, 6

# Find best model based on F1-Score using awk and sort
BEST_MODEL=$(awk -F',' 'NR>1 {print $0 | "sort -t, -k5,5nr"}' "$MODEL_RESULTS" | head -n 1)

# How it works:
# 1. awk -F','         -> Split lines by commas
# 2. NR>1              -> Skip header row (NR=Number of Records)
# 3. print $0          -> Print entire line
# 4. sort -t, -k5,5nr  -> Sort by column 5 (F1-Score) numerically in descending order
# 5. head -n 1         -> Take top row (highest F1-Score)

# Extract fields from best model row based on the column index
MODEL_NAME=$(echo "$BEST_MODEL" | awk -F',' '{print $2}')
DATA_VERSION=$(echo "$BEST_MODEL" | awk -F',' '{print $1}')
F1_SCORE=$(echo "$BEST_MODEL" | awk -F',' '{print $5}')
RECALL=$(echo "$BEST_MODEL" | awk -F',' '{print $4}')
PRECISION=$(echo "$BEST_MODEL" | awk -F',' '{print $3}')
ROC_AUC=$(echo "$BEST_MODEL" | awk -F',' '{print $6}')

# Generate confusion matrix filename based on extracted model name and data version
CONFUSION_MATRIX="data${DATA_VERSION}_${MODEL_NAME}_confusion_matrix.png"

# Create markdown report based on the extracted fields
cat << EOF > "$OUTPUT_MARKDOWN_FILE"
# Baseline Model Evaluation

- Model: $MODEL_NAME
- Data Version: $DATA_VERSION

## Metrics
- F1-Score: $F1_SCORE
- Recall: $RECALL
- Precision: $PRECISION
- ROC-AUC: $ROC_AUC

## Confusion Matrix:
![Confusion Matrix]($CONFUSION_MATRIX)
EOF

# Print markdown report was generated successfully
echo "Best Baseline Model Report generated successfully: $OUTPUT_MARKDOWN_FILE"