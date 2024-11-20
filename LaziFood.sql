DROP DATABASE LaziFood;
CREATE DATABASE LaziFood;
 
 USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'LaziFood')
BEGIN
	ALTER DATABASE LaziFood SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE LaziFood SET ONLINE;
	DROP DATABASE LaziFood;
END

GO

CREATE TABLE Ingredient_Categories(
	id		INT PRIMARY KEY IDENTITY,
	[name]  NVARCHAR (255),
);
CREATE TABLE Ingredients (
    id				INT 				PRIMARY KEY IDENTITY,
    [name]			NVARCHAR(255)		NOT NULL,
    unit			NVARCHAR(50),
    price			MONEY,
    category_id		INT,
    [status]		BIT DEFAULT 1,
	[image]			NVARCHAR(255),
	FOREIGN KEY (category_id) REFERENCES Ingredient_Categories(id)
);
 
CREATE TABLE Dish_Categories(
	id		INT PRIMARY KEY IDENTITY,
	[name]  NVARCHAR (255),
);

CREATE TABLE Dishes (
    id				INT  PRIMARY KEY IDENTITY,
    [name]			NVARCHAR(255),
    price			MONEY,
	category_id		INT,
    [status]		BIT DEFAULT 1,
	[image]			NVARCHAR(255),
	FOREIGN KEY (category_id) REFERENCES Dish_Categories(id)
);
CREATE TABLE Recipe_Ingredients (
	recipe_ingredients_id       INT PRIMARY KEY IDENTITY, 
    dish_id						INT NOT NULL,
    ingredient_id				INT NOT NULL,
    ingredient_quantity			NVARCHAR(100),
   	CONSTRAINT UC_recipe_ingredient UNIQUE (dish_id, ingredient_id),
    FOREIGN KEY (dish_id)		REFERENCES Dishes(id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(id)
);
CREATE TABLE Accounts (
    id				INT PRIMARY KEY IDENTITY,
    username		NVARCHAR(255) NOT NULL UNIQUE,
    [password]		NVARCHAR(MAX) NOT NULL,
    full_name		NVARCHAR(255) NOT NULL,
    phone			NVARCHAR(20),
	email			NVARCHAR(100),
    [address]		NVARCHAR(255),
    city			NVARCHAR(255),
    district		NVARCHAR(255),
    [role]			BIT NOT NULL DEFAULT 0,
    [status]		BIT NOT NULL DEFAULT 1,
);

CREATE TABLE Orders (
    id					INT PRIMARY KEY IDENTITY,
    account_id			INT,
	full_name			NVARCHAR(255) NOT NULL,
    phone				NVARCHAR(20),
    order_date			DATE DEFAULT CONVERT(DATE, GETDATE()),
    ship_date			DATE,
    ship_address		NVARCHAR(255),
    ship_city			NVARCHAR(255),
    ship_district		NVARCHAR(255),
    total_price			MONEY,
    [status]			INT CHECK([status] IN(0,1,2,3)) DEFAULT 1,
	FOREIGN KEY (account_id) REFERENCES Accounts(id) 
);

CREATE TABLE Order_Dishes (
	order_id_details		INT IDENTITY PRIMARY KEY,
    order_id				INT NOT NULL,
    dish_id					INT NOT NULL,
    quantity				INT,
	price_per_unit			MONEY,
	CONSTRAINT UC_order_Dish UNIQUE (order_id, dish_id),
    FOREIGN KEY (order_id)	REFERENCES Orders(id),
    FOREIGN KEY (dish_id)	REFERENCES Dishes(id)
);

CREATE TABLE Order_Ingredients (
	order_id_details		INT IDENTITY PRIMARY KEY,
    order_id				INT NOT NULL,
    ingredient_id			INT NOT NULL,
    quantity				INT,
	price_per_unit			MONEY,
	CONSTRAINT UC_order_Ingredient UNIQUE (order_id, ingredient_id),
    FOREIGN KEY (order_id)	REFERENCES Orders(id),
    FOREIGN KEY (ingredient_id)	REFERENCES Ingredients(id)
);
 
CREATE TABLE Menu_Categories(
	id		INT PRIMARY KEY IDENTITY,
	[name]  NVARCHAR (255),
);

CREATE TABLE Menu (
    id								INT PRIMARY KEY IDENTITY,
    [name]							NVARCHAR(255),
	category_id						INT,
    create_account					INT,
	[image]							NVARCHAR(255),
	[status]						BIT NOT NULL DEFAULT 1,
	[description]                    NVARCHAR(MAX),
    FOREIGN KEY (create_account)	REFERENCES Accounts(id),
	FOREIGN KEY (category_id)		REFERENCES Menu_Categories(id)

);


CREATE TABLE Menu_Details (
    id								INT PRIMARY KEY IDENTITY,
    [period]						INT CHECK ([period] IN (1,2,3)),
    day_of_week						INT CHECK (day_of_week IN (2,3,4,5,6,7)),
    dish_id							INT,
	menu_id							INT,
	[status]						BIT DEFAULT 1	
    FOREIGN KEY (dish_id)			REFERENCES Dishes(id),
	FOREIGN KEY (menu_id)			REFERENCES Menu(id),
	CONSTRAINT UC_Menu_Dish UNIQUE  (day_of_week, [period], menu_id, dish_id)
);

CREATE TABLE Customer_Plan (
    id							INT PRIMARY KEY IDENTITY,
	name						NVARCHAR(255),
    account_id					INT,
	[status]					BIT DEFAULT 1	
    FOREIGN KEY (account_id)	REFERENCES Accounts(id)
);

CREATE TABLE Customer_Plan_Details (
    id							INT PRIMARY KEY IDENTITY,
	customer_plan_id			INT,
    [period]					TINYINT CHECK ([period] IN (1,2,3)),
    day_of_week					TINYINT CHECK (day_of_week IN (2,3,4,5,6,7)),
    dish_id						INT,
    FOREIGN KEY (dish_id)		REFERENCES Dishes(id),
	FOREIGN KEY (customer_plan_id)		REFERENCES Customer_Plan(id),
	CONSTRAINT UC_Plan_Dish UNIQUE (day_of_week, [period], customer_plan_id, dish_id)
);



INSERT INTO Ingredient_Categories ([name])
VALUES
    (N'Thịt, Cá, Trứng, Hải Sản'),
    (N'Rau, Củ, Nấm, Trái Cây'),
    (N'Dầu Ăn, Nước Chấm, Gia Vị'),
    (N'Mì, Miến, Cháo, Phở'),
    (N'Gạo, Bột, Đồ Khô');

INSERT INTO Dish_Categories ([name])
VALUES    
    (N'Món Ăn Miền Bắc'),
    (N'Món Ăn Miền Trung'),
    (N'Món Ăn Miền Nam'),
    (N'Món Ăn Miền Tây'),
    (N'Món Ăn Tây'),
    (N'Món Ăn Nhanh');

INSERT INTO Menu_Categories ([name])
VALUES    
    (N'Thực Đơn Ăn Mặn'),
    (N'Thực Đơn Ăn Chay'),
    (N'Thực Đơn Ăn Kiêng');


	-----------------------------------------------------------------------------------
INSERT INTO Ingredients([name], unit, price, category_id, [image]) values
(N'Ba rọi', 'kg', 133000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8781/275804/bhx/ba-roi-heo-nhap-khau-202405101458173960_300x300.jpg'),
(N'Thịt nạc heo', 'kg', 158000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8781/226842/bhx/nac-dam-heo-202406100956579931_300x300.jpg'),
(N'Sườn cốt lết', 'kg', 144000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8781/226937/bhx/suon-cot-let-202405241059308041_300x300.jpg'),
(N'Sườn non', 'kg', 219000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8781/226856/bhx/suon-non-heo-202405241343108774_300x300.jpg'),
(N'Thịt heo xay', 'kg', 138000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8781/233782/bhx/thit-heo-xay-202405241059567152_300x300.jpg'),
(N'Ba chỉ bò mỹ', 'kg', 312000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8400/302996/bhx/thit-ba-chi-bo-my-cat-cuon-orifood-khay-300g-202403141406335195_300x300.jpg'),
(N'Nạm bò', 'kg', 199000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8139/238859/bhx/-202405211536391674.jpg'),
(N'Ức gà', 'kg', 94000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8790/222942/bhx/uc-ga-phi-le-co-da-202406201611301298.jpg'),
(N'Cánh gà', 'kg', 99000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8790/226874/bhx/canh-ga-202405241040185154.jpg'),
(N'Cánh tỏi gà', 'kg', 117000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8790/233798/bhx/canh-toi-ga-202405241101314855_300x300.jpg'),
(N'Đùi gà góc tư', 'kg', 95000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8790/226946/bhx/dui-ga-goc-tu-202405241102479361_300x300.jpg'),
(N'Cá ba sa phile', 'kg', 109000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8782/233812/bhx/ca-basa-phi-le-202405091054011663_300x300.jpg'),
(N'Cá diêu hồng', 'kg', 98000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8782/309731/bhx/ca-dieu-hong-lam-sach-202405072352528323_300x300.jpg'),
(N'Tôm sú', 'kg', 164000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8782/285416/bhx/tom-su-500g-10-13-con-202405281920064724_300x300.jpg'),
(N'Bạch tuộc', 'kg', 79000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8782/326106/bhx/bach-tuoc-500g-6-8-con-202405271617320007_300x300.jpg'),
(N'Mực ống', 'kg', 118000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8782/273937/bhx/muc-ong-nguyen-con-500g-10-13-con-202405281617380623_300x300.jpg'),
(N'Trứng gà', 'hộp', 26000,1,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8783/228775/bhx/trung-ga-hop-10-qua-giao-ngau-nhien-thuong-hieu-202405291506444561_300x300.jpg'),
(N'Rau muống', 'bó', 6000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8820/324797/bhx/rau-muong-nuoc-400g-202406200949370626.jpg'),
(N'Rau lang', 'bó', 7000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8820/324796/bhx/rau-lang-400g-202406200948122763.jpg'),
(N'Rau má', 'bó', 9000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8820/271747/bhx/rau-ma-200g-202406200943040446.jpg'),
(N'Giá đỗ', 'kg', 14000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8820/233919/bhx/gia-song-202405151016581157_300x300.jpg'),
(N'Cải thìa', 'bó', 20000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8820/230443/bhx/cai-thia-202406200941515628.jpg'),
(N'Xà lách', 'kg', 45000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8820/233504/bhx/xa-lach-lo-lo-xanh-202403291415548159_300x300.jpg'),
(N'Dưa leo', 'kg', 20000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/230451/bhx/-202406200952440016.jpg'),
(N'Bí xanh', 'kg', 22000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/233895/bhx/-202406200950131283.jpg'),
(N'Bầu xanh', 'kg', 22000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/233898/bhx/-202406200951187375.jpg'),
(N'Su su', 'kg', 10000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/230462/bhx/su-su-trai-tu-200g-tro-len-202406061425224065_300x300.jpg'),
(N'Bắp cải thảo', 'kg', 10000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/233982/bhx/bap-cai-thao-bap-tu-500g-tro-len-202405071532317343_300x300.jpg'),
(N'Hành tây', 'kg', 35000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/273076/bhx/hanh-tay-cu-tu-100g-tro-len-202405071513009065_300x300.jpg'),
(N'Khoai lang', 'kg', 21000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/220470/bhx/khoai-lang-nhat-cu-tu-70g-tro-len-202406061425321067_300x300.jpg'),
(N'Bí đỏ', 'kg', 24000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/233887/bhx/bi-do-ho-lo-trai-tu-700g-tro-len-202406061424579304_300x300.jpg'),
(N'Cà chua', 'kg', 36000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/230449/bhx/ca-chua-trai-tu-60g-tro-len-202406061423099200_300x300.jpg'),
(N'Cà rốt', 'kg', 22000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/234529/bhx/ca-rot-trai-tu-150g-tro-len-202405071545442140_300x300.jpg'),
(N'Cà tím', 'kg', 28000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/230439/bhx/ca-tim-trai-tu-150g-tro-len-202405071600031127_300x300.jpg'),
(N'Ớt chuông', 'kg', 60000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/234103/bhx/ot-chuong-xanh-vang-do-202406061425538439_300x300.jpg'),
(N'Gừng', 'kg', 90000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/230452/bhx/gung-202403291520392469_300x300.jpg'),
(N'Hành lá', 'gói', 7200,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8785/230452/bhx/gung-202403291520392469_300x300.jpg'),
(N'Nấm hương', 'kg', 33000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8779/281521/bhx/nam-huong-150g-202403291503110048_300x300.jpg'),
(N'Nấm đùi gà', 'kg', 33000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8779/313128/bhx/nam-dui-ga-baby-hq-200g-202404021626336612_300x300.jpg'),
(N'Kim chi', 'hộp', 33000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/7459/200117/bhx/kim-chi-cai-thao-len-men-tu-nhien-viet-han-hop-500g-202307261351598632_300x300.jpg'),
(N'Mắm cà pháo', 'hộp', 37000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8285/293984/bhx/mam-ca-phao-chua-cay-song-huong-hu-390g-202306201049533505_300x300.png'),
(N'Rau quả hỗn hợp', 'hộp', 42000,2,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/7172/206546/bhx/rau-qua-hon-hop-dong-lanh-sg-food-goi-500g-202209070957102676_300x300.png'),
(N'Dầu đậu nành', 'chai', 92000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2286/82837/bhx/dau-dau-nanh-happi-soya-can-2-lit-202306261538136088_300x300.jpg'),
(N'Dầu mè', 'chai', 60000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2286/228302/bhx/-202305200907103611.jpg'),
(N'Dầu olive', 'chai', 96000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2286/79397/bhx/dau-olive-extra-virgin-olivoila-chai-250ml-202305131454456602_300x300.jpg'),
(N'Dầu gạo lứt', 'chai', 96000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2286/138691/bhx/dau-gao-lut-nguyen-chat-simply-chai-1-lit-202306261555416743_300x300.jpg'),
(N'Nước mắm Nam Ngư', 'chai', 35000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2289/76426/bhx/nuoc-mam-nam-ngu-10-do-dam-chai-500ml-202306211031502974_300x300.jpg'),
(N'Nước mắm Nam Ngư tỏi ớt Lý Sơn', 'chai', 35000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/7779/317596/bhx/nuoc-cham-chua-ngot-nam-ngu-ot-toi-ly-son-chai-300ml-202311010939538996_300x300.jpg'),
(N'Nước tương', 'chai', 19000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2683/79060/bhx/nuoc-tuong-dau-nanh-thanh-diu-maggi-chai-700ml-202304131529221817_300x300.jpg'),
(N'Đường kính trắng', 'gói', 15000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2804/82186/bhx/duong-kinh-trang-toan-phat-goi-500g-202205161412197252_300x300.png'),
(N'Đường phèn', 'gói', 27000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2804/77187/bhx/duong-phen-hoang-long-goi-500g-202205161410067922_300x300.png'),
(N'Hạt nêm Knor', 'gói', 39000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2806/318884/bhx/hat-nem-knorr-thit-than-xuong-ong-tuy-goi-12kg-202311141425414189_300x300.jpg'),
(N'Bột ngọt', 'gói', 10000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2806/85214/bhx/bot-ngot-hat-lon-ajinomoto-goi-100g-202311281113407056_300x300.jpg'),
(N'Muối', 'gói', 5000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2806/85214/bhx/bot-ngot-hat-lon-ajinomoto-goi-100g-202311281113407056_300x300.jpg'),
(N'Mayonaise', 'chai', 24000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2567/76366/bhx/sot-mayonnaise-kewpie-chai-130g-202205191116348260_300x300.jpg'),
(N'Tương ớt Chinsu', 'chai', 14000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2567/76916/bhx/tuong-ot-chinsu-chai-250g-202306241916582384_300x300.jpg'),
(N'Dầu hào', 'gói', 28000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3465/91407/bhx/dau-hao-dam-dac-maggi-chai-350g-202305221133070543_300x300.jpg'),
(N'Bơ thực vật', 'hộp', 15000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3465/211278/bhx/bo-thuc-vat-meizan-hu-200g-202406031001343585_300x300.jpg'),
(N'Xốt ướp thịt nướng', 'gói', 15000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8271/96242/bhx/xot-uop-thit-nuong-cholimex-goi-70g-202306200903067107_300x300.jpg'),
(N'Xốt ướp xá xíu', 'gói', 15000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3465/211278/bhx/bo-thuc-vat-meizan-hu-200g-202406031001343585_300x300.jpg'),
(N'Xốt cà ri', 'gói', 15000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8271/165695/bhx/xot-gia-vi-hoan-chinh-ca-ri-barona-goi-80g-202306200929118764_300x300.jpg'),
(N'Xốt spaghetti', 'lọ', 77000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8271/219606/bhx/xot-mi-spaghetti-thit-bo-bolognese-golden-farm-hu-370g-202307142012322277_300x300.jpg'),
(N'Gói lẩu thái', 'gói', 10000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8271/198429/bhx/nuoc-dung-hoan-chinh-lau-thai-barona-goi-180g-202306200918041859_300x300.jpg'),
(N'Xốt bò kho', 'gói', 10000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8271/165696/bhx/xot-gia-vi-hoan-chinh-bo-kho-barona-goi-80g-202306200905087507_300x300.jpg'),
(N'Xốt gà chiên mắm', 'gói', 10000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8271/202873/bhx/gia-vi-hoan-chinh-dang-xot-ga-chien-nuoc-mam-chinsu-goi-70g-202306200909236454_300x300.jpg'),
(N'Xốt thịt kho', 'gói', 10000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8271/202875/bhx/gia-vi-hoan-chinh-dang-xot-thit-kho-chinsu-goi-70g-202306200909317420_300x300.jpg'),
(N'Wasabi', 'chai', 26000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/7779/82790/bhx/mu-tat-xanh-s-b-tuyp-43g-202205171725385498_300x300.jpg'),
(N'Mắm nêm pha sẵn', 'chai', 26000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/7779/311005/bhx/mam-nem-pha-san-ngoc-lien-chai-250ml-202307280845386122_300x300.jpg'),
(N'Sa tế', 'chai', 11000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2809/91365/bhx/sa-te-tom-thuan-phat-hu-85g-202205181556342170_300x300.jpg'),
(N'Ớt bột', 'chai', 9000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2809/188794/bhx/ot-bot-dh-foods-hu-30g-202211150918316590_300x300.jpg'),
(N'Tiêu', 'chai', 19000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2809/155820/bhx/tieu-den-xay-dh-foods-hu-45g-202205181606129897_300x300.jpg'),
(N'Ớt xay', 'chai', 19000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2809/174533/bhx/ot-xay-song-huong-hu-200g-202306201047110455_300x300.png'),
(N'Ngũ vị hương', 'gói', 5000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8275/198820/bhx/bot-ngu-vi-huong-thien-thanh-goi-5g-202205141234000608_300x300.png'),
(N'Bột tỏi', 'hủ', 5000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8275/174540/bhx/bot-toi-natas-hu-65g-202205141157272756_300x300.png'),
(N'Bột nghệ', 'hủ', 15000,3,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8275/219653/bhx/nghe-bot-vipep-hu-35g-202205141404286923_300x300.png'),
(N'Bún gạo lứt', 'Gói', 35000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8163/220402/bhx/bun-gao-lut-jimmy-tui-250g-202306220828491116_300x300.jpg'),
(N'Bún tươi', 'Gói', 10000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8163/249870/bhx/bun-tuoi-goi-500g-202406101320527363_300x300.jpg'),
(N'Nui chữ C', 'Gói', 10000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8159/80097/bhx/nui-chu-c-safoco-goi-60g-202207250921164668_300x300.jpg'),
(N'Nui rau củ bốn mùa', 'Gói', 10000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8159/175990/bhx/nui-rau-cu-bon-mua-erci-goi-200g-202205191640342458_300x300.jpg'),
(N'Nui trứng cao cấp', 'Gói', 40000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8159/175993/bhx/nui-trung-cao-cap-erici-goi-400g-202205191642206126_300x300.jpg'),
(N'Nui xoắn', 'Gói', 40000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8159/233053/bhx/nui-xoan-ba-bay-goi-200g-202205201148484776_300x300.jpg'),
(N'Hủ tiếu sa đéc', 'Gói', 25000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8160/248412/bhx/hu-tieu-sa-dec-sa-giang-goi-400g-202205232152591369_300x300.jpg'),
(N'Phở gạo lứt', 'Gói', 23000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8160/307125/bhx/pho-gao-lut-minh-hao-goi-250g-202305291120372032_300x300.jpg'),
(N'Miến dong', 'Gói', 23000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8160/262390/bhx/mien-dong-susan-goi-200g-202207260853467083_300x300.jpg'),
(N'Bánh đa khô', 'Gói', 28000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8160/226077/bhx/banh-da-kho-vifon-goi-300g-202205232152355279_300x300.jpg'),
(N'Mì Spaghetti', 'Gói', 34000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8158/175969/bhx/mi-spaghetti-so-4-balducci-goi-500g-202205231129508986_300x300.jpg'),
(N'Mì Trứng', 'Gói', 34000,4,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/8158/80130/bhx/mi-trung-soi-nho-safoco-goi-500g-202205231121189907_300x300.jpg'),
(N'Vua gạo ST25 5Kg', 'Bao', 280000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2513/236014/bhx/gao-thom-vua-gao-st25-tui-5kg-202312071149419082_300x300.jpg'),
(N'Gạo Tấm 2kg', 'Bao', 90000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2513/262356/bhx/gao-tam-thom-vinh-hien-tui-2kg-202310171533337245_300x300.jpg'),
(N'Gạo lứt 2kg', 'Bao', 51000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2513/216076/bhx/gao-lut-vinh-hien-tui-2kg-202103040826016095_300x300.jpg'),
(N'Nếp cái hoa vàng', 'Bao', 51000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/2513/227004/bhx/nep-cai-hoa-vang-vinh-hien-tui-1kg-202103040830355507_300x300.jpg'),
(N'Xúc xích ăn liền', 'Gói', 21000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3507/89859/bhx/xuc-xich-heo-dinh-duong-vissan-goi-175g-202306191010225859_300x300.png'),
(N'Xúc xích xông khói', 'Gói', 41000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/7618/286777/bhx/xuc-xich-cocktail-xong-khoi-cp-goi-500g-202306111542346531_300x300.png'),
(N'Xúc xích hồ lô', 'Gói', 30000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/7618/239090/bhx/xuc-xich-ho-lo-nuong-la-cusina-goi-200g-202401021036508366_300x300.jpg'),
(N'Xúc xích đức', 'Gói', 80000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/7618/239083/bhx/xuc-xich-duc-la-cusina-goi-500g-202306191436068125_300x300.jpg'),
(N'Cá hộp', 'hộp', 24000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3237/149420/bhx/ca-nuc-sot-ca-nap-giat-lilly-hop-155g-202306191418383183_300x300.png'),
(N'Cá ngừ xốt tuna', 'hộp', 50000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3237/230043/bhx/ca-ngu-xot-ca-chua-tuna-viet-nam-hop-140g-202306191423219466_300x300.png'),
(N'Thịt áp chảo', 'hộp', 52000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3238/300486/bhx/thit-ap-chao-ponnie-hop-200g-202306291438320174_300x300.png'),
(N'Pate thịt heo', 'hộp', 36000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3238/80549/bhx/pate-thit-heo-vissan-170g-202306291442222269_300x300.png'),
(N'Heo hai lát', 'hộp', 19000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3238/196931/bhx/heo-hai-lat-3-bong-mai-vissan-150g-202306191421017484_300x300.png'),
(N'Lạp xưởng', 'gói', 90000,5,'https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_85,s_346x346/https://cdn.tgdd.vn/Products/Images/3506/89864/bhx/lap-xuong-heo-vissan-goi-500g-202306081454147057_300x300.png')




INSERT INTO Dishes ([name], price, category_id, [image]) Values 
(N'Cá ba sa kho tộ',50000, 4, 'https://image.cooky.vn/recipe/g1/790/s160x160/recipe790-635533002541826719.jpg'),
(N'Sườn xào chua ngọt',60000, 3, 'https://media.cooky.vn/recipe/g1/643/s320x320/cooky-recipe-cover-r643.jpg'),
(N'Thịt nạc kho tiêuu',40000, 3, 'https://media.cooky.vn/recipe/g2/16714/s320x320/recipe16714-635941534640352684.jpg'),
(N'Ba chỉ kho tiêu',45000, 3, 'https://media.cooky.vn/recipe/g4/35480/s320x320/cooky-recipe-cover-r35480.JPG'),
(N'Tôm rim thịt ba chỉ',65000, 3, 'https://media.cooky.vn/recipe/g1/5566/s320x320/recipe5566-636022961661073620.jpg'),
(N'Đùi gà nướng sốt nước mắm',40000, 3, 'https://image.cooky.vn/recipe/g1/6862/s160x160/recipe6862-636414997282317174.jpg'),
(N'Cánh gà chiên nước mắm',40000, 3, 'https://image.cooky.vn/recipe/g1/4105/s160x160/recipe4105-636414993463586467.jpg'),
(N'Ức gà xào rau',40000, 1, 'https://image.cooky.vn/recipe/g1/7180/s160x160/recipe7180-635935671381418301.jpg'),
(N'Salad ức gà',40000, 1, 'https://image.cooky.vn/recipe/g5/45171/s160x160/cooky-recipe-cover-r45171.jpg'),
(N'Sườn cốt lết ram',40000, 1, 'https://image.cooky.vn/recipe/g5/49299/s160x160/cooky-recipe-637000327449470354.jpg'),
(N'Cốt lết heo chiên xù',40000, 5, 'https://image.cooky.vn/recipe/g4/30490/s160x160/cooky-recipe-cover-r30490.jpg'),
(N'Trứng cuộn thịt ba chỉ',40000, 3, 'https://image.cooky.vn/recipe/g2/19706/s160x160/cooky-recipe-636283675213823643.jpg'),
(N'Thịt kho trứng',40000, 4, 'https://image.cooky.vn/recipe/g3/25230/s160x160/recipe-cover-r25230.jpg'),
(N'Chả tôm chiên giòn',40000, 2, 'https://image.cooky.vn/recipe/g1/664/s160x160/recipe664-635532112863398985.jpg'),
(N'Tôm rang',40000, 2, 'https://image.cooky.vn/recipe/g3/24938/s160x160/recipe-cover-r24938.jpg'),
(N'Mực xào sốt cay',40000, 2, 'https://image.cooky.vn/recipe/g1/9582/s160x160/recipe9582-636413327331832061.jpg'),
(N'Mực nướng sa tế',40000, 2, 'https://image.cooky.vn/recipe/g2/13834/s160x160/recipe13834-635917294591844648.jpg'),
(N'Mực hấp gừng',40000, 2, 'https://image.cooky.vn/recipe/g1/557/s160x160/recipe557-635911429027094328.jpg'),
(N'Bạch tuộc xào cay',40000, 2, 'https://image.cooky.vn/recipe/g5/46267/s160x160/cooky-recipe-cover-r46267.jpg'),
(N'Gỏi bạch tuộc',40000, 2, 'https://image.cooky.vn/recipe/g2/14032/s160x160/recipe14032-635688312355248490.jpg'),
(N'Lạp xưởng xào khoai tây',40000, 6, 'https://image.cooky.vn/recipe/g3/23960/s160x160/recipe-cover-r23960.jpg'),
(N'Nui xào thịt heo',40000, 1, 'https://image.cooky.vn/recipe/g1/2510/s160x160/recipe2510-635739527728109630.jpg'),
(N'Nui xào bò rau củ',40000, 1, 'https://image.cooky.vn/recipe/g5/45470/s160x160/cooky-recipe-636835856134757846.jpg'),
(N'Nui xốt kem',40000, 5, 'https://image.cooky.vn/recipe/g1/2226/s160x160/recipe2226-635665082564832533.jpg'),
(N'Nui xốt cà chua',40000, 5, 'https://image.cooky.vn/recipe/g1/7269/s160x160/recipe7269-635629600557366190.jpg'),
(N'Miến xào chả cá',40000, 5, 'https://image.cooky.vn/recipe/g1/4384/s160x160/recipe4384-636410899148957824.jpg'),
(N'Miến xào trứng',40000, 1, 'https://image.cooky.vn/recipe/g1/4913/s160x160/recipe4913-636434260409840972.jpg'),
(N'Lẩu kim chi bò Mỹ',200000, 5, 'https://image.cooky.vn/recipe/g6/51817/s160x160/cooky-recipe-cover-r51817.jpg'),
(N'Bò bít tết',100000, 5, 'https://image.cooky.vn/recipe/g2/16166/s160x160/recipe16166-635829255850239383.jpg'),
(N'Mì ý sốt bò bằm',60000, 6, 'https://image.cooky.vn/recipe/g2/19315/s160x160/recipe19315-636258850663703502.jpg'),
(N'Bò kho',70000, 1, 'https://image.cooky.vn/recipe/g1/8122/s160x160/recipe8122-635722094482196975.jpg'),
(N'Mì xào bò rau cải',70000, 3, 'https://image.cooky.vn/recipe/g1/1998/s160x160/recipe1998-635708208338161691.jpg'),
(N'Hủ tiếu trộn bò viên',40000, 2, 'https://image.cooky.vn/recipe/g4/35820/s160x160/cooky-recipe-636684817345081654.jpg'),
(N'Bún thịt nướng',30000, 2, 'https://image.cooky.vn/recipe/g1/2261/s160x160/recipe2261-636038470394303330.jpg'),
(N'Kho quẹt rau củ luộc',50000, 4, 'https://image.cooky.vn/recipe/g6/51267/s160x160/cooky-recipe-637118364813226009.jpg'),
(N'Cơm chiên tôm',50000, 5, 'https://image.cooky.vn/recipe/g5/45915/s160x160/cooky-recipe-cover-r45915.jpg'),
(N'Đậu hũ nhồi tôm thịt',50000, 4, 'https://image.cooky.vn/recipe/g1/6127/s160x160/recipe6127-636421348320375249.jpg'),
(N'Đậu hũ nướng cay',50000, 1, 'https://image.cooky.vn/recipe/g5/44502/s160x160/cooky-recipe-cover-r44502.jpg'),
(N'Đậu hũ chiên',50000, 1, 'https://image.cooky.vn/recipe/g2/18358/s160x160/recipe18358-636122983283607636.jpg'),
(N'Đậu hũ xốt tứ xuyên',50000, 5, 'https://image.cooky.vn/recipe/g3/26826/s160x160/recipe-cover-r26826.jpg'),
(N'Đậu hũ xốt cà chua',50000, 1, 'https://image.cooky.vn/recipe/g5/43583/s160x160/cooky-recipe-cover-r43583.jpg'),
(N'Bánh đa trộn',50000, 1, 'https://image.cooky.vn/recipe/g5/47087/s160x160/cooky-recipe-cover-r47087.jpg'),
(N'Bánh đa cua Hải Phòng',50000, 1, 'https://image.cooky.vn/recipe/g4/38864/s160x160/cooky-recipe-636721370430586714.jpg'),
(N'Cơm trộn hàn quốc',50000, 5, 'https://image.cooky.vn/recipe/g1/622/s160x160/recipe622-635512366486753750.jpg'),
(N'Cơm chiên dương châu',50000, 3, 'https://image.cooky.vn/recipe/g4/34218/s160x160/cooky-recipe-cover-r34218.jpg'),
(N'Cơm chiên lạp xướng trứng muối',50000, 1, 'https://image.cooky.vn/recipe/g1/4772/s160x160/recipe4772-635941543090419526.jpg'),
(N'Canh cải',50000, 1, 'https://image.cooky.vn/recipe/g1/8086/s160x160/recipe8086-636016096816778917.jpg'),
(N'Canh đậu hũ',50000, 1, 'https://image.cooky.vn/recipe/g2/12625/s160x160/recipe-cover-r12625.jpg'),
(N'Canh trứng',50000, 1, 'https://image.cooky.vn/recipe/g1/4940/s160x160/recipe4940-636044505493602446.jpg'),
(N'Canh gà nấm',50000, 1, 'https://image.cooky.vn/recipe/g3/28780/s160x160/recipe-cover-r28780.jpg'),
(N'Canh tôm rau củ',50000, 1, 'https://image.cooky.vn/recipe/g2/16453/s160x160/cooky-recipe-635858973116877999.jpg'),
(N'Canh tôm đậu hũ',50000, 1, 'https://image.cooky.vn/recipe/g3/23692/s160x160/recipe-cover-r23692.jpg'),
(N'Rau muống xào tỏi',30000, 4, 'https://image.cooky.vn/recipe/g2/18337/s160x160/recipe18337-636118614212760519.jpg'),
(N'Rau lang xào tỏi',30000, 4, 'https://image.cooky.vn/recipe/g3/20487/s160x160/recipe20487-636353066224795999.jpg'),
(N'Rau củ xào thập cẩm',30000, 1, 'https://image.cooky.vn/recipe/g4/37033/s160x160/cooky-recipe-cover-r37033.jpg'),
(N'Xúc xích xào chua ngọt',30000, 1, 'https://image.cooky.vn/recipe/g5/44762/s160x160/cooky-recipe-636818086232722298.jpg'),
(N'Bông cải xào xúc xích',30000, 1, 'https://image.cooky.vn/recipe/g4/31786/s160x160/cooky-recipe-cover-r31786.jpg'),
(N'Sườn nướng BBQ',70000, 6, 'https://image.cooky.vn/recipe/g1/266/s160x160/recipe266-635377346122371953.jpg'),
(N'Bún chả',70000, 1, 'https://image.cooky.vn/recipe/g1/6361/s160x160/recipe-cover-r6361.jpg'),
(N'Xíu mại chay',70000, 1, 'https://image.cooky.vn/recipe/g1/7011/s160x160/recipe7011-635991831325951836.jpg'),
(N'Nấm kho tiêu chay',70000, 1, 'https://image.cooky.vn/recipe/g3/24273/s160x160/recipe-cover-r24273.jpg'),
(N'Bún thái chay',70000, 1, 'https://image.cooky.vn/recipe/g6/51602/s160x160/cooky-recipe-637129648088411453.png'),
(N'Hủ tiếu mì chay',70000, 1, 'https://image.cooky.vn/recipe/g3/27004/s160x160/recipe-cover-r27004.jpg'),
(N'Bún gạo xào chay',70000, 1, 'https://image.cooky.vn/recipe/g3/27004/s160x160/recipe-cover-r27004.jpg'),
(N'Mì xào giòn chay',70000, 1, 'https://image.cooky.vn/recipe/g1/6225/s160x160/recipe6225-635676510450909051.jpg')

INSERT INTO Recipe_Ingredients(dish_id, ingredient_id, ingredient_quantity) values 
(2,4,N'1 kg'),
(2,37,N'100 g'),
(2,47,N'200 ml'),
(2,50,N'1 kg'),
(2,57,N'1 kg'),

(3,71,N'20 g'),
(3,72,N'50 g'),
(3,2,N'1 kg'),
(3,50,N'1 kg'),
(3,57,N'1 kg'),
(3,49,N'1 kg'),

(4,1,N'1 kg'),
(4,47,N'100 ml'),
(4,51,N'300 g'),
(4,66,N'1 gói'),
(4,72,N'100 g'),
(4,71,N'100 g'),

(5,1,N'1 kg'),
(5,14,N'1 kg'),
(5,66,N'1 gói'),
(5,72,N'100 g'),
(5,71,N'100 g'),
(5,47,N'100 ml'),


(6,11,N'1 kg'),
(6,65,N'1 gói'),
(6,72,N'100 g'),
(6,71,N'100 g'),
(6,47,N'100 ml'),

(7,9,N'1 kg'),
(7,65,N'1 gói'),
(7,72,N'100 g'),
(7,71,N'100 g'),
(7,47,N'100 ml'),

(8,8,N'1 kg'),
(8,27,N'200 g'),
(8,35,N'200 g'),
(8,47,N'100 ml'),
(8,37,N'100 g'),


(9,8,N'1 kg'),
(9,23,N'200 g'),
(9,30,N'200 g'),
(9,35,N'100 g'),
(9,44,N'100 ml'),
(9,55,N'100 ml'),

(10,3,N'1 kg'),
(10,47,N'100 ml'),
(10,51,N'200 g'),
(10,60,N'1 gói'),
(10,72,N'100 g'),
(10,71,N'100 g'),

(11,3,N'1 kg'),
(11,47,N'100 ml'),
(11,73,N'1 gói'),
(11,60,N'1 gói'),
(11,72,N'100 g'),
(11,71,N'100 g'),

(12,1,N'1 kg'),
(12,17,N'1 hộp'),
(12,73,N'1 gói'),
(12,60,N'1 gói'),
(12,72,N'100 g'),
(12,71,N'100 g'),
(12,56,N'100 ml'),

(13,1,N'1 kg'),
(13,17,N'1 hộp'),
(13,73,N'1 gói'),
(13,66,N'1 gói'),
(13,72,N'100 g'),
(13,71,N'100 g'),
(13,56,N'100 ml'),

(14,14,N'1 kg'),
(14,5,N'1 kg'),
(14,73,N'1 gói'),
(14,72,N'100 g'),
(14,71,N'100 g'),
(14,70,N'100 g'),
(14,44,N'100 ml'),

(15,14,N'1 kg'),
(15,5,N'1 kg'),
(15,73,N'1 gói'),
(15,72,N'100 g'),
(15,71,N'100 g'),
(15,70,N'100 g'),
(15,44,N'100 ml'),

(16,16,N'1 kg'),
(16,35,N'4 quả'),
(16,29,N'400 g'),
(16,71,N'100 g'),
(16,70,N'100 g'),
(16,44,N'100 ml'),

(17,16,N'1 kg'),
(17,35,N'4 quả'),
(17,69,N'200 g'),
(17,71,N'100 g'),
(17,70,N'100 g'),
(17,44,N'100 ml'),
(17,73,N'1 gói'),

(18,16,N'1 kg'),
(18,36,N'4 quả'),
(18,48,N'100 ml'),

(19,15,N'1 kg'),
(19,48,N'100 ml'),
(19,69,N'200 g'),
(19,72,N'100 g'),
(19,71,N'100 g'),

(20,15,N'1 kg'),
(20,35,N'1 quả'),
(20,33,N'1 quả'),
(20,44,N'100 ml'),
(20,69,N'200 g'),
(20,72,N'100 g'),
(20,71,N'100 g'),

(21,101,N'1 gói'),
(21,69,N'100 g'),
(21,56,N'1 chai'),
(21,37,N'100 g'),
(21,29,N'200 g'),
(21,57,N'100 ml'),

(23,6,N'500 g'),
(23,56,N'1 chai'),
(23,69,N'100 g'),
(23,37,N'100 g'),
(23,28,N'300 g'),
(23,45,N'200 ml'),
(23,80,N'1 gói'),

(22,5,N'500 g'),
(22,56,N'1 chai'),
(22,69,N'100 g'),
(22,37,N'100 g'),
(22,28,N'300 g'),
(22,45,N'200 ml'),
(23,79,N'1 gói'),

(24,98,N'1 hộp'),
(24,56,N'1 chai'),
(24,69,N'100 g'),
(24,37,N'100 g'),
(24,28,N'300 g'),
(24,45,N'200 ml'),
(24,79,N'1 gói'),

(25,5,N'500 g'),
(25,56,N'1 chai'),
(25,69,N'100 g'),
(25,37,N'100 g'),
(25,28,N'300 g'),
(25,45,N'200 ml'),
(25,79,N'1 gói'),
(25,32,N'2 quả'),

(26,4,N'500 g'),
(26,84,N'1 gói'),
(26,21,N'200 g'),
(26,22,N'100 g'),
(26,47,N'300 g'),
(26,52,N'200 ml'),

(27,4,N'500 g'),
(27,84,N'1 gói'),
(27,21,N'200 g'),
(27,22,N'100 g'),
(27,47,N'300 g'),
(27,52,N'200 ml'),
(27,17,N'3 quả'),
(27,35,N'1 quả'),

(28,40,N'1 hộp'),
(28,38,N'500 g'),
(28,39,N'400 g'),
(28,37,N'200 g'),
(28,47,N'300 g'),
(28,77,N'1 gói'),
(28,6,N'500 g'),
(28,63,N'1 gói'),


(29,7,N'500 g'),
(29,58,N'200 g'),
(29,71,N'100 g'),
(29,73,N'100 g'),
(29,94,N'2 cái'),
(29,96,N'1 hộp'),

(30,86,N'1 gói'),
(30,62,N'200 ml'),
(30,5,N'500 g'),
(30,32,N'200 g'),
(30,44,N'100 ml'),
(30,37,N'100 g'),
(30,98,N'200 g')

INSERT INTO Menu ([name], [category_id], [image], [description]) Values 
(N'Thực Đơn Hàng Ngày', 1, 'https://img.tastykitchen.vn/resize/764x-/2021/04/01/goi-y-mam-com-gia-dinh-1-ffed.jpg', N'Thực đơn gồm các món ăn mặn phổ biến cho bữa cơm hàng ngày'),
(N'Thực Đơn Chay Thanh Tịnh', 2, 'https://vnn-imgs-a1.vgcloud.vn/znews-photo.zadn.vn/w860/Uploaded/mrndcqjwq/2021_08_12/Mam_5.jpg', N'Thực đơn chay với các món ăn thanh tịnh, tốt cho sức khỏe'),
(N'Thực Đơn Chay Cao Cấp', 2, 'https://cdn.dealtoday.vn/img/s800x400/Buffet-chay-vo-vi-8_05052023151651.jpg?sign=ZYMWXahawyc-shGY6PHlcg', N'Thực đơn chay với các món ăn cao cấp, tinh tế và giàu dinh dưỡng'),
(N'Thực Đơn Giảm Cân', 3, 'https://www.btaskee.com/wp-content/uploads/2023/03/thuc-don-giam-can-lanh-manh.jpg', N'Thực đơn ăn kiêng dành cho người muốn giảm cân và duy trì vóc dáng'),
(N'Thực Đơn Gia Đình', 1, 'https://cdn.tgdd.vn/2021/06/CookProduct/mcmn-1200x676.jpg', N'Thực đơn với các món ăn gia đình ấm cúng, phù hợp cho bữa cơm sum vầy'),
(N'Thực Đơn Dinh Dưỡng', 2, 'https://img.tastykitchen.vn/resize/764x-/2020/09/14/91693108-1500881526740531-5011091584381353984-o-1-2765.jpg', N'Thực đơn chay giàu dinh dưỡng, cung cấp đầy đủ vitamin và khoáng chất'),
(N'Thực Đơn Thể Hình', 3, 'https://petaysresort.net/photo/top-3-nhung-che-do-thuc-don-giam-can-cho-nguoi-tap-gym.jpg', N'Thực đơn ăn kiêng dành cho người tập thể hình, giàu protein và ít béo');
INSERT INTO Menu_Details ([period], [day_of_week], [dish_id], [menu_id]) Values
(1, 2, 2, 1),
(2, 2, 3, 1),
(2, 2, 1, 1), 



--Thực Đơn Hàng Ngày
--Thứ Hai
(1, 2, 1, 1), 
(2, 2, 2, 1), 
(3, 2, 3, 1), 
-- Thứ Ba
(1, 3, 4, 1), 
(2, 3, 5, 1), 
(3, 3, 6, 1), 
-- Thứ Tư
(1, 4, 7, 1), 
(2, 4, 8, 1), 
(3, 4, 9, 1), 
-- Thứ Năm
(1, 5, 10, 1),
(2, 5, 11, 1),										
(3, 5, 12, 1),														   																					
-- Thứ Sáu	
(1, 6, 13, 1),		
(2, 6, 14, 1),					
(3, 6, 15, 1),		
-- Thứ Bảy
(1, 7, 16, 1),
(2, 7, 17, 1),
(3, 7, 18, 1),
--Thực Đơn Chay Thanh Tịnh
--Thứ Hai
(1, 2, 47, 2),
(2, 2, 48, 2),
(3, 2, 42, 2),
-- Thứ Ba
(1, 3, 46, 2),
(2, 3, 47, 2),
(3, 3, 48, 2),
-- Thứ Tư
(1, 4, 53, 2),
(2, 4, 54, 2),
(3, 4, 55, 2),
-- Thứ Năm
(1, 5, 38, 2),
(2, 5, 39, 2),
(3, 5, 40, 2),
-- Thứ Sáu
(1, 6, 41, 2),
(2, 6, 42, 2),
(3, 6, 47, 2),
-- Thứ Bảy
(1, 7, 65, 2),
(2, 7, 64, 2),
(3, 7, 63, 2), 
--Thực Đơn Chay Cao Cấp
--Thứ Hai
(1, 2, 47, 3),
(2, 2, 48, 3),
(3, 2, 42, 3),
-- Thứ Ba  
(1, 3, 46, 3),
(2, 3, 47, 3),
(3, 3, 48, 3),
-- Thứ Tư  
(1, 4, 53, 3),
(2, 4, 54, 3),
(3, 4, 55, 3),
-- Thứ Năm 
(1, 5, 38, 3),
(2, 5, 39, 3),
(3, 5, 40, 3),
-- Thứ Sáu 
(1, 6, 41, 3),
(2, 6, 42, 3),
(3, 6, 47, 3),
-- Thứ Bảy 
(1, 7, 65, 3),
(2, 7, 64, 3),
(3, 7, 63, 3),
--Thực Đơn Giảm Cân
-- Thứ Hai
(1, 2, 8, 4), 
(2, 2, 9, 4),  
(3, 2, 29, 4), 		
-- Thứ Ba  
(1, 3, 20, 4), 
(2, 3, 21, 4), 
(3, 3, 30, 4), 
-- Thứ Tư  
(1, 4, 22, 4),
(2, 4, 23, 4),
(3, 4, 31, 4), 
-- Thứ Năm 
(1, 5, 24, 4), 
(2, 5, 25, 4), 
(3, 5, 32, 4),
-- Thứ Sáu 
(1, 6, 33, 4), 
(2, 6, 34, 4), 
(3, 6, 35, 4),
-- Thứ Bảy 
(1, 7, 36, 4),
(2, 7, 37, 4),
(3, 7, 38, 4),
--Thực Đơn Gia Đình
-- Thứ Hai
(1, 2, 1, 5),  
(2, 2, 2, 5),  
(3, 2, 3, 5),  
-- Thứ Ba
(1, 3, 4, 5),  
(2, 3, 5, 5),  
(3, 3, 6, 5),  
-- Thứ Tư
(1, 4, 7, 5),  
(2, 4, 8, 5),  
(3, 4, 9, 5),  
-- Thứ Năm
(1, 5, 10, 5), 
(2, 5, 11, 5), 
(3, 5, 12, 5), 
-- Thứ Sáu
(1, 6, 13, 5), 
(2, 6, 14, 5), 
(3, 6, 15, 5), 
-- Thứ Bảy
(1, 7, 16, 5), 
(2, 7, 17, 5), 
(3, 7, 18, 5),
--Thực Đơn Dinh Dưỡng
-- Thứ Hai
(1, 2, 19, 6),  
(2, 2, 20, 6),  
(3, 2, 21, 6),  
-- Thứ Ba
(1, 3, 22, 6),  
(2, 3, 23, 6),  
(3, 3, 24, 6),  
-- Thứ Tư
(1, 4, 25, 6),  
(2, 4, 26, 6),  
(3, 4, 27, 6),  
-- Thứ Năm
(1, 5, 28, 6),  
(2, 5, 29, 6),  
(3, 5, 30, 6),  
-- Thứ Sáu
(1, 6, 31, 6),  
(2, 6, 32, 6),  
(3, 6, 33, 6),  
-- Thứ Bảy
(1, 7, 34, 6),  
(2, 7, 35, 6),  
(3, 7, 36, 6),
--Thực đơn thể hình
-- Thứ Hai
(1, 2, 8, 7),  
(2, 2, 9, 7),  
(3, 2, 26, 7), 
-- Thứ Ba
(1, 3, 22, 7), 
(2, 3, 24, 7), 
(3, 3, 27, 7), 
-- Thứ Tư
(1, 4, 28, 7), 
(2, 4, 30, 7), 
(3, 4, 33, 7), 
-- Thứ Năm
(1, 5, 34, 7), 
(2, 5, 35, 7), 
(3, 5, 10, 7), 
-- Thứ Sáu
(1, 6, 11, 7), 
(2, 6, 7, 7),  
(3, 6, 1, 7),  
-- Thứ Bảy
(1, 7, 8, 7),  
(2, 7, 9, 7),  
(3, 7, 3, 7);


CREATE OR ALTER TRIGGER trg_update_ship_date
ON Orders
AFTER INSERT
AS
BEGIN
    UPDATE Orders
    SET ship_date = DATEADD(DAY, 3, inserted.order_date)
    FROM Orders
    INNER JOIN inserted ON Orders.id = inserted.id;
END;

SELECT cpd.period, cpd.day_of_week, d.* FROM Customer_Plan_Details cpd INNER JOIN Dishes d ON cpd.dish_id = d.id WHERE cpd.customer_plan_id = ?

INSERT INTO Customer_Plan(name,account_id) values ('Long PLAN', 1)

INSERT INTO Customer_Plan_Details(customer_plan_id, day_of_week, period, dish_id) values 
(2,2,1,1),
(2,2,1,2),
(2,2,2,3),
(2,2,2,4),
(2,2,3,5),
(2,2,3,6),
(2,2,3,4)