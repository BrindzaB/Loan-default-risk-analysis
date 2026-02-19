-- Model Validation - Risk Decile Analysis

WITH risk_deciles AS (SELECT 	*,
								NTILE(10) OVER (ORDER BY risk_score DESC) AS risk_decile
					  FROM ld_with_rs)

SELECT 	risk_decile,
		COUNT(*) AS number_of_loans,
        AVG(`Default`) AS actual_default_rate,
        ROUND(AVG(risk_score), 4) AS avg_risk_score,
        ROUND(SUM(risk_score * 0.6 * LoanAmount)) AS total_expected_loss,
        ROUND(AVG(risk_score * 0.6 * LoanAmount)) AS avg_expected_loss
FROM risk_deciles
GROUP BY risk_decile
ORDER BY risk_decile;