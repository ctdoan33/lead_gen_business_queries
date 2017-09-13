-- Query 1
SELECT SUM(billing.amount) AS total_revenue FROM billing
WHERE billing.charged_datetime LIKE "2012-03%"
-- OR
SELECT SUM(billing.amount) AS total_revenue FROM billing
WHERE YEAR(billing.charged_datetime) = 2012 AND MONTH(billing.charged_datetime) = 3
-- Query 2
SELECT SUM(billing.amount) AS total_revenue FROM billing
WHERE billing.client_id = 2
-- Query 3
SELECT sites.domain_name FROM sites
WHERE sites.client_id =10
-- Query 4.1
SELECT COUNT(sites.site_id) AS total_sites, MONTHNAME(sites.created_datetime) AS month, YEAR(sites.created_datetime) AS year FROM sites
WHERE sites.client_id = 1
GROUP BY year, month
-- Query 4.2
SELECT COUNT(sites.site_id) AS total_sites, MONTHNAME(sites.created_datetime) AS month, YEAR(sites.created_datetime) AS year FROM sites
WHERE sites.client_id = 20
GROUP BY year, month
-- Query 5
SELECT sites.domain_name, COUNT(leads.leads_id) AS total_leads FROM sites
JOIN leads ON sites.site_id = leads.site_id
WHERE DATE(leads.registered_datetime) >= "2011-01-01" AND DATE(leads.registered_datetime) <= "2011-02-15"
GROUP BY sites.domain_name
-- Query 6
SELECT clients.first_name, clients.last_name, COUNT(leads.leads_id) AS total_leads FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE DATE(leads.registered_datetime) >= "2011-01-01" AND DATE(leads.registered_datetime) <= "2011-12-31"
GROUP BY clients.first_name, clients.last_name
-- Query 7
SELECT clients.first_name, clients.last_name, COUNT(leads.leads_id) AS total_leads, MONTHNAME(leads.registered_datetime) AS month_2011 FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE MONTH(leads.registered_datetime) >= 1 AND MONTH(leads.registered_datetime) <= 6 AND YEAR(leads.registered_datetime) = 2011
GROUP BY clients.first_name, clients.last_name, month_2011
-- Query 8.1
SELECT clients.first_name, clients.last_name, COUNT(leads.leads_id) AS total_leads, sites.domain_name FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE DATE(leads.registered_datetime) >= "2011-01-01" AND DATE(leads.registered_datetime) <= "2011-12-31"
GROUP BY sites.domain_name
ORDER BY clients.client_id
-- Query 8.2
SELECT clients.first_name, clients.last_name, COUNT(leads.leads_id) AS total_leads, sites.domain_name FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
GROUP BY sites.domain_name
ORDER BY clients.client_id
-- Query 9
SELECT clients.first_name, clients.last_name, SUM(billing.amount) AS total_revenue,
MONTHNAME(billing.charged_datetime) AS month, YEAR(billing.charged_datetime) AS year FROM clients
JOIN billing ON billing.client_id = clients.client_id
GROUP BY clients.first_name, clients.last_name, month, year
ORDER BY clients.client_id
-- Query 10
SELECT clients.first_name, clients.last_name, GROUP_CONCAT(sites.domain_name) AS sites FROM clients
JOIN sites ON clients.client_id = sites.client_id
GROUP BY clients.first_name, clients.last_name