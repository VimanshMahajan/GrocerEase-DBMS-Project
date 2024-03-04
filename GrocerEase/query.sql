-- inventory searching
Select * from Inventory 
where StoreID in (
	Select storeID 
	from Offline_Stores 
    Inner Join Customers On Offline_Stores.city in (
		Select Customers.City 
        where Customers.CustomerID=1)
	);
-- cart order count

-- balance check
Select Balance from Wallet where CustomerID = 1;
-- offline store closest to customer

-- average rating for overall order

-- Select and display items below Rs. 99
SELECT itemID, ItemName, price
FROM Inventory
WHERE price < 99;

-- item being ordered the most
SELECT Orders.itemID, inventory.category, SUM(quantity) AS total_quantity
FROM orders
JOIN inventory ON Orders.itemID = inventory.itemID
GROUP BY Orders.itemID, inventory.category
ORDER BY total_quantity DESC
limit 1
;

-- update address
update customers
set AddressLine1 = 'changed address' and AddressLine2 = ' to new address'
where CustomerID = 1;

-- total cart cost
SELECT c.Customer_ID, SUM(c.Quantity * i.price) AS total_bill_price
FROM cart c
JOIN inventory i ON c.Item_ID = i.itemID
GROUP BY c.Customer_ID
;
-- delete from inventory

-- group by categories + most sold product

-- user's most frequent orders bought
SELECT itemID , COUNT(itemID) AS Frequency
FROM Orders
WHERE CustomerID = 11
GROUP BY itemID
ORDER BY Frequency DESC
LIMIT 1;
