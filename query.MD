b) Write some queries for this table to retrieve data - show the trades a user was involved in for the last 30 days - write other examples to show other typical queries on these kind of tables

SELECT * FROM 
(SELECT * FROM trades
WHERE created_by = 1
UNION
SELECT * FROM trades
WHERE id_user = 1) trades_involve 
WHERE created_at >= NOW() - INTERVAL '30 DAY'

c) get total item by particular user
SELECT count(items) as total_item FROM users
JOIN items ON users.id = items.id_user
WHERE users.id = 1

The effective query is we need to always don't retrieve data as necessary. tbh I don't have much experience focussing on SQL monitoring and advanced technique.
