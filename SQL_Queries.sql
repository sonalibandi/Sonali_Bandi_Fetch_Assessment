/* All of these queries were run in PostgreSQL. */

What are the top 5 brands by receipts scanned for most recent month?

SELECT b.name, COUNT(*) AS receipt_count
FROM "fetch".Brands b
JOIN "fetch".Receipt_Items ri ON b.barcode = ri.barcode
JOIN "fetch".Receipts r ON ri.receipt_id = r.receipt_id
WHERE EXTRACT(YEAR FROM r.dateScanned) = EXTRACT(YEAR FROM CURRENT_DATE)
  AND EXTRACT(MONTH FROM r.dateScanned) = EXTRACT(MONTH FROM CURRENT_DATE) - 1
GROUP BY b.name
ORDER BY receipt_count DESC
LIMIT 5;


Which brand has the most spend among users who were created within the past 6 months?

SELECT b.name, SUM(ri.finalPrice::NUMERIC) AS total_spent
FROM "fetch".Brands b
JOIN "fetch".Receipt_Items ri ON b.barcode = ri.barcode
JOIN "fetch".Receipts r ON ri.receipt_id = r.receipt_id
JOIN "fetch".Users u ON r.user_id = u.user_id
WHERE u.createdDate > CURRENT_DATE - INTERVAL '6 months'
GROUP BY b.name
ORDER BY total_spent DESC
LIMIT 1;


Which brand has the most transactions among users who were created within the past 6 months?

SELECT b.name, COUNT(*) AS transaction_count
FROM "fetch".Brands b
JOIN "fetch".Receipt_Items ri ON b.barcode = ri.barcode
JOIN "fetch".Receipts r ON ri.receipt_id = r.receipt_id
JOIN "fetch".Users u ON r.user_id = u.user_id
WHERE u.createdDate > CURRENT_DATE - INTERVAL '6 months'
GROUP BY b.name
ORDER BY transaction_count DESC
LIMIT 1;