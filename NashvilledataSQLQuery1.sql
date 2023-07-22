
--Select all fields from the Nashvilledata table 
SELECT * 
FROM Nashvilledata;
--select and format SaleDate field
SELECT SaleDate, CONVERT(DATE, SaleDate)
FROM Nashvilledata

UPDATE Nashvilledata
SET SaleDateConverted = CONVERT(DATE, SaleDate)

ALTER TABLE Nashvilledata
ADD SaleDateConverted Date;

UPDATE Nashvilledata
SET SaleDateCoverted = CONVERT(DATE, SaleDate);

--select property address column where propertyaddress is null
SELECT * 
FROM Nashvilledata
WHERE PropertyAddress IS NULL

--order by parcelid
SELECT * 
FROM Nashvilledata
ORDER  BY ParcelID;

--self join table to itself
SELECT n1.ParcelID, n1.PropertyAddress, n2.ParcelID, n2.PropertyAddress, ISNULL(n1.PropertyAddress, n2.PropertyAddress)
FROM Nashvilledata AS n1
JOIN Nashvilledata AS n2
	ON n1.ParcelID = n2.ParcelID
	AND n1.UniqueID <> n2.UniqueID
--where PropertyAddress IS NULL
WHERE n1.PropertyAddress IS NULL


--update the propertyaddress of Nashvilledata
UPDATE n1
SET PropertyAddress = ISNULL(n1.PropertyAddress, n2.PropertyAddress)
FROM Nashvilledata AS n1
JOIN Nashvilledata AS n2
	ON n1.ParcelID = n2.ParcelID
	AND n1.UniqueID <> n2.UniqueID
WHERE n1.PropertyAddress IS NULL

SELECT PropertyAddress
FROM Nashvilledata


--substring propertyaddress
SELECT 
SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM Nashvilledata

--alter and update propertyaddress column 
ALTER TABLE Nashvilledata
ADD PropertySplitAddress nvarchar(250);

UPDATE Nashvilledata
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE Nashvilledata
ADD PropertySplitCity nvarchar(250);

UPDATE Nashvilledata
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

SELECT top 10 *
FROM Nashvilledata

--select owneraddress column 
SELECT top 10 OwnerAddress
FROM Nashvilledata

--use parsename to separate delimiter
SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM Nashvilledata

--alter and update Owneraddress column
ALTER TABLE Nashvilledata
ADD OwnerSplitAddress nvarchar(250);

UPDATE Nashvilledata
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE Nashvilledata
ADD OwnerSplitCity nvarchar(250);

UPDATE Nashvilledata
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE Nashvilledata
ADD OwnerSplitSate nvarchar(250);

UPDATE Nashvilledata
SET OwnerSplitSate  = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant) 
FROM Nashvilledata
GROUP BY SoldAsVacant
ORDER BY 2;
--use case state to return 'YES' or 'NO' in palce of 'Y' or 'N'
SELECT SoldAsVacant,
	CASE
		WHEN SoldAsVacant = 'Y' THEN 'YES'
		WHEN SoldAsVacant = 'N' THEN 'NO'
		ELSE SoldAsVacant
		END
FROM Nashvilledata

--update the SoldAsVacant column
UPDATE Nashvilledata
SET SoldAsVacant = CASE
		WHEN SoldAsVacant = 'Y' THEN 'YES'
		WHEN SoldAsVacant = 'N' THEN 'NO'
		ELSE SoldAsVacant
		END
select * From Nashvilledata;


--removing duplicates 
-- using window functions, get rid of DUPLICATE values (although not a standard practice)
--build a CTE called rownum 
WITH rownumCTE AS(SELECT *, ROW_NUMBER() OVER (PARTITION BY ParcelID, 
							PropertyAddress, 
							SalePrice,
						SaleDate, 
						LegalReference ORDER BY ParcelID) AS row_num
							
FROM Nashvilledata)   --this query does not work 


--Deleting unwanted column 
SELECT  top 50 *
FROM Nashvilledata;
 
ALTER TABLE Nashvilledata
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE Nashvilledata
DROP COLUMN DateConverted, Date_Converted

ALTER TABLE Nashvilledata
DROP COLUMN SaleDate









