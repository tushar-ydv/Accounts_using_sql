/*Tushar Yadav - Data Mananagement Homework 2*/
/*Account Payable Database*/

#Q1. Select all data from the Invoices table.
SELECT
	* 
FROM
	invoices;
    
#Q2. Display the Invoice number, Invoice date, and the Invoice total. Sort in descending sequence by Invoice Total.
SELECT
	invoice_number, invoice_date, invoice_total 
FROM
	invoices 
ORDER BY
	invoice_total DESC;

#Q3. Display all invoices from the month of June.
SELECT
	* 
FROM
	invoices 
WHERE
	MONTH ( invoice_date ) = 6;

#Q4. Write a query to show all vendors. Then sort the result set by last name and then first name, both in ascending sequence.
SELECT
	* 
FROM
	vendors 
ORDER BY
	vendor_contact_last_name ASC, vendor_contact_first_name ASC;

#Q5. Write a query that returns vendor’s last name and first name. Sort the result set by last name and then first name in ascending sequence. 
#Return only the contacts whose last name begins with the letter A, B, C, E.
SELECT
	vendor_contact_last_name, vendor_contact_first_name 
FROM
	vendors 
WHERE
	vendor_contact_last_name LIKE 'A%' OR vendor_contact_last_name LIKE 'B%' OR vendor_contact_last_name LIKE 'C%' OR vendor_contact_last_name LIKE 'E%' 
ORDER BY
	vendor_contact_last_name ASC, vendor_contact_first_name ASC;
	
#Q6. Display the invoice due date and the invoice amounts increased by 10%. Return only the rows with an invoice total that is greater than or equal to 500 and less than or equal to 1000. 
#Sort the result set in descending sequence by the invoice due date.
SELECT
	invoice_due_date, invoice_total * 1.1 AS invoice_amount_inc_10 
FROM
	invoices 
WHERE
	invoice_total >= 500 AND invoice_total <= 1000 
ORDER BY
	invoice_due_date DESC;

#Q7. Write a query that displays the invoice number, invoice total, payment credit total, and balance due. 
#Return only invoices that have a balance due greater that is than $50. Sort the result set by balance due in descending sequence. Limit the result set to show only the results with the 5 largest balances.
SELECT
	invoice_number, invoice_total, ( payment_total + credit_total ) AS payment_credit_total, ( invoice_total - payment_total - credit_total ) AS balance_due 
FROM
	invoices 
WHERE
	( invoice_total - payment_total - credit_total ) > 50 
ORDER BY
	balance_due DESC LIMIT 5;

#Q8. Display the invoices which have balance due.
SELECT
	*, ( invoice_total - payment_total - credit_total ) AS balance_due 
FROM
	invoices 
WHERE
	( invoice_total - payment_total - credit_total ) > 0;
	
#Q9. Display the names of the vendors who have balance due.
SELECT
	DISTINCT v.vendor_name
FROM
	 vendors v JOIN invoices i ON i.vendor_id = v.vendor_id
WHERE
	( i.invoice_total - i.payment_total - i.credit_total ) > 0;

#Q10. Write a query to display information about the vendors and the default account description for each vendor.
SELECT
	v.*, gla.account_description AS default_account_description 
FROM
	vendors v
	LEFT JOIN general_ledger_accounts gla ON v.default_account_number = gla.account_number;

#Q11. Write a query to display all invoices for each vendor. So for example, if a vendor has 2 invoices, then display all line item information for both invoices. Just an example to give you an idea.
SELECT *
FROM
	accountspayable.invoices i
JOIN
	accountspayable.invoice_line_items il ON i.invoice_id = il.invoice_id;
	
#Q12. Write a query to return one row for each vendor whose contact has the same last name as another vendor’s contact.
SELECT DISTINCT
	v1.vendor_id,
	v1.vendor_name,
	v1.vendor_contact_first_name,
	v1.vendor_contact_last_name 
FROM
	vendors v1
	JOIN vendors v2 ON v1.vendor_contact_last_name = v2.vendor_contact_last_name 
	AND v1.vendor_id <> v2.vendor_id;

#Q13. Write a query to return one row for each account number that has never been used. Sort the result set by Account Number.
SELECT
	gla.account_number,
	gla.account_description 
FROM
	general_ledger_accounts gla
	LEFT JOIN invoice_line_items ili ON gla.account_number = ili.account_number 
WHERE
	ili.account_number IS NULL 
ORDER BY
	gla.account_number;

#Q14. Generate the result set containing the following columns:
#Vendor Name Vendor State
#If the vendor is in California, the value in the Vendor State column should be “CA”; otherwise, the value should be “Outside CA.” Sort the final result set by Vendor Name.
SELECT
	vendor_name,
IF
	( vendor_state = 'CA', 'CA', 'Outside CA' ) AS vendor_state
FROM
	vendors;