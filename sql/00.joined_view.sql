-- View for the joined tables
CREATE VIEW ld_with_rs AS
SELECT ld.*, rs.risk_score
FROM loan_default ld LEFT JOIN loan_risk_scores rs
	ON ld.LoanID = rs.LoanID;

SELECT * FROM ld_with_rs;
