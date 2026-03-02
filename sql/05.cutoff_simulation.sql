WITH cutoffs AS (SELECT 0.04 AS cutoff UNION ALL
				 SELECT 0.08 UNION ALL
				 SELECT 0.12 UNION ALL
				 SELECT 0.16 UNION ALL
				 SELECT 0.20 UNION ALL
				 SELECT 0.24 UNION ALL
                 SELECT 0.28 UNION ALL
                 SELECT 0.32),
	 totals AS (SELECT	COUNT(*) AS total_loans,
						SUM(`Default`) AS total_defaults,
                        SUM(risk_score * 0.6 * LoanAmount) AS total_expected_loss
				FROM ld_with_rs)
                
SELECT 	c.cutoff,
		SUM(CASE WHEN l.risk_score < c.cutoff THEN 1 ELSE 0 END) AS approved_loans,
        SUM(CASE WHEN l.risk_score < c.cutoff THEN 1 ELSE 0 END) / t.total_loans AS approval_rate,
        ROUND(AVG(CASE WHEN l.risk_score < c.cutoff THEN l.`Default` END), 4) AS approved_default_rate,
        ROUND(SUM(CASE WHEN l.risk_score < c.cutoff THEN l.risk_score * 0.6 * l.LoanAmount END)) AS approved_expected_loss,
        ROUND(SUM(CASE WHEN l.risk_score >= c.cutoff THEN l.`Default` END) / NULLIF(t.total_defaults, 0), 4) AS rejected_default_captured
FROM cutoffs c
CROSS JOIN ld_with_rs l
CROSS JOIN totals t
GROUP BY c.cutoff, t.total_loans
ORDER BY c.cutoff;






/* SELECT
  CASE
    WHEN risk_score IS NOT NULL AND risk_score < 0.60 THEN 'APPROVED'
    ELSE 'REJECTED'
  END AS decision,
  COUNT(*) AS loans,
  AVG(`Default`) AS default_rate,
  ROUND(SUM(risk_score * 0.6 * LoanAmount), 0) AS expected_loss
FROM ld_with_rs
GROUP BY decision; */