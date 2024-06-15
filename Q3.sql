/*Evaluate Data Quality Issues in the Data Provided*/

1. Check for Missing Values
Null values can lead to incorrect analysis and failed transactions. 


SELECT COUNT(*) AS missing, 'user_id' FROM "fetch".Users WHERE user_id IS NULL
UNION ALL
SELECT COUNT(*) AS missing, 'createdDate' FROM "fetch".Users WHERE createdDate IS NULL;
This query checks for null user_id and createdDate in the Users table. 

2. Identify Duplicate Records
Duplicate records can lead to incorrect decision-making.

SELECT receipt_id, COUNT(*)
FROM "fetch".Receipts
GROUP BY receipt_id
HAVING COUNT(*) > 1;

This query finds duplicate receipt_id entries in the Receipts table, indicating the presence of multiple entries for the same receipt.

3. Validate Data Integrity Across Tables
Ensure that all foreign keys have corresponding primary keys in their reference tables (no orphan records)

SELECT r1.item_id
FROM "fetch".Receipt_Items r1
LEFT JOIN "fetch".Receipts r ON r1.receipt_id = r.receipt_id
WHERE r.receipt_id IS NULL;
This query identifies Receipt_Items that reference non-existent receipts.

4. Review Range, Outlier Constraints
checking for negative prices or quantities

SELECT item_id, finalPrice
FROM "fetch".Receipt_Items
WHERE finalPrice < 0;

This identifies items with a negative final price (indicate data entry errors or other issues)

