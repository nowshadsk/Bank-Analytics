use bank_analytics;

# 1. Year wise loan amount Stats
    
    SELECT 
    CONCAT(RIGHT(issue_d, 2),' Years') AS year,
    SUM(loan_amnt) AS total_loan_amount,
    AVG(loan_amnt) AS avg_loan_amount,
    MIN(loan_amnt) AS min_loan_amount,
    MAX(loan_amnt) AS max_loan_amount,
    COUNT(*) AS number_of_loans
FROM 
    finance
GROUP BY 
    concat(RIGHT(issue_d, 2),' Years');


#2. Grade and sub grade wise revol_bal

SELECT grade, sub_grade, sum(revol_bal) AS total_revol_bal
FROM finance f1 
JOIN finance2 f2 ON f1.id = f2.id 
GROUP BY grade, sub_grade;

#3. Total Payment for Verified Status Vs Total Payment for Non Verified Status

SELECT 
    t1.verification_status,
    SUM(t2.total_pymnt) AS total_payment
FROM 
    finance t1
JOIN 
    finance2 t2 ON t1.id = t2.id
GROUP BY 
    t1.verification_status;

#4. State wise and month wise loan status
   SELECT 
    loan_status,
    issue_d AS Issue_Date,
    addr_state,
    COUNT(*) AS Loan_Count
FROM 
    finance
GROUP BY 
    loan_status, issue_d, addr_state;
    
    
set SQL_safe_updates=0;

#5. Home ownership Vs last payment date stats

#UPDATE finance SET home_ownership = 'Rent'WHERE home_ownership = 'None';

SELECT 
    home_ownership,
    COUNT(*) AS Count,
    MIN(last_pymnt_d) AS earliest_last_payment,
    MAX(last_pymnt_d) AS latest_last_payment
FROM 
    finance t1
JOIN 
    finance2 t2 ON t1.id = t2.id
GROUP BY 
    home_ownership;

#UPDATE finance SET home_ownership = 'NONE' WHERE id IN (121535, 121568, 231321);
