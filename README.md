# Loan Default Risk Analysis

[![Status](https://img.shields.io/badge/Status-In%20Progress-yellow?style=flat-square)](#completed-work)
[![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=flat-square&logo=python&logoColor=white)](https://www.python.org/)
[![scikit--learn](https://img.shields.io/badge/scikit--learn-ML-F7931E?style=flat-square&logo=scikitlearn&logoColor=white)](https://scikit-learn.org/)
[![MySQL](https://img.shields.io/badge/MySQL-SQL%20Analysis-4479A1?style=flat-square&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Tableau](https://img.shields.io/badge/Tableau-Visualization-E97627?style=flat-square&logo=tableau&logoColor=white)](https://public.tableau.com/)

End-to-end credit risk portfolio project using Python, SQL, and Tableau:

- train a Probability of Default (PD) model
- score the full portfolio
- analyze risk behavior with SQL
- visualize portfolio and model insights in Tableau

## Project Workflow

1. **Modeling in Python**
2. **Scoring all loans with saved pipeline**
3. **SQL analytics layer for portfolio and model validation**
4. **Tableau dashboard for final communication**

## Completed Work

### 1) Python Modeling and Scoring

- Logistic Regression PD model in `PD_modeling_updated.ipynb`
- Preprocessing + model bundled in sklearn `Pipeline`
- Fitted artifact saved as `pd_pipeline.joblib`
- Full portfolio scoring in `PD_scoring.ipynb`
- Exported scored data: `data_raw/loan_risk_scores.csv`

### 2) SQL Analytics

SQL scripts:

- `sql/00.joined_view.sql`
- `sql/01.portfolio_overview.sql`
- `sql/02.risk_decile_analysis.sql`
- `sql/03.risk_analysis_by_segments.sql`
- `sql/04.top_expected_loss_loans.sql`
- `sql/05.cutoff_simulation.sql`

Exported analysis outputs for Tableau:

- `data_analytics/portfolio_overview_kpis.csv`
- `data_analytics/risk_decile_overview_new.csv`
- `data_analytics/risk_by_segments_overview.csv`
- `data_analytics/top_expeced_loss_loans.csv`
- `data_analytics/cutoff_simulation.csv`

### 3) Tableau Dashboard

- Workbook: `Loan_default_risk_vizualisation.twb`
- Uses SQL-generated CSV files from `data_analytics/`

## Repository Structure

```text
.
├── PD_modeling_updated.ipynb
├── PD_scoring.ipynb
├── pd_pipeline.joblib
├── sql/
│   ├── 00.joined_view.sql
│   ├── 01.portfolio_overview.sql
│   ├── 02.risk_decile_analysis.sql
│   ├── 03.risk_analysis_by_segments.sql
│   ├── 04.top_expected_loss_loans.sql
│   └── 05.cutoff_simulation.sql
├── data_raw/
│   ├── Loan_default.csv
│   └── loan_risk_scores.csv
├── data_analytics/
│   ├── portfolio_overview_kpis.csv
│   ├── risk_decile_overview_new.csv
│   ├── risk_by_segments_overview.csv
│   ├── top_expeced_loss_loans.csv
│   └── cutoff_simulation.csv
└── Loan_default_risk_vizualisation.twb
```

## Tableau Screenshot

![Dashboard Overview](assets/tableau/overview.png)
![Cutoff Simulation](assets/tableau/cutoff.png)

## Tech Stack

### Core Tools

[![Pandas](https://img.shields.io/badge/Pandas-Data%20Processing-150458?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![NumPy](https://img.shields.io/badge/NumPy-Numerical%20Computing-013243?style=for-the-badge&logo=numpy&logoColor=white)](https://numpy.org/)
[![scikit--learn](https://img.shields.io/badge/scikit--learn-Modeling-F7931E?style=for-the-badge&logo=scikitlearn&logoColor=white)](https://scikit-learn.org/)
[![MySQL](https://img.shields.io/badge/MySQL-CTEs%20%26%20Window%20Functions-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Tableau Public](https://img.shields.io/badge/Tableau%20Public-Dashboard-E97627?style=for-the-badge&logo=tableau&logoColor=white)](https://public.tableau.com/)

### Supporting Libraries

[![Joblib](https://img.shields.io/badge/joblib-Model%20Serialization-4C78A8?style=flat-square)](https://joblib.readthedocs.io/)
[![Jupyter](https://img.shields.io/badge/Jupyter-Notebooks-F37626?style=flat-square&logo=jupyter&logoColor=white)](https://jupyter.org/)


## Important Modeling Note

The current model is useful for **ranking risk** but is still too strict on **absolute probability calibration**:

- ROC-AUC is around **0.75**, which indicates reasonable ranking/discrimination.
- Observed portfolio default rate is about **11.6%**.
- Average predicted risk score is about **43%**.

This means the model tends to overestimate default probability levels, so calibration is not yet aligned for production-style PD interpretation.

### Next Steps

1. Evaluate calibration explicitly.
2. Apply probability calibration.
3. Re-check decile ranking and calibration gap after calibration.
4. Use calibrated PD values for policy/cutoff decisions and expected loss reporting.
