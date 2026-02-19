-- 1. Portfolio Overview (KPIs)

SELECT 
	COUNT(*) AS total_loans,
	ROUND(AVG(LoanAmount)) AS avg_loan_amount,
    SUM(LoanAmount) AS total_loan_amount,
    AVG(`Default`) AS default_rate,
    ROUND(AVG(risk_score), 4) AS avg_risk_score,
	ROUND(SUM(risk_score * 0.6 * LoanAmount)) AS total_expected_loss,
    ROUND(AVG(risk_score * 0.6 * LoanAmount)) AS avg_expected_loss
FROM ld_with_rs;