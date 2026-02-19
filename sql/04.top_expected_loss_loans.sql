-- Top 10 highest expected loss loans

SELECT 	*,
		ROUND(risk_score * 0.6 * LoanAmount) AS expected_loss
FROM ld_with_rs
ORDER BY expected_loss DESC
LIMIT 10;
