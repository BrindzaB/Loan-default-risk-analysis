# Loan Default Risk Analysis

An end-to-end data science portfolio project focused on predicting **Probability of Default (PD)** for consumer loans and turning model outputs into business-ready analytics.

## Project Goal

Estimate loan default risk at the individual-loan level and build a workflow that connects:

- `Python` for data prep and machine learning
- `SQL` for analytical deep-dives
- `Tableau` for stakeholder-friendly visualization

## Current Status

Implemented:

- Data loading and quality checks
- Logistic Regression baseline model
- Scikit-learn `Pipeline` for preprocessing + modeling
- Model persistence with `joblib`
- Full-dataset scoring notebook
- Exported risk scores (`LoanID`, `risk_score`) for downstream analytics

Not implemented yet (planned next):

- Advanced SQL analysis layer (CTEs, window functions, segmentation, deciles)
- Tableau dashboard to visualize key findings and risk patterns

## Repository Structure

```text
.
├── data/
│   ├── Loan_default.csv
│   └── loan_risk_scores.csv
├── PD_modeling_updated.ipynb
├── PD_scoring.ipynb
└── pd_pipeline.joblib
```

## Modeling Workflow (Implemented)

1. Load and inspect loan dataset
2. Split into train/test with stratification
3. Exclude `LoanID` from model features
4. Build preprocessing with:
   - `StandardScaler` for numeric variables
   - `OneHotEncoder(handle_unknown="ignore", drop="if_binary")` for categorical/binary variables
5. Train Logistic Regression in a single `Pipeline`
6. Evaluate with ROC-AUC
7. Save fitted pipeline artifact via `joblib`

## Scoring Workflow (Implemented)

1. Load saved artifact (`pd_pipeline.joblib`)
2. Read full dataset
3. Keep `LoanID` for downstream joins
4. Score all rows with `predict_proba(... )[:, 1]`
5. Save predictions to `data/loan_risk_scores.csv`

Output format:

- `LoanID`: primary key
- `risk_score`: predicted probability of default (0 to 1)

## Why This Matters

The generated `risk_score` table can be joined back to the original loan dataset by `LoanID`, enabling:

- risk decile analysis
- segment-level default behavior analysis
- business dashboards for monitoring portfolio quality

## Next Steps (To Complete Full Workflow)

### 1) SQL Analytics Layer

Build SQL queries to answer portfolio risk questions, for example:

- Default rate by risk decile (`NTILE(10)`)
- Segment comparisons (employment type, education, loan purpose, etc.)
- Distribution and concentration of high-risk loans
- Aggregations with CTEs and window functions

### 2) Tableau Dashboard

Create an interactive dashboard with:

- KPI cards (avg risk score, default rate, high-risk share)
- Risk score distribution
- Default rate by decile
- Segment breakdowns and filters

## Tech Stack

- Python (Pandas, scikit-learn, Joblib)
- SQL (advanced queries with CTEs/window functions) *(planned)*
- Tableau *(planned)*

## Project Roadmap

- [x] Baseline ML model and scoring pipeline
- [x] Full-dataset risk score generation
- [ ] SQL analytical layer
- [ ] Tableau dashboard
- [ ] Final insights/recommendations summary

## Notes

- `Pipeline` guarantees consistent preprocessing between training and scoring.
- `joblib` allows training once and reusing the exact fitted model artifact.
- `LoanID` is not a model input; it is retained for joining predictions back to source data.

