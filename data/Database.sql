create database FurnitureWebsite;
use FurnitureWebsite;
/*
drop database FurnitureWebsite
*/

create table PRODUCTS(
	ID      	int auto_increment,
	Name    	varchar(250) 	unique ,
	Info    	varchar(1000)	,
	Price   	int         	,
    Material	varchar(30)		,
	Width		float			,
    Height		float			,
    Depth		float			,
    Weight		float			,
	#Image		blob			,
	primary key (ID)
);

create table USERS(
	ID			int auto_increment,
    UserName	varchar(25)		unique ,
    PassWord	varchar(250)	,
    FirstName	varchar(30)		,
    LastName	varchar(70)		,
    Phone		varchar(20)		,
    Mail		varchar(50)		,
    RegDate		date			default (current_date),
    BirthYear	int				,
    primary key (ID)
);

create table RECEIPTS(
	ID			int auto_increment,
	Date 		date 			default (current_date),
	Paid		int         	default 0,
	UserID		varchar(25) 	,
	Status		enum('Shopping', 'Pending', 'Delivering', 'Complete', 'Cancelled') default 'Shopping',
    primary key (ID)
);

create table VOUCHERS(
	ID			int auto_increment,
	Name		varchar(250)	unique ,
	Type		enum('Percentage', 'Value'),
	Value		decimal(50, 2) 	,
	ValidDate	date			,
	primary key (ID)
);

create table TAGS(
	ID		int auto_increment,
	Name	varchar(250)	unique ,
    primary key (ID)
);

create table COLOURS(
	ID		int auto_increment,
    Name	varchar(250)	unique ,
    Barcode	varchar(10)		unique ,
    primary key (ID)
);

create table ROLES(
	ID		int auto_increment,
    Name	varchar(250)	unique ,
    primary key (ID)
);

create table PERMISSIONS(
	ID		int auto_increment,
    Name	varchar(250)	unique ,
    primary key (ID)
);

create table REVENUES(
	Year	int		default (year(curdate()))	,
    Month	int		default (month(curdate()))	,
    Value	int		default 0					,
    primary key (Year, Month)
);

create table COMMENTS(
    UserID		int		,
    ProductID	int				,
    Content		varchar(1000)	,
    Date		datetime		default (current_timestamp),
    Rating		float			,
    primary key (UserID, ProductID)
);

create table LIKE_PRODUCT(
    UserID		int		,
    ProductID	int				,
    Content		varchar(1000)	,
    Date		date			default (current_date),
    primary key (UserID, ProductID)
);

create table PRODUCT_TAG(
	ProductID	int	,
    TagID		int	,
    primary key (ProductID, TagID)
);

create table PRODUCT_COLOUR(
	ProductID	int	,
    ColourID	int	,
    primary key (ProductID, ColourID)
);

create table RECEIPT_VOUCHER(
	ReceiptID	int	,
    VoucherID	int	,
    primary key (ReceiptID, VoucherID)
);

create table RECEIPT_DETAIL(
	ReceiptID	int	,
    ProductID	int	,
    Amount		int			default 1,
    ColourID	int	,
    primary key (ReceiptID, ProductID, ColourID)
);
	
create table USER_ROLE(
	UserID		int	,
    RoleID		int	,
    primary key (UserID, RoleID)
);

create table ROLE_PERMISSION(
	RoleID				int	,
    PermissionID		int	,
    primary key (RoleID, PermissionID)
);

create table ARGUMENTS(
	RegAge				int				default 18,
    MinPaid				decimal(10, 2)	default 0,
    RatingUpper			int				default 5,
    RatingLower			int				default 0
);

-- Add foreign key
alter table PRODUCT_TAG
add foreign key (ProductID)		references PRODUCTS(ID);
alter table PRODUCT_TAG
add foreign key (TagID)			references TAGS(ID);
alter table PRODUCT_COLOUR
add foreign key (ProductID)		references PRODUCTS(ID);
alter table PRODUCT_COLOUR
add foreign key (ColourID)		references COLOURS(ID);
alter table RECEIPT_DETAIL
add foreign key (ReceiptID)		references RECEIPTS(ID);
alter table RECEIPT_DETAIL
add foreign key (ProductID)		references PRODUCTS(ID);
alter table RECEIPT_DETAIL
add foreign key (ColourID)		references COLOURS(ID);
alter table COMMENTS
add foreign key (ProductID)		references PRODUCTS(ID);
alter table COMMENTS
add foreign key (UserID)		references USERS(ID);
alter table RECEIPT_VOUCHER
add foreign key (ReceiptID)		references RECEIPTS(ID);
alter table RECEIPT_VOUCHER
add foreign key (VoucherID)		references VOUCHERS(ID);
alter table USER_ROLE
add foreign key (UserID)		references USERS(ID);
alter table USER_ROLE
add foreign key (RoleID)		references ROLES(ID);
alter table ROLE_PERMISSION
add foreign key (RoleID)		references ROLES(ID);
alter table ROLE_PERMISSION
add foreign key (PermissionID)	references PERMISSIONS(ID);
alter table LIKE_PRODUCT
add foreign key (ProductID)		references PRODUCTS(ID);
alter table LIKE_PRODUCT
add foreign key (UserID)		references USERS(ID);

-- ----- PRODUCTS basic sp & tg----- --

DELIMITER //
CREATE PROCEDURE sp_InsertProduct(
	Name    	varchar(250) 	,
	Info    	varchar(1000)	,
	Price   	int         	,
    Material	varchar(30)		,
	Width		float			,
    Height		float			,
    Depth		float			,
    Weight		float				         
)
BEGIN
	INSERT INTO PRODUCTS (Name, Info, Price, Material,
						Width, Height, Depth, Weight)
	VALUES (Name, Info, Price, Material,
						Width, Height, Depth, Weight);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateProduct(
	IDUp		int		,
	ID			int 	,
	Name    	varchar(250) 	,
	Info    	varchar(1000)	,
	Price   	int         	,
    Material	varchar(30)		,
	Width		float			,
    Height		float			,
    Depth		float			,
    Weight		float			
)
BEGIN
    UPDATE PRODUCTS a
	SET a.ID = ID, 
		a.Name = Name, 
		a.Info = Info, 
        a.Price = Price,
        a.Material = Material,
        a.Width = Width,
        a.Height = Height,
        a.Depth = Depth,
        a.Weight = Weight
	WHERE IDUp = a.ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteProduct(
	IDDel	int          
)
BEGIN
    DELETE FROM PRODUCTS WHERE ID = IDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllProduct(       
)
BEGIN
    SELECT *
	FROM PRODUCTS;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetProductByName(       
	Name      varchar(250)
)
BEGIN
    SELECT *
    FROM PRODUCTS a
    WHERE a.Name LIKE Name;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetProduct(       
	ID      int
)
BEGIN
    SELECT *
    FROM PRODUCTS a
    WHERE a.ID = ID;
END;
//
DELIMITER ;

-- ----- USERS basic sp ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertUser(
	UserName	varchar(25)		,
    PassWord	varchar(250)	,
    FirstName	varchar(30)		,
    LastName	varchar(70)		,
    Phone		varchar(20)		,
    Mail		varchar(50)		,
    BirthYear	int				
)
BEGIN
	INSERT INTO USERS (UserName, PassWord, FirstName, LastName,
						Phone, Mail, BirthYear)
	VALUES (UserName, PassWord, FirstName, LastName,
						Phone, Mail, BirthYear);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateUser(
	IDUp		int		,
	ID			int		,
    UserName	varchar(25)		,
    PassWord	varchar(250)	,
    FirstName	varchar(30)		,
    LastName	varchar(70)		,
    Phone		varchar(20)		,
    Mail		varchar(50)		,
    RegDate		date			,
    BirthYear	int				
)
BEGIN
    UPDATE USERS a
	SET a.ID = ID			,
		a.UserName = UserName	,
        a.PassWord = PassWord	,
		a.FirstName = FirstName	,
		a.LastName = LastName	,
		a.Phone = Phone		,
		a.Mail = Mail		,
		a.RegDate = RegDate		,
		a.BirthYear = BirthYear	
	WHERE IDUp = a.ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteUserByUserName(
	UserNameDel	varchar(25)          
)
BEGIN
    DELETE FROM USERS WHERE UserName = UserNameDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteUser(
	IDDel	varchar(25)          
)
BEGIN
    DELETE FROM USERS WHERE ID = IDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllUser(       
)
BEGIN
    SELECT * FROM USERS;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetUserByUserName(  
	UserName varchar(25)
)
BEGIN
    SELECT * FROM USERS a
    WHERE a.UserName LIKE UserName;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetUser(  
	ID varchar(25)
)
BEGIN
    SELECT * FROM USERS a
    WHERE a.ID LIKE ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetUserByLastName(  
	LastName varchar(25)
)
BEGIN
    SELECT * FROM USERS a
    WHERE a.LastName LIKE LastName;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetUserByFirstName(  
	FirstName varchar(25)
)
BEGIN
    SELECT * FROM USERS a
    WHERE a.FirstName LIKE FirstName;
END;
//
DELIMITER ;

-- ----- RECEIPTS basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertReceipt(
	UserID  	varchar(25) 	       
)
BEGIN
	INSERT INTO RECEIPTS (UserID)
	VALUES (UserID);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateReceipt(
	IDUp		int		,
	ID        	int 	,
	Date 		date 			,
	Paid      	int         	,
	UserID  	varchar(50) 	,
	Status		enum('Shopping', 'Pending', 'Delivering', 'Complete', 'Cancelled')  
)
BEGIN
    UPDATE RECEIPTS a
	SET a.ID = ID, 
		a.Date = Date, 
		a.Paid = Paid, 
        a.UserID = UserID,
        a.Status = Status
	WHERE IDUp = a.ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteReceipt(
	IDDel	int          
)
BEGIN
    DELETE FROM RECEIPTS WHERE ID = IDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllReceipt(       
)
BEGIN
    SELECT * FROM RECEIPTS;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceipt(
	ID		int
)
BEGIN
    SELECT * FROM RECEIPTS a
    WHERE a.ID = ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceiptByUserID(       
	UserID      varchar(25)
)
BEGIN
    SELECT * 
    FROM RECEIPTS a
    WHERE a.UserID = UserID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceiptByStatus(       
	Status      enum('Shopping', 'Pending', 'Delivering', 'Complete', 'Cancelled')  
)
BEGIN
    SELECT * 
    FROM RECEIPTS a
    WHERE a.Status = Status;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceiptBetweenTime(       
	Timeline1      Date,
    Timeline2      Date	
)
BEGIN
    SELECT * 
    FROM RECEIPTS a
    WHERE a.Date BETWEEN Timeline1 AND Timeline2;
END;
//
DELIMITER ;

-- ----- VOUCHERS basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertVoucher(
	Name		varchar(250)	,
	Type      	enum('Percentage', 'Value'),
	Value		decimal(50, 2) 	,
	ValidDate	date			      	         
)
BEGIN
	INSERT INTO VOUCHERS (Name, Type, Value, ValidDate)
	VALUES (Name, Type, Value, ValidDate);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateVoucher(
	IDUp		int		,
	ID        	int 	,
	Name		varchar(250)	,
	Type      	enum('Percentage', 'Value'),
	Value		decimal(50, 2) 	,
	ValidDate	date	
)
BEGIN
    UPDATE VOUCHERS a
	SET a.ID = ID, 
		a.Name = Name, 
		a.Type = Type, 
        a.Value = Value,
        a.ValidDate = ValidDate
	WHERE IDUp = a.ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteVoucher(
	IDDel	int          
)
BEGIN
    DELETE FROM VOUCHERS WHERE ID = IDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllVoucher(       
)
BEGIN
    SELECT * FROM VOUCHERS;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetVoucher(       
	ID		int
)
BEGIN
    SELECT * FROM VOUCHERS a
    WHERE a.ID = ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetVoucherByName(       
	Name      varchar(250)
)
BEGIN
    SELECT * 
    FROM VOUCHERS a
    WHERE a.Name LIKE Name;
END;
//
DELIMITER ;

-- ----- TAGS basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertTag(
    Name	varchar(250)		         
)
BEGIN
	INSERT INTO TAGS (Name)
	VALUES (Name);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateTag(
	IDUp		int		,
	ID			int 	,
	Name		varchar(250) 	
)
BEGIN
    UPDATE TAGS a
	SET a.ID = ID, 
		a.Name = Name
	WHERE IDUp = a.ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteTag(
	IDDel	int          
)
BEGIN
    DELETE FROM TAGS WHERE ID = IDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllTag(       
)
BEGIN
    SELECT * FROM TAGS;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetTag(  
	ID		int
)
BEGIN
    SELECT * FROM TAGS a
    WHERE a.ID = ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetTagByName(       
	Name      varchar(250)
)
BEGIN
    SELECT * 
    FROM TAGS a
    WHERE a.Name LIKE Name;
END;
//
DELIMITER ;

-- ----- COLOURS basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertColour(
	Name	varchar(250)	,
    Barcode	varchar(10)		    	         
)
BEGIN
	INSERT INTO COLOURS (Name, Barcode)
	VALUES (Name, Barcode);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateColour(
	IDUp		int		,
	ID			int		,
    Name		varchar(250)	,
    Barcode		varchar(10)		
)
BEGIN
    UPDATE COLOURS a
	SET a.ID = ID, 
		a.Name = Name, 
		a.Barcode = Barcode
	WHERE IDUp = a.ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteColour(
	IDDel	int          
)
BEGIN
    DELETE FROM COLOURS WHERE ID = IDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllColour(       
)
BEGIN
    SELECT * FROM COLOURS;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetColour( 
	ID		int
)
BEGIN
    SELECT * FROM COLOURS a
    WHERE a.ID = ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetColourByName(       
	Name      varchar(250)
)
BEGIN
    SELECT * 
    FROM COLOURS a
    WHERE a.Name LIKE Name;
END;
//
DELIMITER ;

-- ----- ROLES basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertRole(
	Name		varchar(250) 	    	         
)
BEGIN
	INSERT INTO ROLES (Name)
	VALUES (Name);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateRole(
	IDUp		int		,
	ID			int 	,
	Name		varchar(250) 	
)
BEGIN
    UPDATE ROLES a
	SET a.ID = ID, 
		a.Name = Name
	WHERE IDUp = a.ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteRole(
	IDDel	int          
)
BEGIN
    DELETE FROM ROLES WHERE ID = IDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllRole(       
)
BEGIN
    SELECT * FROM ROLES;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetRole( 
	ID		int
)
BEGIN
    SELECT * FROM ROLES a
    WHERE a.ID = ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetRoleByName(       
	Name      varchar(250)
)
BEGIN
    SELECT * 
    FROM ROLES a
    WHERE a.Name LIKE Name;
END;
//
DELIMITER ;

-- ----- PERMISSIONS basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertPermission(
	Name		varchar(250) 	 	         
)
BEGIN
	INSERT INTO PERMISSIONS (Name)
	VALUES (Name);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdatePermission(
	IDUp		int		,
	ID			int 	,
	Name		varchar(250) 	
)
BEGIN
    UPDATE PERMISSIONS a
	SET a.ID = ID, 
		a.Name = Name
	WHERE IDUp = a.ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeletePermission(
	IDDel	int          
)
BEGIN
    DELETE FROM PERMISSIONS WHERE ID = IDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllPermission(       
)
BEGIN
    SELECT * FROM PERMISSIONS;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetPermission(  
	ID		int
)
BEGIN
    SELECT * FROM PERMISSIONS a
    WHERE a.ID = ID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetPermissionByName(       
	Name      varchar(250)
)
BEGIN
    SELECT * 
    FROM PERMISSIONS a
    WHERE a.Name LIKE Name;
END;
//
DELIMITER ;

-- ----- REVENUES basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertRevenue(
    Value 	decimal(50, 2)
)
BEGIN
    DECLARE existingRecord INT;

    SELECT COUNT(*)
    INTO existingRecord
    FROM REVENUES
    WHERE Year = YEAR(CURDATE()) AND Month = MONTH(CURDATE());

    IF existingRecord = 0 THEN
        INSERT INTO REVENUES (Value)
        VALUES (Value);
    ELSE
        UPDATE REVENUES a
        SET a.Value = a.Value + Value
        WHERE a.Year = YEAR(CURDATE()) AND a.Month = MONTH(CURDATE());
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteRevenue(
	YearDel		int,
    MonthDel	int
)
BEGIN
    DELETE FROM REVENUES WHERE Year = YearDel 
							AND Month = MonthDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllRevenue(       
)
BEGIN
    SELECT * FROM REVENUES;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetRevenue(
	Year		int,
    Month		int
)
BEGIN
    SELECT * FROM REVENUES a
    WHERE a.Year = Year AND a.Month = Month;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetRevenueByMonth(
    Month	int
)
BEGIN
    SELECT * FROM REVENUES a
    WHERE a.Month = Month;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetRevenueByYear(
    Year	int
)
BEGIN
    SELECT * FROM REVENUES a
    WHERE a.Year = Year;
END;
//
DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_GetQuarterlyRevenuesForAllYears(

)
BEGIN
    DECLARE current_year INT;
    DECLARE current_quarter INT;

    DECLARE total_q1 INT;
    DECLARE total_q2 INT;
    DECLARE total_q3 INT;
    DECLARE total_q4 INT;

    DECLARE year_cursor CURSOR FOR
        SELECT DISTINCT Year FROM REVENUES ORDER BY Year;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET current_year = NULL;

    SET total_q1 = 0;
    SET total_q2 = 0;
    SET total_q3 = 0;
    SET total_q4 = 0;

    OPEN year_cursor;

    FETCH year_cursor INTO current_year;

    WHILE current_year IS NOT NULL DO
        SET total_q1 = 0;
        SET total_q2 = 0;
        SET total_q3 = 0;
        SET total_q4 = 0;

        SELECT
            SUM(CASE WHEN Month BETWEEN 1 AND 3 THEN Value ELSE 0 END) AS q1,
            SUM(CASE WHEN Month BETWEEN 4 AND 6 THEN Value ELSE 0 END) AS q2,
            SUM(CASE WHEN Month BETWEEN 7 AND 9 THEN Value ELSE 0 END) AS q3,
            SUM(CASE WHEN Month BETWEEN 10 AND 12 THEN Value ELSE 0 END) AS q4
        INTO total_q1, total_q2, total_q3, total_q4
        FROM REVENUES
        WHERE Year = current_year;

        SELECT current_year AS Year, total_q1 AS Q1, total_q2 AS Q2, total_q3 AS Q3, total_q4 AS Q4;

        FETCH year_cursor INTO current_year;
    END WHILE;

    CLOSE year_cursor;
END //

DELIMITER ;

-- ----- COMMENTS basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertComment(
    UserID		int		,
    ProductID	int		,
    Content		varchar(1000)	,
    Rating		float			
)
BEGIN
	INSERT INTO COMMENTS (UserID, ProductID, Content,
						Rating)
	VALUES (UserID, ProductID, Content,
						Rating);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateComment(
	UserIDUp	int		,
    ProductIDUp	int		,
    UserID		int		,
    ProductID	int		,
    Content		varchar(1000)	,
    Rating		float				
)
BEGIN
    UPDATE COMMENTS a
	SET a.UserID = UserID	,
		a.ProductID = ProductID	,
		a.Content = Content	,
        a.Date = (current_timestamp)	,
		a.Rating = Rating		
    WHERE a.UserID = UserIDUp
		AND a.ProductID = ProductIDUp;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteComment(
	UserID			int		,
    ProductIDDel	int		      
)
BEGIN
    DELETE FROM COMMENTS 
    WHERE UserID = UserIDDel
		AND ProductID = ProductIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllComment(       
)
BEGIN
    SELECT * FROM COMMENTS;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetCommentByProductID(       
	ProductID      int
)
BEGIN
    SELECT * 
    FROM COMMENTS a
    WHERE a.ProductID = ProductID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetCommentByUserID(       
	UserID      int	
)
BEGIN
    SELECT * 
    FROM COMMENTS a
    WHERE a.UserID = UserID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetComment(       
	UserID			int,
    ProductID		int
)
BEGIN
    SELECT * 
    FROM COMMENTS a
    WHERE a.UserID = UserID
		AND a.ProductID = ProductID;
END;
//
DELIMITER ;

-- ----- LIKE_PRODUCT basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertLike_Product(
	UserID		varchar(25)		,
    ProductID	int		,
    Content		varchar(1000)	
)
BEGIN
	INSERT INTO LIKE_PRODUCT (UserID, ProductID, Content)
	VALUES (UserID, ProductID, Content);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateLike_Product(
	UserIDUp	int		,
    ProductIDUp	int		,
	UserID		int		,
    ProductID	int		,
    Content		varchar(1000)				
)
BEGIN
    UPDATE LIKE_PRODUCT a
	SET a.UserID = UserID	,
		a.ProductID = ProductID	,
		a.Content = Content	,
        a.Date = (current_timestamp)		
    WHERE a.UserID = UserIDUp
		AND a.ProductID = ProductIDUp;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteLike_Product(
	UserIDDel		int		,
    ProductIDDel	int		      
)
BEGIN
    DELETE FROM LIKE_PRODUCT 
    WHERE UserID = UserIDDel
		AND ProductID = ProductIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetLike_ProductByUser(
	UserID		int			      
)
BEGIN
    SELECT * FROM LIKE_PRODUCT a
    WHERE a.UserID = UserID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_CountLike_ProductByUserID(
	UserID		int			      
)
BEGIN
	SELECT COUNT(*)
    FROM LIKE_PRODUCT a
    WHERE a.UserID = UserID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_StatLike_Product(	
		      
)
BEGIN
	SELECT ProductID, COUNT(*)
    FROM LIKE_PRODUCT
    GROUP BY ProductID;
END;
//
DELIMITER ;

-- ----- PRODUCT_TAG basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertProduct_Tag(
	ProductID	int	,
    TagID		int	
)
BEGIN
	INSERT INTO PRODUCT_TAG (ProductID, TagID)
	VALUES (ProductID, TagID);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateProduct_Tag(
	TagIDUp		int		,
    ProductIDUp	int		,
	ProductID	int		,
    TagID		int				
)
BEGIN
    UPDATE PRODUCT_TAG a
	SET a.TagID = TagID	,
		a.ProductID = ProductID			
    WHERE a.TagID = TagIDUp
		AND a.ProductID= ProductIDUp;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteProduct_Tag(
	TagIDDel		int		,
    ProductIDDel	int		      
)
BEGIN
    DELETE FROM PRODUCT_TAG 
    WHERE TagID = TagIDDel
		AND ProductID = ProductIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteProduct_TagByProductID(
    ProductIDDel	int		      
)
BEGIN
    DELETE FROM PRODUCT_TAG 
    WHERE ProductID = ProductIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteProduct_TagByTagID(
    TagIDDel	int		      
)
BEGIN
    DELETE FROM PRODUCT_TAG 
    WHERE TagID = TagIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllProduct_Tag(       
)
BEGIN
    SELECT * FROM PRODUCT_TAG;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetProduct_TagByTagID(
	TagID		int
)
BEGIN
    SELECT * FROM PRODUCT_TAG a
    WHERE a.TagID = TagID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetProduct_TagByProductID(
	ProductID		int
)
BEGIN
    SELECT * FROM PRODUCT_TAG a
    WHERE a.ProductID = ProductID;
END;
//
DELIMITER ;

-- ----- PRODUCT_COLOUR basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertProduct_Colour(
	ProductID	int	,
    ColourID	int	
)
BEGIN
	INSERT INTO PRODUCT_COLOUR (ProductID, ColourID	)
	VALUES (ProductID, ColourID	);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateProduct_Colour(
	ColourIDUp	int		,
    ProductIDUp	int		,
	ProductID	int	,
    ColourID	int				
)
BEGIN
    UPDATE PRODUCT_COLOUR a
	SET a.ColourID = ColourID	,
		a.ProductID = ProductID			
    WHERE a.ColourID = ColourIDup
		AND a.ProductID= ProductIDUp;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteProduct_Colour(
	ProductIDDel	int	,
    ColourIDDel		int		      
)
BEGIN
    DELETE FROM PRODUCT_COLOUR 
    WHERE ColourID = ColourIDDel
		AND ProductID = ProductIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteProduct_ColourByProductID(
    ProductIDDel	int		      
)
BEGIN
    DELETE FROM PRODUCT_COLOUR 
    WHERE ProductIDDel = ProductID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteProduct_ColourByTagID(
    ColourIDDel	int		      
)
BEGIN
    DELETE FROM PRODUCT_COLOUR 
    WHERE ColourID = ColourIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllProduct_Colour(       
)
BEGIN
    SELECT * FROM PRODUCT_COLOUR;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetProduct_ColourByColourID(
	ColourID		int
)
BEGIN
    SELECT * FROM PRODUCT_COLOUR a
    WHERE a.ColourID = ColourID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetProduct_ColourByProductID(
	ProductID		int
)
BEGIN
    SELECT * FROM PRODUCT_COLOUR a
    WHERE a.ProductID = ProductID;
END;
//
DELIMITER ;

-- ----- RECEIPT_VOUCHER basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertReceipt_Voucher(
	ReceiptID	int	,
    VoucherID	int	
)
BEGIN
	INSERT INTO RECEIPT_VOUCHER (ReceiptID, VoucherID)
	VALUES (ReceiptID, VoucherID);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateReceipt_Voucher(
	ReceiptIDUp	int		,
    VoucherIDUp	int		,
	ReceiptID	int	,
    VoucherID	int				
)
BEGIN	
    UPDATE RECEIPT_VOUCHER a
	SET a.VoucherID = VoucherID	,
		a.ReceiptID = ReceiptID			
    WHERE a.VoucherID = VoucherIDUp
		AND a.ReceiptID = ReceiptIDUp;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteReceipt_Voucher(
	VoucherIDDel	int		,
    ReceiptIDDel	int		      
)
BEGIN
    DELETE FROM RECEIPT_VOUCHER 
    WHERE VoucherID = VoucherIDDel
		AND ReceiptID	 = ReceiptIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteReceipt_VoucherByVoucherID(
    VoucherIDDel	int		      
)
BEGIN
    DELETE FROM RECEIPT_VOUCHER 
    WHERE VoucherIDDel = VoucherID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteReceipt_VoucherByReceiptID(
    ReceiptIDDel	int		      
)
BEGIN
    DELETE FROM RECEIPT_VOUCHER 
    WHERE ReceiptID = ReceiptIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllReceipt_Voucher(       
)
BEGIN
    SELECT * FROM RECEIPT_VOUCHER;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceipt_VoucherByReceiptID(
	ReceiptID		int
)
BEGIN
    SELECT * FROM RECEIPT_VOUCHER a
    WHERE a.ReceiptID = ReceiptID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceipt_VoucherByVoucherID(
	VoucherID		int
)
BEGIN
    SELECT * FROM RECEIPT_VOUCHER a
    WHERE a.VoucherID = VoucherID;
END;
//
DELIMITER ;

-- ----- RECEIPT_DETAIL basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertReceipt_Detail(
	ReceiptID	int	,
    ProductID	int	,
    Amount		int			,
    ColourID	int	
)
BEGIN
	INSERT INTO RECEIPT_DETAIL (ReceiptID, ProductID, Amount, ColourID)
	VALUES (ReceiptID, VoucherID, Amount, ColourID);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateReceipt_Detail(
	ReceiptIDUp	int		,
    ProductIDUp	int		,
    ColourIDUp	int	,
	ReceiptID	int	,
    ProductID	int	,
    Amount		int			,
    ColourID	int				
)
BEGIN	
    UPDATE RECEIPT_DETAIL a
	SET a.ProductID = ProductID	,
		a.ReceiptID = ReceiptID	,
        a.Amount = Amount,
        a.ColourID = ColourID
    WHERE a.VoucherID = VoucherIDUp
		AND a.ProductID = ProductIDUp
        AND a.ColourID = ColourIDUp;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteReceipt_Detail(
	ReceiptIDDel	int		,
    ProductIDDel	int		,
    ColourIDDel		int	      
)
BEGIN
    DELETE FROM RECEIPT_DETAIL 
    WHERE VoucherID = VoucherIDDel
		AND ProductID = ReceiptIDDel
        AND ColourID = ColourIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteReceipt_DetailByProductID(
    ProductIDDel	int		      
)
BEGIN
    DELETE FROM RECEIPT_DETAIL 
    WHERE ProductIDDel = ProductID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteReceipt_DetailByReceiptID(
    ReceiptIDDel	int		      
)
BEGIN
    DELETE FROM RECEIPT_DETAIL 
    WHERE ReceiptID = ReceiptIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteReceipt_DetailByColourID(
    ColourIDDel	int		      
)
BEGIN
    DELETE FROM RECEIPT_DETAIL 
    WHERE ColourID = ColourIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceipt_DetailByProductID(
	ProductID		int
)
BEGIN
    SELECT * FROM RECEIPT_DETAIL a
    WHERE a.ProductID = ProductID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceipt_DetailByReceiptID(
	ReceiptID		int
)
BEGIN
    SELECT * FROM RECEIPT_DETAIL a
    WHERE a.ReceiptID = ReceiptID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetReceipt_DetailByColourID(
	ColourID		int
)
BEGIN
    SELECT * FROM RECEIPT_DETAIL a
    WHERE a.ColourID = ColourID;
END;
//
DELIMITER ;

-- ----- USER_ROLE basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertUser_Role(
	UserID		int	,
    RoleID		int	
)
BEGIN
	INSERT INTO USER_ROLE (UserID, RoleID)
	VALUES (UserID, RoleID);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateUser_Role(
	UserIDUp	int	,
    RoleIDUp	int	,
	UserID		int	,
    RoleID		int				
)
BEGIN	
    UPDATE USER_ROLE a
	SET a.UserID = UserID	,
		a.RoleID = RoleID			
    WHERE a.UserID = UserIDUp
		AND a.RoleID = RoleIDUp;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteUser_Role(
	UserIDDel	int	,
    RoleIDDel	int	 
)
BEGIN
    DELETE FROM USER_ROLE 
    WHERE UserID = UserIDDel
		AND RoleID = RoleIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteUser_RoleByUserID(
    UserIDDel	int		      
)
BEGIN
    DELETE FROM USER_ROLE 
    WHERE UserID = UserIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteUser_RoleByRoleID(
    RoleIDDel	int		      
)
BEGIN
    DELETE FROM USER_ROLE 
    WHERE RoleID = RoleIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllUser_Role(       
)
BEGIN
    SELECT * FROM USER_ROLE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetUser_RoleByUserID(
	UserID		int
)
BEGIN
    SELECT * FROM USER_ROLE a
    WHERE a.UserID = UserID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetUser_RoleByRoleID(
	RoleID		int
)
BEGIN
    SELECT * FROM USER_ROLE a
    WHERE a.RoleID = RoleID;
END;
//
DELIMITER ;

-- ----- ROLE_PERMISSION basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_InsertRole_Permission(
	RoleID				int	,
    PermissionID		int	
)
BEGIN
	INSERT INTO ROLE_PERMISSION (PermissionID, RoleID)
	VALUES (PermissionID, RoleID);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_UpdateRole_Permission(
	PermissionIDUp	int	,
    RoleIDUp		int	,
	PermissionID	int	,
    RoleID			int				
)
BEGIN	
    UPDATE ROLE_PERMISSION a
	SET a.PermissionID = PermissionID	,
		a.RoleID = RoleID			
    WHERE a.PermissionID = PermissionIDUp
		AND a.RoleID = RoleIDUp;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteRole_Permission(
	PermissionIDDel	int	,
    RoleIDDel		int	 
)
BEGIN
    DELETE FROM ROLE_PERMISSION 
    WHERE PermissionIDDel = PermissionID
		AND RoleID = RoleIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteRole_PermissionByPermissionID(
    PermissionIDDel	int		      
)
BEGIN
    DELETE FROM ROLE_PERMISSION 
    WHERE PermissionID = PermissionIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteRole_PermissionByRoleID(
    RoleIDDel	int		      
)
BEGIN
    DELETE FROM ROLE_PERMISSION 
    WHERE RoleID = RoleIDDel;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetAllRole_Permission(       
)
BEGIN
    SELECT * FROM ROLE_PERMISSION;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetRole_PermissionByPermissionID(
	PermissionID		int
)
BEGIN
    SELECT * FROM ROLE_PERMISSION a
    WHERE a.PermissionID = PermissionID;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_GetRole_PermissionByRoleID(
	RoleID		int
)
BEGIN
    SELECT * FROM ROLE_PERMISSION a
    WHERE a.RoleID = RoleID;
END;
//
DELIMITER ;

-- ----- ARGUMENTS basic sp & tg ----- --

DELIMITER //
CREATE PROCEDURE sp_UpdateArgument(
	RegAge				int			,
    MinPaid				decimal(10, 2),
    RatingUpper			int			,
    RatingLower			int					
)
BEGIN	
    UPDATE ARGUMENTS a
	SET a.RegAge = RegAge	,
		a.MinPaid = MinPaid	,
        a.RatingUpper = RatingUpper	,
        a.RatingLower = RatingLower	;			
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DefaultArgument(

)
BEGIN
	UPDATE ARGUMENTS a
	SET a.RegAge = 18	,
		a.MinPaid = 0	,
        a.RatingUpper = 5	,
        a.RatingLower = 0	;	
END;
//
DELIMITER ;

INSERT INTO TAGS (Name)
VALUE
	('Bedroom'),
	('Diningroom'),
	('Livingroom'),
	('Accent Tables'),
	('Beds'),
	('Benches & Ottomans'),
	('Chairs'),
	('Nightstands & Dressers'),
	('Tables'),
	('Stools'),
	('Sectionals'),
	('Sofas');
