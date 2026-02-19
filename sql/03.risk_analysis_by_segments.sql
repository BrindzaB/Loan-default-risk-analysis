-- Risk driver analysis by segments

WITH credit_score_segment AS (SELECT	'CreditScore' AS segment_type,
										CASE 
											WHEN CreditScore <= 579 THEN 'Poor'
											WHEN CreditScore <= 669 THEN 'Fair'
											WHEN CreditScore <= 739 THEN 'Good'
											WHEN CreditScore <= 799 THEN 'Very Good' 
											WHEN CreditScore > 799 THEN 'Exceptional'
										END AS segment_value,
                                        CASE
											WHEN CreditScore <= 579 THEN 1
											WHEN CreditScore <= 669 THEN 2
											WHEN CreditScore <= 739 THEN 3
											WHEN CreditScore <= 799 THEN 4 
											WHEN CreditScore > 799 THEN 5
										END AS segment_order,
										COUNT(*) AS number_of_loans,
										AVG(`Default`) AS default_rate,
										ROUND(AVG(risk_score), 4) AS avg_risk_score
								FROM ld_with_rs
								GROUP BY segment_value, segment_order),
                                
	 dti_ratio_segment AS (SELECT	'DTIRatio' AS segment_type,
									CASE
										WHEN DTIRatio < 0.25 THEN '< 25%'
										WHEN DTIRatio < 0.4 THEN '25% - 40%'
										WHEN DTIRatio < 0.55 THEN '40% - 55%'
                                        WHEN DTIRatio < 0.70 THEN '55% - 70%'
										ELSE '> 70%'
									END AS segment_value,
                                    CASE
										WHEN DTIRatio < 0.25 THEN 1
										WHEN DTIRatio < 0.4 THEN 2
										WHEN DTIRatio < 0.55 THEN 3
                                        WHEN DTIRatio < 0.70 THEN 4
										ELSE 5
									END AS segment_order,
									COUNT(*) AS number_of_loans,
									AVG(`Default`) AS default_rate,
									ROUND(AVG(risk_score), 4) AS avg_risk_score
							FROM ld_with_rs
							GROUP BY segment_value, segment_order),
                            
	 income_segment AS (SELECT	'Income' AS segment_type,
								CASE
									WHEN Income < 40000 THEN '< 40k'
									WHEN Income < 70000 THEN '40k - 70k'
									WHEN Income < 95000 THEN '70k - 95k'
									WHEN Income < 120000 THEN '95k - 120k'
									ELSE '> 120k'
								END AS segment_value,
                                CASE
									WHEN Income < 40000 THEN 1
									WHEN Income < 70000 THEN 2
									WHEN Income < 95000 THEN 3
									WHEN Income < 120000 THEN 4
									ELSE 5
								END AS segment_order,
								COUNT(*) AS number_of_loans,
								AVG(`Default`) AS default_rate,
								ROUND(AVG(risk_score), 4) AS avg_risk_score
						FROM ld_with_rs
						GROUP BY segment_value, segment_order),
                        
	 age_segment AS (SELECT 'Age' AS segment_type,
							CASE
								WHEN Age < 26 THEN '18 - 25'
								WHEN Age < 36 THEN '25 - 35'
								WHEN Age < 51 THEN '36 - 50'
								WHEN Age < 66 THEN '51 - 65'
								ELSE '65+'
							END AS segment_value,
							CASE
								WHEN Age < 26 THEN 1
								WHEN Age < 36 THEN 2
								WHEN Age < 51 THEN 3
								WHEN Age < 66 THEN 4
								ELSE 5
							END AS segment_order,
							COUNT(*) AS number_of_loans,
							AVG(`Default`) AS default_rate,
							ROUND(AVG(risk_score), 4) AS avg_risk_score
					FROM ld_with_rs
					GROUP BY segment_value, segment_order),
                    
	 loan_amount_segment AS (SELECT	'LoanAmount' AS segment_type,
									CASE
										WHEN LoanAmount < 50000 THEN '< 50k'
										WHEN LoanAmount < 100000 THEN '50k - 100k'
										WHEN LoanAmount < 150000 THEN '100k - 150k'
										WHEN LoanAmount < 200000 THEN '150k - 200k'
										ELSE '> 200k'
									END AS segment_value,
									CASE
										WHEN LoanAmount < 50000 THEN 1
										WHEN LoanAmount < 100000 THEN 2
										WHEN LoanAmount < 150000 THEN 3
										WHEN LoanAmount < 200000 THEN 4
										ELSE 5
									END AS segment_order,
									COUNT(*) AS number_of_loans,
									AVG(`Default`) AS default_rate,
									ROUND(AVG(risk_score), 4) AS avg_risk_score
							FROM ld_with_rs
							GROUP BY segment_value, segment_order),
                            
	 interest_rate_segment AS (SELECT	'InterestRate' AS segment_type,
										CASE
											WHEN InterestRate < 6 THEN '< 6%'
											WHEN InterestRate < 11 THEN '6% - 11%'
											WHEN InterestRate < 16 THEN '11% - 16%'
											WHEN InterestRate < 20 THEN '16% - 20%'
											ELSE '> 20%'
										END AS segment_value,
										CASE
											WHEN InterestRate < 6 THEN 1
											WHEN InterestRate < 11 THEN 2
											WHEN InterestRate < 16 THEN 3
											WHEN InterestRate < 20 THEN 4
											ELSE 5
										END AS segment_order,
										COUNT(*) AS number_of_loans,
										AVG(`Default`) AS default_rate,
										ROUND(AVG(risk_score), 4) AS avg_risk_score
							FROM ld_with_rs
							GROUP BY segment_value, segment_order),
                            
	 employment_type_segment AS (SELECT	'EmploymentType' AS segment_type,
										EmploymentType AS segment_value,
                                        CASE
											WHEN EmploymentType = 'Full-time' THEN 1
                                            WHEN EmploymentType = 'Part-time' THEN 2
                                            WHEN EmploymentType = 'Self-employed' THEN 3
                                            WHEN EmploymentType = 'Unemployed' THEN 4
										END AS segment_order,
										COUNT(*) AS number_of_loans,
										AVG(`Default`) AS default_rate,
										ROUND(AVG(risk_score), 4) AS avg_risk_score
								FROM ld_with_rs
								GROUP BY segment_value, segment_order),
                                
	 education_segment AS (SELECT 	'Education' AS segment_type,
									Education AS segment_value,
                                    CASE
										WHEN Education = 'High School' THEN 1
                                        WHEN Education = "Bachelor's" THEN 2
                                        WHEN Education = "Master's" THEN 3
                                        WHEN Education = 'PhD' THEN 4
									END AS segment_order,
									COUNT(*) AS number_of_loans,
									AVG(`Default`) AS default_rate,
									ROUND(AVG(risk_score), 4) AS avg_risk_score
							FROM 	ld_with_rs
							GROUP BY segment_value, segment_order),
                            
	marital_status_segment AS (SELECT	'MaritalStatus' AS segment_type,
										MaritalStatus AS segment_value,
                                        CASE
											WHEN MaritalStatus = 'Single' THEN 1
                                            WHEN MaritalStatus = 'Married' THEN 2
                                            WHEN MaritalStatus = 'Divorced' THEN 3
										END AS segment_order,
										COUNT(*) AS number_of_loans,
										AVG(`Default`) AS default_rate,
										ROUND(AVG(risk_score), 4) AS avg_risk_score
								FROM 	ld_with_rs
								GROUP BY segment_value, segment_order),
                                
	mortgage_segment AS (SELECT		'HasMortgage' AS segment_type,
									HasMortgage AS segment_value,
                                    CASE
										WHEN HasMortgage = 'No' THEN 1
                                        WHEN HasMortgage = 'Yes' THEN 2
									END AS segment_order,
									COUNT(*) AS number_of_loans,
									AVG(`Default`) AS default_rate,
									ROUND(AVG(risk_score), 4) AS avg_risk_score
						FROM ld_with_rs
						GROUP BY segment_value, segment_order),
                        
	dependents_segment AS (SELECT	'HasDependents' AS segment_type,
									HasDependents AS segment_value,
                                    CASE
										WHEN HasDependents = 'No' THEN 1
                                        WHEN HasDependents = 'Yes' THEN 2
									END AS segment_order,
									COUNT(*) AS number_of_loans,
									AVG(`Default`) AS default_rate,
									ROUND(AVG(risk_score), 4) AS avg_risk_score
							FROM ld_with_rs
							GROUP BY segment_value, segment_order),
                            
	cosigner_segment AS (SELECT		'HasCoSigner' AS segment_type,
									HasCoSigner AS segment_value,
                                    CASE
										WHEN HasCoSigner = 'No' THEN 1
                                        WHEN HasCoSigner = 'Yes' THEN 2
									END AS segment_order,
									COUNT(*) AS number_of_loans,
									AVG(`Default`) AS default_rate,
									ROUND(AVG(risk_score), 4) AS avg_risk_score
						FROM ld_with_rs
						GROUP BY segment_value, segment_order),
                        
	loan_purpose_segment AS (SELECT	'LoanPurpose' AS segment_type,
									LoanPurpose AS segment_value,
                                    CASE
										WHEN LoanPurpose = 'Education' THEN 1
                                        WHEN LoanPurpose = 'Auto' THEN 2
                                        WHEN LoanPurpose = 'Home' THEN 3
                                        WHEN LoanPurpose = 'Business' THEN 4
                                        WHEN LoanPurpose = 'Other' THEN 5
									END AS segment_order,
									COUNT(*) AS number_of_loans,
									AVG(`Default`) AS default_rate,
									ROUND(AVG(risk_score), 4) AS avg_risk_score
							FROM ld_with_rs
							GROUP BY segment_value, segment_order),

	loan_term_segment AS (SELECT 	'LoanTerm' AS segment_type,
									LoanTerm AS segment_value,
									COUNT(*) AS number_of_loans,
                                    CASE
										WHEN LoanTerm = 12 THEN 1
                                        WHEN LoanTerm = 24 THEN 2
                                        WHEN LoanTerm = 36 THEN 3
                                        WHEN LoanTerm = 48 THEN 4
                                        WHEN LoanTerm = 60 THEN 5
									END AS segment_order,
									AVG(`Default`) AS default_rate,
									ROUND(AVG(risk_score), 4) AS avg_risk_score
						  FROM ld_with_rs
						  GROUP BY segment_value, segment_order)


SELECT * FROM credit_score_segment
UNION ALL
SELECT * FROM dti_ratio_segment
UNION ALL
SELECT * FROM income_segment
UNION ALL
SELECT * FROM age_segment
UNION ALL
SELECT * FROM loan_amount_segment
UNION ALL
SELECT * FROM interest_rate_segment
UNION ALL
SELECT * FROM employment_type_segment
UNION ALL
SELECT * FROM education_segment
UNION ALL
SELECT * FROM marital_status_segment
UNION ALL
SELECT * FROM mortgage_segment
UNION ALL
SELECT * FROM dependents_segment
UNION ALL
SELECT * FROM cosigner_segment
UNION ALL
SELECT * FROM loan_purpose_segment
UNION ALL
SELECT * FROM loan_term_segment
ORDER BY segment_type, segment_order;




-- Checking the min and max income in each deciles with avg_default_rate to assess bucket thresholds               
/* WITH income_buckets AS (SELECT 	*, 
								NTILE(10) OVER(ORDER BY Income) AS income_bucket
						FROM 	ld_with_rs)
                        
SELECT 	income_bucket, MIN(Income), MAX(Income), AVG(`Default`)
FROM 	income_buckets
GROUP BY income_bucket; */
                            

        
        
        
        
        