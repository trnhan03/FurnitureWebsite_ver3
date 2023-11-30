create database FurnitureWebsite;
go
use FurnitureWebsite
go
/* 
use master
go
drop database FurnitureWebsite
*/

 
create table PRODUCTS(
	ID      	int identity,
	Name    	varchar(250) 	unique ,
	Info    	varchar(1000)	,
	Price   	int         	,
    Material	varchar(30)		,
	Width		float			,
    Height		float			,
    Depth		float			,
    Weight		float			,
	ImgDirect	varchar(250)	,
	primary key (ID)
);

 
create table USERS(
	ID			int identity,
    UserName	varchar(25)		unique ,
    PassWord	varchar(250)	,
    FirstName	varchar(30)		,
    LastName	varchar(70)		,
    Phone		varchar(20)		,
    Mail		varchar(50)		,
    RegDate		date			default (convert(date, getdate())),
    BirthYear	int				,
    primary key (ID)
);

 
create table RECEIPTS(
	ID			int identity,
	Date 		date 			default (convert(date, getdate())),
	Paid		int         	default 0,
	UserID		int 	,
	Status		varchar(25)		default 'Shopping',
	check(Status in('Shopping', 'Pending', 'Delivering', 'Complete', 'Cancelled')),
    primary key (ID)
);

 
create table VOUCHERS(
	ID			int identity,
	Name		varchar(250)	unique ,
	Type		varchar(25)		default 'Percentage',
	Value		decimal(10, 2) 	,
	ValidDate	date			,
	check(Type in('Percentage', 'Value')),
	primary key (ID)
);

 
create table TAGS(
	ID		int identity,
	Name	varchar(250)	unique ,
    primary key (ID)
);

 
create table COLOURS(
	ID		int identity,
    Name	varchar(250)	unique ,
    Barcode	varchar(10)		unique ,
    primary key (ID)
);

 
create table ROLES(
	ID		int identity,
    Name	varchar(250)	unique ,
    primary key (ID)
);

 
create table PERMISSIONS(
	ID		int identity,
    Name	varchar(250)	unique ,
    primary key (ID)
);

 
create table REVENUES(
	Year	int		default (year(getdate()))	,
    Month	int		default (month(getdate()))	,
    Value	int		default 0					,
    primary key (Year, Month)
);

 
create table COMMENTS(
    UserID		int		,
    ProductID	int				,
    Content		varchar(1000)	,
    Date		datetime2(0)		default (getdate()),
    Rating		float			,
    primary key (UserID, ProductID)
);

 
create table LIKE_PRODUCT(
    UserID		int		,
    ProductID	int				,
    Content		varchar(1000)	,
    Date		date			default (convert(date, getdate())),
    primary key (UserID, ProductID)
);

 
create table PRODUCT_TAG(
	ProductID	int	,
    TagID		int	,
    primary key (ProductID, TagID)
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
go

-- Add foreign key
alter table PRODUCT_TAG
add foreign key (ProductID)		references PRODUCTS(ID);
alter table PRODUCT_TAG
add foreign key (TagID)			references TAGS(ID);
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
alter table RECEIPTS
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

go

-- ---- PRODUCT ----- --

 
CREATE PROCEDURE sp_InsertProduct(
	@Name    	varchar(250) 	,
	@Info    	varchar(1000)	,
	@Price   	int         	,
    @Material	varchar(30)		,
	@Width		float			,
    @Height		float			,
    @Depth		float			,
    @Weight		float			,
	@ImgDirect  varchar(250) 	
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO PRODUCTS (Name, Info, Price, Material,
						Width, Height, Depth, Weight, ImgDirect)
	VALUES (@Name, @Info, @Price, @Material,
						@Width, @Height, @Depth, @Weight, @ImgDirect);
END;
GO

 
CREATE PROCEDURE sp_UpdateProduct(
	@IDUp		int		,
--	@ID			int 	,
	@Name    	varchar(250) 	,
	@Info    	varchar(1000)	,
	@Price   	int         	,
    @Material	varchar(30)		,
	@Width		float			,
    @Height		float			,
    @Depth		float			,
    @Weight		float			,
	@ImgDirect  varchar(250)	
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE PRODUCTS
	SET --ID = @ID, 
		Name = @Name, 
		Info = @Info, 
        Price = @Price,
        Material = @Material,
        Width = @Width,
        Height = @Height,
        Depth = @Depth,
        Weight = @Weight,
		ImgDirect = @ImgDirect
	WHERE @IDUp = ID;
END;
GO

 
CREATE PROCEDURE sp_DeleteProduct(
	@IDDel	int          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM PRODUCTS WHERE ID = @IDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllProduct
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT *
	FROM PRODUCTS;
END;
GO

 
CREATE PROCEDURE sp_GetProductByName(       
	@Name      varchar(250)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT *
    FROM PRODUCTS a
    WHERE a.Name LIKE @Name;
END;
GO

 
CREATE PROCEDURE sp_GetProduct(       
	@ID      int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT *
    FROM PRODUCTS a
    WHERE a.ID = @ID;
END;
GO

-- ----- USER ----- --

 
CREATE PROCEDURE sp_InsertUser(
	@UserName	varchar(25)		,
    @PassWord	varchar(250)	,
    @FirstName	varchar(30)		,
    @LastName	varchar(70)		,
    @Phone		varchar(20)		,
    @Mail		varchar(50)		,
    @BirthYear	int				
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO USERS (UserName, PassWord, FirstName, LastName,
						Phone, Mail, BirthYear)
	VALUES (@UserName, @PassWord, @FirstName, @LastName,
						@Phone, @Mail, @BirthYear);
END;
GO

 
CREATE PROCEDURE sp_UpdateUser(
	@IDUp		int		,
	--@ID			int		,
    @UserName	varchar(25)		,
    @PassWord	varchar(250)	,
    @FirstName	varchar(30)		,
    @LastName	varchar(70)		,
    @Phone		varchar(20)		,
    @Mail		varchar(50)		,
    @RegDate		date			,
    @BirthYear	int				
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE USERS
	SET --ID = @ID			,
		UserName = @UserName	,
        PassWord = @PassWord	,
		FirstName = @FirstName	,
		LastName = @LastName	,
		Phone = @Phone		,
		Mail = @Mail		,
		RegDate = @RegDate		,
		BirthYear = @BirthYear	
	WHERE @IDUp = ID;
END;
GO

 
CREATE PROCEDURE sp_DeleteUserByUserName(
	@UserNameDel	varchar(25)          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM USERS WHERE UserName = @UserNameDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteUser(
	@IDDel	varchar(25)          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM USERS WHERE ID = @IDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllUser
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM USERS;
END;
GO

 
CREATE PROCEDURE sp_GetUserByUserName(  
	@UserName varchar(25)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM USERS a
    WHERE a.UserName LIKE @UserName;
END;
GO

 
CREATE PROCEDURE sp_GetUser(  
	@ID varchar(25)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM USERS a
    WHERE a.ID LIKE @ID;
END;
GO

 
CREATE PROCEDURE sp_GetUserByLastName(  
	@LastName varchar(25)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM USERS a
    WHERE a.LastName LIKE @LastName;
END;
GO

 
CREATE PROCEDURE sp_GetUserByFirstName(  
	@FirstName varchar(25)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM USERS a
    WHERE a.FirstName LIKE @FirstName;
END;
GO

-- ----- RECEIPT ----- --

 
CREATE PROCEDURE sp_InsertReceipt(
	@UserID  	int 	       
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO RECEIPTS (UserID)
	VALUES (@UserID);
END;
GO

 
CREATE PROCEDURE sp_UpdateReceipt(
	@IDUp		int		,
	--@ID        	int 	,
	@Date 		date 			,
	@Paid      	int         	,
	@UserID  	int				,
	@Status		varchar(25)
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE RECEIPTS
	SET --ID = @ID, 
		Date = @Date, 
		Paid = @Paid, 
        UserID = @UserID,
        Status = @Status
	WHERE @IDUp = ID;
END;
GO

 
CREATE PROCEDURE sp_DeleteReceipt(
	@IDDel	int          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM RECEIPTS WHERE ID = @IDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllReceipt
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM RECEIPTS;
END;
GO

 
CREATE PROCEDURE sp_GetReceipt(
	@ID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM RECEIPTS a
    WHERE a.ID = @ID;
END;
GO

 
CREATE PROCEDURE sp_GetReceiptByUserID(       
	@UserID      varchar(25)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM RECEIPTS a
    WHERE a.UserID = @UserID;
END;
GO

 
CREATE PROCEDURE sp_GetReceiptByStatus(       
	@Status      varchar(25)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM RECEIPTS a
    WHERE a.Status = @Status;
END;
GO

 
CREATE PROCEDURE sp_GetReceiptBetweenTime(       
	@Timeline1      Date,
    @Timeline2      Date	
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM RECEIPTS a
    WHERE a.Date BETWEEN @Timeline1 AND @Timeline2;
END;
GO

-- ----- VOUCHER ----- --

 
CREATE PROCEDURE sp_InsertVoucher(
	@Name		varchar(250)	,
	@Type      	varchar(25)		,
	@Value		decimal(10, 2) 	,
	@ValidDate	date			      	         
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO VOUCHERS (Name, Type, Value, ValidDate)
	VALUES (@Name, @Type, @Value, @ValidDate);
END;
GO

 
CREATE PROCEDURE sp_UpdateVoucher(
	@IDUp		int		,
	--@ID        	int 	,
	@Name		varchar(250)	,
	@Type      	varchar(25)		,
	@Value		decimal(10, 2) 	,
	@ValidDate	date	
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE VOUCHERS
	SET --ID = @ID, 
		Name = @Name, 
		Type = @Type, 
        Value = @Value,
        ValidDate = @ValidDate
	WHERE @IDUp = ID;
END;
GO

 
CREATE PROCEDURE sp_DeleteVoucher(
	@IDDel	int          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM VOUCHERS WHERE ID = @IDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllVoucher
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM VOUCHERS;
END;
GO

 
CREATE PROCEDURE sp_GetVoucher(       
	@ID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM VOUCHERS a
    WHERE a.ID = @ID;
END;
GO

 
CREATE PROCEDURE sp_GetVoucherByName(       
	@Name      varchar(250)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM VOUCHERS a
    WHERE a.Name LIKE @Name;
END;
GO

-- ----- TAG ----- --

 
CREATE PROCEDURE sp_InsertTag(
    @Name	varchar(250)		         
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO TAGS (Name)
	VALUES (@Name);
END;
GO

 
CREATE PROCEDURE sp_UpdateTag(
	@IDUp		int		,
	--@ID			int 	,
	@Name		varchar(250) 	
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE TAGS
	SET --ID = @ID, 
		Name = @Name
	WHERE @IDUp = ID;
END;
GO

 
CREATE PROCEDURE sp_DeleteTag(
	@IDDel	int          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM TAGS WHERE ID = @IDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllTag
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM TAGS;
END;
GO

 
CREATE PROCEDURE sp_GetTag(  
	@ID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM TAGS a
    WHERE a.ID = @ID;
END;
GO

 
CREATE PROCEDURE sp_GetTagByName(       
	@Name      varchar(250)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM TAGS a
    WHERE a.Name LIKE @Name;
END;
GO

-- ----- COLOUR ----- --

 
CREATE PROCEDURE sp_InsertColour(
	@Name	varchar(250)	,
    @Barcode	varchar(10)		    	         
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO COLOURS (Name, Barcode)
	VALUES (@Name, @Barcode);
END;
GO

 
CREATE PROCEDURE sp_UpdateColour(
	@IDUp		int		,
	--@ID			int		,
    @Name		varchar(250)	,
    @Barcode		varchar(10)		
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE COLOURS
	SET --ID = @ID, 
		Name = @Name, 
		Barcode = @Barcode
	WHERE @IDUp = ID;
END;
GO

 
CREATE PROCEDURE sp_DeleteColour(
	@IDDel	int          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM COLOURS WHERE ID = @IDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllColour
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM COLOURS;
END;
GO

 
CREATE PROCEDURE sp_GetColour( 
	@ID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM COLOURS a
    WHERE a.ID = @ID;
END;
GO

 
CREATE PROCEDURE sp_GetColourByName(       
	@Name      varchar(250)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM COLOURS a
    WHERE a.Name LIKE @Name;
END;
GO

-- ----- ROLE ----- --

 
CREATE PROCEDURE sp_InsertRole(
	@Name		varchar(250) 	    	         
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO ROLES (Name)
	VALUES (@Name);
END;
GO

 
CREATE PROCEDURE sp_UpdateRole(
	@IDUp		int		,
	--@ID			int 	,
	@Name		varchar(250) 	
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE ROLES
	SET --ID = @ID, 
		Name = @Name
	WHERE @IDUp = ID;
END;
GO

 
CREATE PROCEDURE sp_DeleteRole(
	@IDDel	int          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM ROLES WHERE ID = @IDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllRole
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM ROLES;
END;
GO

 
CREATE PROCEDURE sp_GetRole( 
	@ID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM ROLES a
    WHERE a.ID = @ID;
END;
GO

 
CREATE PROCEDURE sp_GetRoleByName(       
	@Name      varchar(250)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM ROLES a
    WHERE a.Name LIKE @Name;
END;
GO

-- ----- PERMISSION ----- --

 
CREATE PROCEDURE sp_InsertPermission(
	@Name		varchar(250) 	 	         
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO PERMISSIONS (Name)
	VALUES (@Name);
END;
GO

 
CREATE PROCEDURE sp_UpdatePermission(
	@IDUp		int		,
	--@ID			int 	,
	@Name		varchar(250) 	
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE PERMISSIONS
	SET --ID = @ID, 
		Name = @Name
	WHERE @IDUp = ID;
END;
GO

 
CREATE PROCEDURE sp_DeletePermission(
	@IDDel	int          
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM PERMISSIONS WHERE ID = @IDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllPermission
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM PERMISSIONS;
END;
GO

 
CREATE PROCEDURE sp_GetPermission(  
	@ID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM PERMISSIONS a
    WHERE a.ID = @ID;
END;
GO

 
CREATE PROCEDURE sp_GetPermissionByName(       
	@Name      varchar(250)
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM PERMISSIONS a
    WHERE a.Name LIKE @Name;
END;
GO

-- ----- REVENUE ----- --

 
CREATE PROCEDURE sp_InsertRevenue(
    @Value 	decimal(10, 2)
)
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @existingRecord INT;

     
    SELECT @existingRecord = COUNT(*)
    FROM REVENUES
    WHERE Year = YEAR(getdate()) AND Month = MONTH(getdate());

    IF @existingRecord = 0 BEGIN
         
        INSERT INTO REVENUES (Value)
        VALUES (@Value);
    END
    ELSE BEGIN
        UPDATE REVENUES
        SET Value = Value + @Value
        WHERE Year = YEAR(getdate()) AND Month = MONTH(getdate());
    END 
END;
GO

 
CREATE PROCEDURE sp_DeleteRevenue(
	@YearDel		int,
    @MonthDel	int
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM REVENUES WHERE Year = @YearDel 
							AND Month = @MonthDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllRevenue
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM REVENUES;
END;
GO

 
CREATE PROCEDURE sp_GetRevenue(
	@Year		int,
    @Month		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM REVENUES a
    WHERE a.Year = @Year AND a.Month = @Month;
END;
GO

 
CREATE PROCEDURE sp_GetRevenueByMonth(
    @Month	int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM REVENUES a
    WHERE a.Month = @Month;
END;
GO

 
CREATE PROCEDURE sp_GetRevenueByYear(
    @Year	int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM REVENUES a
    WHERE a.Year = @Year;
END;
GO


 
CREATE PROCEDURE sp_GetQuarterlyRevenuesForAllYears
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @current_year INT;
    DECLARE @current_quarter INT;

    DECLARE @total_q1 INT;
    DECLARE @total_q2 INT;
    DECLARE @total_q3 INT;
    DECLARE @total_q4 INT;

    DECLARE year_cursor CURSOR LOCAL FOR
        SELECT DISTINCT Year FROM REVENUES ORDER BY Year;

    --DECLARE CONTINUE HANDLER FOR NOT FOUND SET @current_year = NULL;

    SET @total_q1 = 0;
    SET @total_q2 = 0;
    SET @total_q3 = 0;
    SET @total_q4 = 0;

    OPEN year_cursor;

    FETCH year_cursor INTO @current_year;

    WHILE @current_year IS NOT NULL BEGIN
        SET @total_q1 = 0;
        SET @total_q2 = 0;
        SET @total_q3 = 0;
        SET @total_q4 = 0;

         
        SELECT
            @total_q1 = SUM(CASE WHEN Month BETWEEN 1 AND 3 THEN Value ELSE 0 END),
            @total_q2 = SUM(CASE WHEN Month BETWEEN 4 AND 6 THEN Value ELSE 0 END),
            @total_q3 = SUM(CASE WHEN Month BETWEEN 7 AND 9 THEN Value ELSE 0 END),
            @total_q4 = SUM(CASE WHEN Month BETWEEN 10 AND 12 THEN Value ELSE 0 END)
        FROM REVENUES a
        WHERE Year = @current_year;

         
        SELECT @current_year AS Year, @total_q1 AS Q1, @total_q2 AS Q2, @total_q3 AS Q3, @total_q4 AS Q4;

        FETCH year_cursor INTO @current_year;
    END;

    CLOSE year_cursor;
END; 
GO


-- ----- COMMENT ----- --

 
CREATE PROCEDURE sp_InsertComment(
    @UserID		int		,
    @ProductID	int		,
    @Content		varchar(1000)	,
    @Rating		float			
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO COMMENTS (UserID, ProductID, Content,
						Rating)
	VALUES (@UserID, @ProductID, @Content,
						@Rating);
END;
GO

 
CREATE PROCEDURE sp_UpdateComment(
	@UserIDUp	int		,
    @ProductIDUp	int		,
    @UserID		int		,
    @ProductID	int		,
    @Content		varchar(1000)	,
    @Rating		float				
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE COMMENTS
	SET UserID = @UserID	,
		ProductID = @ProductID	,
		Content = @Content	,
        Date = (getdate())	,
		Rating = @Rating		
    WHERE UserID = @UserIDUp
		AND ProductID = @ProductIDUp;
END;
GO

 
CREATE PROCEDURE sp_DeleteComment(
	@UserIDDel		int		,
    @ProductIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM COMMENTS 
    WHERE UserID = @UserIDDel
		AND ProductID = @ProductIDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllComment
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM COMMENTS;
END;
GO

 
CREATE PROCEDURE sp_GetCommentByProductID(       
	@ProductID      int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM COMMENTS a
    WHERE a.ProductID = @ProductID;
END;
GO

 
CREATE PROCEDURE sp_GetCommentByUserID(       
	@UserID      int	
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM COMMENTS a
    WHERE a.UserID = @UserID;
END;
GO

 
CREATE PROCEDURE sp_GetComment(       
	@UserID			int,
    @ProductID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * 
    FROM COMMENTS a
    WHERE a.UserID = @UserID
		AND a.ProductID = @ProductID;
END;
GO

-- ----- LIKE_PRODUCT ----- --

 
CREATE PROCEDURE sp_InsertLike_Product(
	@UserID		varchar(25)		,
    @ProductID	int		,
    @Content		varchar(1000)	
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO LIKE_PRODUCT (UserID, ProductID, Content)
	VALUES (@UserID, @ProductID, @Content);
END;
GO

 
CREATE PROCEDURE sp_UpdateLike_Product(
	@UserIDUp	int		,
    @ProductIDUp	int		,
	@UserID		int		,
    @ProductID	int		,
    @Content		varchar(1000)				
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE LIKE_PRODUCT
	SET UserID = @UserID	,
		ProductID = @ProductID	,
		Content = @Content	,
        Date = (getdate())		
    WHERE UserID = @UserIDUp
		AND ProductID = @ProductIDUp;
END;
GO

 
CREATE PROCEDURE sp_DeleteLike_Product(
	@UserIDDel		int		,
    @ProductIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM LIKE_PRODUCT 
    WHERE UserID = @UserIDDel
		AND ProductID = @ProductIDDel;
END;
GO

 
CREATE PROCEDURE sp_GetLike_ProductByUser(
	@UserID		int			      
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM LIKE_PRODUCT a
    WHERE a.UserID = @UserID;
END;
GO

 
CREATE PROCEDURE sp_CountLike_ProductByUserID(
	@UserID		int			      
)
AS
BEGIN
SET NOCOUNT ON;
	 
	SELECT COUNT(*)
    FROM LIKE_PRODUCT a
    WHERE a.UserID = @UserID;
END;
GO

 
CREATE PROCEDURE sp_StatLike_Product
AS
BEGIN
SET NOCOUNT ON;
	 
	SELECT ProductID, COUNT(*)
    FROM LIKE_PRODUCT
    GROUP BY ProductID;
END;
GO

-- ----- PRODUCT_TAG ----- --

 
CREATE PROCEDURE sp_InsertProduct_Tag(
	@ProductID	int	,
    @TagID		int	
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO PRODUCT_TAG (ProductID, TagID)
	VALUES (@ProductID, @TagID);
END;
GO

 
CREATE PROCEDURE sp_UpdateProduct_Tag(
	@TagIDUp		int		,
    @ProductIDUp	int		,
	@ProductID	int		,
    @TagID		int				
)
AS
BEGIN
SET NOCOUNT ON;
    UPDATE PRODUCT_TAG
	SET TagID = @TagID	,
		ProductID = @ProductID			
    WHERE TagID = @TagIDUp
		AND ProductID= @ProductIDUp;
END;
GO

 
CREATE PROCEDURE sp_DeleteProduct_Tag(
	@TagIDDel		int		,
    @ProductIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM PRODUCT_TAG 
    WHERE TagID = @TagIDDel
		AND ProductID = @ProductIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteProduct_TagByProductID(
    @ProductIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM PRODUCT_TAG 
    WHERE ProductID = @ProductIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteProduct_TagByTagID(
    @TagIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM PRODUCT_TAG 
    WHERE TagID = @TagIDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllProduct_Tag
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM PRODUCT_TAG;
END;
GO

 
CREATE PROCEDURE sp_GetProduct_TagByTagID(
	@TagID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM PRODUCT_TAG a
    WHERE a.TagID = @TagID;
END;
GO

 
CREATE PROCEDURE sp_GetProduct_TagByProductID(
	@ProductID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM PRODUCT_TAG a
    WHERE a.ProductID = @ProductID;
END;
GO

-- ----- RECEIPT_VOUCHER ----- --

 
CREATE PROCEDURE sp_InsertReceipt_Voucher(
	@ReceiptID	int	,
    @VoucherID	int	
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO RECEIPT_VOUCHER (ReceiptID, VoucherID)
	VALUES (@ReceiptID, @VoucherID);
END;
GO

 
CREATE PROCEDURE sp_UpdateReceipt_Voucher(
	@ReceiptIDUp	int		,
    @VoucherIDUp	int		,
	@ReceiptID	int	,
    @VoucherID	int				
)
AS
BEGIN
SET NOCOUNT ON;	
    UPDATE RECEIPT_VOUCHER
	SET VoucherID = @VoucherID	,
		ReceiptID = @ReceiptID			
    WHERE VoucherID = @VoucherIDUp
		AND ReceiptID = @ReceiptIDUp;
END;
GO

 
CREATE PROCEDURE sp_DeleteReceipt_Voucher(
	@VoucherIDDel	int		,
    @ReceiptIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM RECEIPT_VOUCHER 
    WHERE VoucherID = @VoucherIDDel
		AND ReceiptID	 = @ReceiptIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteReceipt_VoucherByVoucherID(
    @VoucherIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM RECEIPT_VOUCHER 
    WHERE @VoucherIDDel = VoucherID;
END;
GO

 
CREATE PROCEDURE sp_DeleteReceipt_VoucherByReceiptID(
    @ReceiptIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM RECEIPT_VOUCHER 
    WHERE ReceiptID = @ReceiptIDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllReceipt_Voucher
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM RECEIPT_VOUCHER;
END;
GO

 
CREATE PROCEDURE sp_GetReceipt_VoucherByReceiptID(
	@ReceiptID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM RECEIPT_VOUCHER a
    WHERE a.ReceiptID = @ReceiptID;
END;
GO

 
CREATE PROCEDURE sp_GetReceipt_VoucherByVoucherID(
	@VoucherID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM RECEIPT_VOUCHER a
    WHERE a.VoucherID = @VoucherID;
END;
GO

-- ----- RECEIPT_DETAIL ----- --

 
CREATE PROCEDURE sp_InsertReceipt_Detail(
	@ReceiptID	int	,
    @ProductID	int	,
    @Amount		int			,
    @ColourID	int	
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO RECEIPT_DETAIL (ReceiptID, ProductID, Amount, ColourID)
	VALUES (@ReceiptID, @ProductID, @Amount, @ColourID);
END;
GO

 
CREATE PROCEDURE sp_UpdateReceipt_Detail(
	@ReceiptIDUp	int		,
    @ProductIDUp	int		,
    @ColourIDUp	int	,
	@ReceiptID	int	,
    @ProductID	int	,
    @Amount		int			,
    @ColourID	int				
)
AS
BEGIN
SET NOCOUNT ON;	
    UPDATE RECEIPT_DETAIL
	SET ProductID = @ProductID	,
		ReceiptID = @ReceiptID	,
        Amount = @Amount,
        ColourID = @ColourID
    WHERE ReceiptID = @ReceiptIDUp
		AND ProductID = @ProductIDUp
        AND ColourID = @ColourIDUp;
END;
GO

 
CREATE PROCEDURE sp_DeleteReceipt_Detail(
	@ReceiptIDDel	int		,
    @ProductIDDel	int		,
    @ColourIDDel		int	      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM RECEIPT_DETAIL 
    WHERE ReceiptID = @ReceiptIDDel
		AND ProductID = @ReceiptIDDel
        AND ColourID = @ColourIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteReceipt_DetailByProductID(
    @ProductIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM RECEIPT_DETAIL 
    WHERE @ProductIDDel = ProductID;
END;
GO

 
CREATE PROCEDURE sp_DeleteReceipt_DetailByReceiptID(
    @ReceiptIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM RECEIPT_DETAIL 
    WHERE ReceiptID = @ReceiptIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteReceipt_DetailByColourID(
    @ColourIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM RECEIPT_DETAIL 
    WHERE ColourID = @ColourIDDel;
END;
GO

 
CREATE PROCEDURE sp_GetReceipt_DetailByProductID(
	@ProductID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM RECEIPT_DETAIL a
    WHERE a.ProductID = @ProductID;
END;
GO

 
CREATE PROCEDURE sp_GetReceipt_DetailByReceiptID(
	@ReceiptID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM RECEIPT_DETAIL a
    WHERE a.ReceiptID = @ReceiptID;
END;
GO

 
CREATE PROCEDURE sp_GetReceipt_DetailByColourID(
	@ColourID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM RECEIPT_DETAIL a
    WHERE a.ColourID = @ColourID;
END;
GO

-- ----- USER_ROLE ----- --

 
CREATE PROCEDURE sp_InsertUser_Role(
	@UserID		int	,
    @RoleID		int	
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO USER_ROLE (UserID, RoleID)
	VALUES (@UserID, @RoleID);
END;
GO

 
CREATE PROCEDURE sp_UpdateUser_Role(
	@UserIDUp	int	,
    @RoleIDUp	int	,
	@UserID		int	,
    @RoleID		int				
)
AS
BEGIN
SET NOCOUNT ON;	
    UPDATE USER_ROLE
	SET UserID = @UserID	,
		RoleID = @RoleID			
    WHERE UserID = @UserIDUp
		AND RoleID = @RoleIDUp;
END;
GO

 
CREATE PROCEDURE sp_DeleteUser_Role(
	@UserIDDel	int	,
    @RoleIDDel	int	 
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM USER_ROLE 
    WHERE UserID = @UserIDDel
		AND RoleID = @RoleIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteUser_RoleByUserID(
    @UserIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM USER_ROLE 
    WHERE UserID = @UserIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteUser_RoleByRoleID(
    @RoleIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM USER_ROLE 
    WHERE RoleID = @RoleIDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllUser_Role
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM USER_ROLE;
END;
GO

 
CREATE PROCEDURE sp_GetUser_RoleByUserID(
	@UserID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM USER_ROLE a
    WHERE a.UserID = @UserID;
END;
GO

 
CREATE PROCEDURE sp_GetUser_RoleByRoleID(
	@RoleID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM USER_ROLE a
    WHERE a.RoleID = @RoleID;
END;
GO

-- ----- ROLE_PERMISSION ----- --

 
CREATE PROCEDURE sp_InsertRole_Permission(
	@RoleID				int	,
    @PermissionID		int	
)
AS
BEGIN
SET NOCOUNT ON;
	 
	INSERT INTO ROLE_PERMISSION (PermissionID, RoleID)
	VALUES (@PermissionID, @RoleID);
END;
GO

 
CREATE PROCEDURE sp_UpdateRole_Permission(
	@PermissionIDUp	int	,
    @RoleIDUp		int	,
	@PermissionID	int	,
    @RoleID			int				
)
AS
BEGIN
SET NOCOUNT ON;	
    UPDATE ROLE_PERMISSION
	SET PermissionID = @PermissionID	,
		RoleID = @RoleID			
    WHERE PermissionID = @PermissionIDUp
		AND RoleID = @RoleIDUp;
END;
GO

 
CREATE PROCEDURE sp_DeleteRole_Permission(
	@PermissionIDDel	int	,
    @RoleIDDel		int	 
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM ROLE_PERMISSION 
    WHERE @PermissionIDDel = PermissionID
		AND RoleID = @RoleIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteRole_PermissionByPermissionID(
    @PermissionIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM ROLE_PERMISSION 
    WHERE PermissionID = @PermissionIDDel;
END;
GO

 
CREATE PROCEDURE sp_DeleteRole_PermissionByRoleID(
    @RoleIDDel	int		      
)
AS
BEGIN
SET NOCOUNT ON;
    DELETE FROM ROLE_PERMISSION 
    WHERE RoleID = @RoleIDDel;
END;
GO

 
CREATE PROCEDURE sp_GetAllRole_Permission
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM ROLE_PERMISSION;
END;
GO

 
CREATE PROCEDURE sp_GetRole_PermissionByPermissionID(
	@PermissionID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM ROLE_PERMISSION a
    WHERE a.PermissionID = @PermissionID;
END;
GO

 
CREATE PROCEDURE sp_GetRole_PermissionByRoleID(
	@RoleID		int
)
AS
BEGIN
SET NOCOUNT ON;
     
    SELECT * FROM ROLE_PERMISSION a
    WHERE a.RoleID = @RoleID;
END;
GO

-- ----- ARGUMENT ----- --

 
CREATE PROCEDURE sp_UpdateArgument(
	@RegAge				int			,
    @MinPaid				decimal(10, 2),
    @RatingUpper			int			,
    @RatingLower			int					
)
AS
BEGIN
SET NOCOUNT ON;	
    UPDATE ARGUMENTS
	SET RegAge = @RegAge	,
		MinPaid = @MinPaid	,
        RatingUpper = @RatingUpper	,
        RatingLower = @RatingLower	;			
END;
GO

 
CREATE PROCEDURE sp_DefaultArgument
AS
BEGIN
SET NOCOUNT ON;
	UPDATE ARGUMENTS
	SET RegAge = 18	,
		MinPaid = 0	,
        RatingUpper = 5	,
        RatingLower = 0	;	
END;
GO

-- Add DATA

INSERT INTO PRODUCTS (Name,Info,Price,Material,Width,Height,Depth,Weight,ImgDirect)
VALUES
	('The Bank Console Table','A striking design statement, The Bank is handcrafted of solid American white oak. Designed with a distinctive overlap, the faceted, conical legs add sculptural sensibility, supporting a white oak veneer top with carved beveled edging.',3150,'Natural Oak',60.0,20.0,30.0,60.0,'\assets\Furniture_Photos\Products_Photos\P0001'),
	('The Bowery Table','Modern lines meet plush comfort in this beautifully tailored coffee table ottoman. With a movable solid ash table and subtle detailing throughout, The Bowery is a study in elegant yet functional design.',1675,'Driftwood',47.0,30.0,16.0,47.0,'\assets\Furniture_Photos\Products_Photos\P0002'),
	('The Morro Table','Artisanal woodworking gives The Morro its shapely form and minimalist design. Handcrafted with solid ash wood, each table harmoniously nests together or stands alone, adding an artful presence to any room.',735,'Driftwood',50.0,30.0,30.0,40.0,'\assets\Furniture_Photos\Products_Photos\P0003'),
	('The Reade Console Table','A delicate balance of commanding proportions, The Reade’s handcrafted column legs and intricately designed tabletop create an unforgettable sculptural statement. Expertly crafted of solid ash wood and finished with exquisite artisanship.',2475,'Pecan',60.0,21.0,30.0,72.0,'\assets\Furniture_Photos\Products_Photos\P0004'),
	('The Reade Demilune Console Table','A delicate balance of commanding proportions, The Reade’s handcrafted column legs and intricately designed tabletop create an unforgettable sculptural statement. Expertly crafted of solid ash wood and finished with exquisite artisanship.',1950,'Pecan',42.0,21.0,30.0,50.0,'\assets\Furniture_Photos\Products_Photos\P0005'),
	('The Vestry Table','Handcrafted of solid oak, The Vestry’s organic shape and soft curvature display an expansive statement of natural materiality. Designed to artfully nest together or stand alone in graceful proportion.',1775,'Pecan Oak',40.0,27.0,26.0,48.0,'\assets\Furniture_Photos\Products_Photos\P0006'),
	('The Eldridge Bed','Lushly cushioned and upholstered all around, The Eldridge offers an enveloping experience. Its low, linear silhouette with extended headboard is softened by rounded corners traced with subtle flange seaming.',3885,'Agate',100.0,36.5,70.0,82.0,'\assets\Furniture_Photos\Products_Photos\P0007'),
	('The Essex Bed','Clean lines, classic proportions, and subtle tailoring–the elegance of The Essex lies in its simplicity. A tapered headboard and sleek legs lend a modern edge to this striking shape.',2225,'Pecan',70.0,50.0,80.0,76.0,'\assets\Furniture_Photos\Products_Photos\P0008'),
	('The Kent Bed','Marrying soft curves with tailored understatement, The Kent’s classic profile gives center stage to its meticulous detailing—from the headboard’s inset curvature to its rounded foot rail.',3250,'Pecan',70.0,42.0,90.0,50.0,'\assets\Furniture_Photos\Products_Photos\P0009'),
	('The Smith Bed','With marked curvature and oversized stature, The Smith references the bold sophistication of 1970s Italian design. Sumptuous lines and a sheltering headboard embrace, accentuated by a solid wood plinth base that gives its low profile a floating effect.',3675,'Whitewash',80.0,40.0,70.0,80.0,'\assets\Furniture_Photos\Products_Photos\P0010'),
	('The Thompson Canopy Bed','An organic, refined silhouette that allows natural materiality and subtle tailoring to shine. The Thompson makes an elegant statement in any bedroom.',3850,'Handwaxed Ash',80.0,84.0,95.0,75.0,'\assets\Furniture_Photos\Products_Photos\P0011'),
	('The Wythe Bed','Featuring a down-filled headboard, The Wythe’s ultra-cool low profile belies its cozy comfort. Flange seams provide the perfect finishing touches to this modern shape.',2675,'Oyster',70.0,40.0,90.0,84.0,'\assets\Furniture_Photos\Products_Photos\P0012'),
	('The Chelsea Ottoman','With fluid lines and sensual curves, The Chelsea Ottomans pay tribute to the softer side of mid-century design. The playful silhouettes sit atop recessed legs for an elegant floating effect.',985,'Charcoal',30.0,25.0,20.0,25.0,'\assets\Furniture_Photos\Products_Photos\P0013'),
	('The Franklin Bench','Tailored in rich texture with a versatile design, The Franklin is beautifully timeless and effortlessly comfortable. Slipcovered in linen for a casual yet elegant addition to any room.',1075,'Dew',60.0,17.0,17.0,35.0,'\assets\Furniture_Photos\Products_Photos\P0014'),
	('The Franklin Ottoman','Tailored in rich texture with a versatile design, The Franklin is beautifully timeless and effortlessly comfortable. Slipcovered in linen for a casual yet elegant addition to any room.',450,'Chambray',17.0,17.0,17.0,20.0,'\assets\Furniture_Photos\Products_Photos\P0015'),
	('The Mulberry Ottoman','A sculptural pedestal base and plush seat make The Mulberry a versatile design statement. Expertly crafted with a solid ash wood base and tailored detailing.',575,'Driftwood',16.5,16.5,18.0,15.0,'\assets\Furniture_Photos\Products_Photos\P0016'),
	('The Reyes Bench','Modern lines meet mixed materials in this sleek and minimal bench. The Reyes is expertly crafted with solid ash wood and delicate brass inset detailing. An optional seat cushion upholstered in soft nubuck leather adds textural interest.',1150,'Sail',60.0,18.0,16.25,40.0,'\assets\Furniture_Photos\Products_Photos\P0017'),
	('The Bond Chair','A stylish nod to mod, The Bond balances generous proportions with its contemporary profile. Luxe, down-filled comfort makes it an everyday luxury.',2115,'Camel',38.0,34.0,29.0,30.0,'\assets\Furniture_Photos\Products_Photos\P0018'),
	('The Chrystie Chair','Nodding to tradition, The Chrystie is a compelling take on the classic wingback. A high back and narrow sides slope seamlessly into low arms, while the canted seat back and angled back legs enhance its elegant lines.',1815,'Greywash',29.0,36.0,38.0,34.0,'\assets\Furniture_Photos\Products_Photos\P0019'),
	('The Dune Chair and a Half','The Dune Chair and a Half invites relaxation into your living space with its deep seat, soft cushioning, and easy-to-clean slipcover. It’s hand-finished with flange seams, lending a touch of polished elegance to the laid-back design.',1975,'Creme',48.0,38.0,34.0,42.0,'\assets\Furniture_Photos\Products_Photos\P0020'),
	('The Kenmare Chair','Designed with an organic ebb and flow, The Kenmare’s playful contours display artisanal craftsmanship in a petite silhouette. The handcarved solid ash frame lends a mixed material appeal to its contemporary design.',1650,'Driftwood',27.0,27.0,28.0,20.0,'\assets\Furniture_Photos\Products_Photos\P0021'),
	('The Laight Chair','A contemporary take on the slipper chair, The Laight is defined by embracing curves and petite proportions. The playful silhouette offers considerable comfort with its wraparound back, bubbled seat, and lathe-turned legs.',1985,'Pecan',31.0,26.0,29.0,30.0,'\assets\Furniture_Photos\Products_Photos\P0022'),
	('The Perry Chair','A nod to iconic midcentury design, The Perry Chair marries sophistication, craftsmanship, and comfort. The curved silhouette is timeless in feel, while the petite proportions make it perfect as a pair.',1850,'Coffee',32.0,32.0,32.0,40.0,'\assets\Furniture_Photos\Products_Photos\P0023'),
	('The Clinton 1-Drawer Nightstand','Handcrafted of solid ash with an optional leather-clad inlay, The Clinton celebrates luxe materiality in functional form. Artistry is on display—from the rounded corners and custom drawer pulls to the fully finished interiors and hand-shaped legs.',1975,'Pecan Ash',27.0,15.0,22.0,20.0,'\assets\Furniture_Photos\Products_Photos\P0024'),
	('The Clinton 2-Drawer Nightstand','Handcrafted of solid ash with an optional leather-clad inlay, The Clinton celebrates luxe materiality in functional form. Artistry is on display—from the rounded corners and custom drawer pulls to the fully finished interiors and hand-shaped legs.',2085,'Pecan Ash ',27.0,15.0,22.0,25.0,'\assets\Furniture_Photos\Products_Photos\P0025'),
	('The Clinton 3-Drawer Dresser','Handcrafted of solid ash with an optional leather-clad inlay, The Clinton celebrates luxe materiality in functional form. Artistry is on display—from the rounded corners and custom drawer pulls to the fully finished interiors and hand-shaped legs.',2900,'Whitewash Ash',30.0,18.0,35.0,30.0,'\assets\Furniture_Photos\Products_Photos\P0026'),
	('The Clinton 5-Drawer Dresser','Handcrafted of solid ash with an optional leather-clad inlay, The Clinton celebrates luxe materiality in functional form. Artistry is on display—from the rounded corners and custom drawer pulls to the fully finished interiors and hand-shaped legs.',3950,'Whitewash Ash',36.0,18.0,35.0,36.0,'\assets\Furniture_Photos\Products_Photos\P0027'),
	('The Rivington 2-Drawer Nightstand','Inspired by the organic forms and bold contours of Postmodern design, The Rivington adds understated elegance. Sinuous curves coalesce with straight lines, highlighted by the defined grain of cerused white oak.',2215,'White Cerused Oak',27.0,15.0,47.5,30.0,'\assets\Furniture_Photos\Products_Photos\P0028'),
	('The Rivington 5-Drawer Dresser','Inspired by the organic forms and bold contours of Postmodern design, The Rivington adds understated elegance. Sinuous curves coalesce with straight lines, highlighted by the defined grain of cerused white oak.',4125,'White Cerused Oak',36.0,21.0,47.5,40.0,'\assets\Furniture_Photos\Products_Photos\P0029'),
	('The Allen Dining Chair','The hand-carved frame and natural materiality give The Allen an organic, refined silhouette. Expertly crafted of solid ash wood and paired with tailored upholstery for casual comfort.',485,'Driftwood',19.0,22.0,33.0,19.5,'\assets\Furniture_Photos\Products_Photos\P0030'),
	('The Bedford Dining Table','Stunning in its simplicity, The Bedford’s subtle curves and timeless silhouette create a statement of elegance. Expertly crafted of solid ash wood and finished with exquisite artisanship.',2450,'Whitewash',80.0,40.0,30.0,96.0,'\assets\Furniture_Photos\Products_Photos\P0031'),
	('The Delancey Stool','Mixed materiality and a beautifully curved frame give The Delancey a handcrafted design inspired by midcentury forms. Expertly crafted from solid ash with a roomy, plush seat for elevated comfort.',865,'Charcoal',18.0,20.0,37.0,20.0,'\assets\Furniture_Photos\Products_Photos\P0032'),
	('The Jane Dining Chair','Playful contours and a bold, mixed material aesthetic give The Jane a stylish form that’s designed for lingering. Its elegantly curved back and refined curved legs add sculptural appeal.',755,'Pecan',21.0,22.0,29.5,19.5,'\assets\Furniture_Photos\Products_Photos\P0033'),
	('The Reade Dining Table','A delicate balance of commanding proportions, The Reade’s handcrafted column legs and intricately designed tabletop create an unforgettable sculptural statement. Expertly crafted of solid ash wood and finished with exquisite artisanship.',4275,'Whitewash',72.0,40.0,30.0,96.0,'\assets\Furniture_Photos\Products_Photos\P0034'),
	('The Reade Round Dining Table','A delicate balance of commanding proportions, The Reade’s handcrafted column legs and intricately designed tabletop create an unforgettable sculptural statement. Expertly crafted of solid ash wood and refined with exquisite artisanship.',2925,'Whitewash',42.0,40.0,30.0,48.0,'\assets\Furniture_Photos\Products_Photos\P0035'),
	('The Stanton Stool','The hand-carved frame and natural materiality give The Stanton an organic, airy shape that’s effortlessly versatile. Expertly crafted of solid ash wood and paired with tailored upholstery for casual comfort.',525,'Driftwood',21.0,19.0,30.0,29.0,'\assets\Furniture_Photos\Products_Photos\P0036'),
	('The Beekman Table','Handcrafted from richly grained oak, The Beekman has the presence of modern sculpture. Distinguished by its freeform shape, beveled edging, and tri-leg design, its organic silhouette is appealing from any angle.',2750,'Pecan Oak',68.0,32.0,29.0,43.0,'\assets\Furniture_Photos\Products_Photos\P0037'),
	('The Breuer Modular Sectional','Italian modernist design of the 1960s informs The Breuer. The modular components are low and expansive, creating a vast landscape of inviting luxury and multifunctional design.',6075,'Agate',100.0,60.0,50.0,100.0,'\assets\Furniture_Photos\Products_Photos\P0038'),
	('The Carmine Sectional','A fresh update on a beloved classic. The Carmine’s fan-pleated arms bring it understated elegance. The tailored seat and back offer a supportive sit.',4250,'Pecan',100.0,60.0,50.0,100.0,'\assets\Furniture_Photos\Products_Photos\P0039'),
	('The Ludlow Sectional','Midcentury style meets classic polish in The Ludlow. Its deep, reclined seat is perfectly suited for lounging (or accidental naps).',4425,'Pecan',100.0,60.0,50.0,100.0,'\assets\Furniture_Photos\Products_Photos\P0040'),
	('The Muir Sectional','Artisanal woodworking meets expertly tailored comfort in The Muir Sectional. Its asymmetrical silhouette with built-in side table form a mixed material work of art.',9895,'Handwaxed Ash',100.0,60.0,50.0,100.0,'\assets\Furniture_Photos\Products_Photos\P0041'),
	('The Sullivan Sectional','A modern take on classic European forms, The Sullivan mixes gentle curves with tailored lines. The elegant profile and sloped arms nod to tradition; a deep seat and down-filled cushion offer luxurious comfort.',4100,'Pecan',100.0,60.0,50.0,100.0,'\assets\Furniture_Photos\Products_Photos\P0042'),
	('The Varick Sectional','Bold proportions and comfort-driven curvature make The Varick a contemporary statement fit for everyday luxury. Its oversized arms and low-slung profile lend a relaxed, casual feel.',6500,'Dove',100.0,60.0,50.0,100.0,'\assets\Furniture_Photos\Products_Photos\P0043'),
	('The Bond Settee Sofa','Evocative of postmodern curvature, The Bond’s generous proportions and soft contours inform its contemporary sensibility. Down-filled cushioning define its luxurious comfort.',3225,'Sail',77.0,37.0,29.0,70.0,'\assets\Furniture_Photos\Products_Photos\P0044'),
	('The Chelsea Sofa','With fluid lines and sensual curves, The Chelsea Sofa pays tribute to the softer side of mid-century design. The U-shaped silhouette and wraparound arms subtly embrace, while a tightly upholstered seat and back lend polish.',3725,'Driftwood',75.0,36.5,30.0,75.0,'\assets\Furniture_Photos\Products_Photos\P0045'),
	('The Dune Sofa','The Dune transports you to a cozy beachside abode with its deep seat, sumptuous cushioning, and relaxed, easy-to-clean slipcover. It’s hand-finished with flange seams that lend an elegant finish to the laid-back feel of the design.',2725,'Oyster',60.0,38.0,34.0,65.0,'\assets\Furniture_Photos\Products_Photos\P0046'),
	('The Jones Modular Sofa','Our lowest, most laid-back silhouette, The Jones Modular is relaxed modernism at its finest. The silhouette commands presence and marries oversized proportions with down-filled comfort.',3950,'Bone',100.0,60.0,50.0,100.0,'\assets\Furniture_Photos\Products_Photos\P0047'),
	('The Leonard Sofa','The sculptural curves of The Leonard Sofa offer refined elegance and luxurious comfort. Slipcovered in linen for a relaxed, textural feel.',3325,'Clamshell',60.0,39.0,31.0,58.0,'\assets\Furniture_Photos\Products_Photos\P0048'),
	('The Varick Sofa','Bold proportions and comfort-driven curvature make The Varick a contemporary statement fit for everyday luxury. Its oversized arms and low-slung profile lend a relaxed, casual feel.',4625,'Dove',75.0,40.0,30.5,100.0,'\assets\Furniture_Photos\Products_Photos\P0049');
GO

INSERT INTO TAGS (Name)
VALUES
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
GO

INSERT INTO PRODUCT_TAG (ProductID,TagID)
VALUES
	(1,1),
	(1,3),
	(1,4),
	(2,1),
	(2,3),
	(2,4),
	(3,1),
	(3,3),
	(3,4),
	(4,1),
	(4,2),
	(4,3),
	(4,4),
	(5,1),
	(5,2),
	(5,3),
	(5,4),
	(6,1),
	(6,3),
	(6,4),
	(7,1),
	(7,5),
	(8,1),
	(8,5),
	(9,1),
	(9,5),
	(10,1),
	(10,5),
	(11,1),
	(11,5),
	(12,1),
	(12,5),
	(13,1),
	(13,3),
	(13,6),
	(14,1),
	(14,3),
	(14,6),
	(15,1),
	(15,3),
	(15,6),
	(16,1),
	(16,3),
	(16,6),
	(17,1),
	(17,3),
	(17,6),
	(18,1),
	(18,7),
	(19,1),
	(19,7),
	(20,1),
	(20,7),
	(21,1),
	(21,7),
	(22,1),
	(22,7),
	(23,1),
	(23,7),
	(24,1),
	(24,8),
	(25,1),
	(25,8),
	(26,1),
	(26,8),
	(27,1),
	(27,8),
	(28,1),
	(28,8),
	(29,1),
	(29,8),
	(30,1),
	(30,2),
	(30,7),
	(31,1),
	(31,2),
	(31,9),
	(32,1),
	(32,2),
	(32,10),
	(33,1),
	(33,2),
	(33,7),
	(34,1),
	(34,2),
	(34,9),
	(35,1),
	(35,2),
	(35,9),
	(36,1),
	(36,2),
	(36,10),
	(37,3),
	(37,9),
	(38,3),
	(38,11),
	(39,3),
	(39,11),
	(40,3),
	(40,11),
	(41,3),
	(41,11),
	(42,3),
	(42,11),
	(43,3),
	(43,11),
	(44,3),
	(44,12),
	(45,3),
	(45,12),
	(46,3),
	(46,12),
	(47,3),
	(47,12),
	(48,3),
	(48,12),
	(49,3),
	(49,12);
GO

INSERT INTO COLOURS (Name,Barcode)
VALUES
	('White','#FFFFFF'),
	('Ash','#B2BEB5'),
	('Pine','#C5B358');
GO

INSERT INTO PERMISSIONS (Name)
VALUES
	('Product Management'),
	('User Management'),
	('Role Management'),
	('Receipt Management');
GO

INSERT INTO ROLES (Name)
VALUES
	('Super Admin'),
	('User'),
	('Product Manager'),
	('Receipt Manager'),
	('User Manager');
GO

INSERT INTO USERS (UserName,PassWord,FirstName,LastName,Phone,Mail,RegDate,BirthYear)
VALUES
	('admin','hehehe','Hưng','Nguyễn Hoàng',900445424,'Hung@gmail.com','2023-11-20 00:00:00',2003),
	('tan','tan','Tân','Đặng Huỳnh Vĩnh ',948582733,'21520442@gm.uit.edu','2023-11-01 00:00:00',2003);
GO

INSERT INTO ROLE_PERMISSION (RoleID,PermissionID)
VALUES
	(1,1),
	(1,2),
	(1,3),
	(1,4),
	(3,1),
	(4,4),
	(5,2);
GO

INSERT INTO USER_ROLE (UserID,RoleID)
VALUES
	(1,1),
	(2,2);
GO