--Q1
SELECT quantityOnHand
FROM item
WHERE itemDescription='bottle of antibiotics';
--Q2
SELECT volunteerName
FROM volunteer
WHERE volunteerTelephone NOT LIKE '2%' AND volunteerName NOT LIKE '%Jones';
--Q3
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a
ON v.volunteerId=a.volunteerId
JOIN task t
ON a.taskCode=t.taskCode
JOIN task_type tt
ON t.taskTypeId=tt.taskTypeId
WHERE tt.taskTypeName='transporting';
--Q4
SELECT t.taskDescription
FROM task t
LEFT JOIN assignment a
ON t.taskCode=a.taskCode
WHERE a.taskCode IS NULL;
--Q5
SELECT DISTINCT pt.packageTypeName
FROM item i
JOIN package_contents as pc
ON i.itemId=pc.itemId
JOIN package p
ON pc.packageId=p.packageId
JOIN package_type pt
ON p.packageTypeId=pt.packageTypeId
WHERE i.itemDescription LIKE '%bottle%';
--Q6
SELECT i.itemDescription
FROM item i
LEFT JOIN package_contents pc
ON i.itemId=pc.itemId
WHERE pc.itemId IS NULL;
--Q7
SELECT DISTINCT t.taskDescription
FROM volunteer v
JOIN assignment a
ON v.volunteerId=a.volunteerId
JOIN task t
ON a.taskCode=t.taskCode
WHERE v.volunteerAddress LIKE '%NJ%';
--Q8
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a
ON v.volunteerId=a.volunteerId
WHERE a.startDateTime>='2021-01-01'
AND a.startDateTime<'2021-07-01';
--Q9
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a
ON v.volunteerId = a.volunteerId
JOIN task t
ON a.taskCode = t.taskCode
JOIN package p
ON t.taskCode = p.taskCode
JOIN package_contents pc
ON p.packageId = pc.packageId
JOIN item i
ON pc.itemId = i.itemId
WHERE i.itemDescription = 'can of spam';
--Q10
SELECT DISTINCT i.itemDescription
FROM item i
JOIN package_contents pc
ON i.itemId=pc.itemId
WHERE i.itemValue*pc.itemQuantity=100;
--Q11
SELECT ts.taskStatusName, COUNT(DISTINCT a.volunteerId) AS volunteerCount
FROM task_status ts
LEFT JOIN task t
ON ts.taskStatusId=t.taskStatusId
LEFT JOIN assignment a
ON t.taskCode=a.taskCode
GROUP BY ts.taskStatusName
ORDER BY volunteerCount DESC;
--Q12
SELECT p.taskCode, SUM(p.packageWeight) as totalWeight
FROM package p
GROUP BY p.taskCode
ORDER BY totalweight DESC
LIMIT 1;
--q13
SELECT count(*) as numberofTasks
FROM task t
JOIN task_type tt
ON t.taskTypeId=tt.taskTypeId
WHERE tt.taskTypeName!='packing';
--Q14
SELECT i.itemDescription
FROM item i
JOIN package_contents pc
ON i.itemId = pc.itemId
JOIN package p
ON pc.packageId = p.packageId
JOIN assignment a
ON p.taskCode = a.taskCode
GROUP BY i.itemId, i.itemDescription
HAVING COUNT(DISTINCT a.volunteerId) < 3;
--Q15
SELECT p.packageId, SUM(i.itemValue * pc.itemQuantity) AS totalValue
FROM package p
JOIN package_contents pc
ON p.packageId = pc.packageId
JOIN item i
ON pc.itemId = i.itemId
GROUP BY p.packageId
HAVING SUM(i.itemValue * pc.itemQuantity) > 100
ORDER BY totalValue ASC;
