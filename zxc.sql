USE [master]
GO
/****** Object:  Database [TradeAnisimov]    Script Date: 04.03.2024 14:39:49 ******/
CREATE DATABASE [TradeAnisimov]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TradeAnisimov', FILENAME = N'D:\SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\TradeAnisimov.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TradeAnisimov_log', FILENAME = N'D:\SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\TradeAnisimov_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TradeAnisimov] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TradeAnisimov].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TradeAnisimov] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TradeAnisimov] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TradeAnisimov] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TradeAnisimov] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TradeAnisimov] SET ARITHABORT OFF 
GO
ALTER DATABASE [TradeAnisimov] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TradeAnisimov] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TradeAnisimov] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TradeAnisimov] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TradeAnisimov] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TradeAnisimov] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TradeAnisimov] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TradeAnisimov] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TradeAnisimov] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TradeAnisimov] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TradeAnisimov] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TradeAnisimov] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TradeAnisimov] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TradeAnisimov] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TradeAnisimov] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TradeAnisimov] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TradeAnisimov] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TradeAnisimov] SET RECOVERY FULL 
GO
ALTER DATABASE [TradeAnisimov] SET  MULTI_USER 
GO
ALTER DATABASE [TradeAnisimov] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TradeAnisimov] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TradeAnisimov] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TradeAnisimov] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TradeAnisimov] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TradeAnisimov] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TradeAnisimov', N'ON'
GO
ALTER DATABASE [TradeAnisimov] SET QUERY_STORE = OFF
GO
USE [TradeAnisimov]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 04.03.2024 14:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [date] NULL,
	[OrderDeliveryDate] [date] NOT NULL,
	[OrderPickupPoint] [int] NOT NULL,
	[OrderCode] [int] NULL,
	[OrderStatus] [nvarchar](max) NOT NULL,
	[UserID] [int] NULL,
 CONSTRAINT [PK__Order__C3905BAF74970EF4] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 04.03.2024 14:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserSurname] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[UserPatronymic] [nvarchar](100) NOT NULL,
	[UserLogin] [nvarchar](max) NOT NULL,
	[UserPassword] [nvarchar](max) NOT NULL,
	[UserRole] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 04.03.2024 14:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[OrderID] [int] NOT NULL,
	[ProductArticleNumber] [nvarchar](255) NOT NULL,
	[ProductQuanity] [int] NULL,
 CONSTRAINT [PK__OrderPro__817A2662C9473819] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderPickupPoint]    Script Date: 04.03.2024 14:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderPickupPoint](
	[OrderPickupPoint] [int] NOT NULL,
	[Index] [int] NULL,
	[City] [nvarchar](255) NULL,
	[Street] [nvarchar](255) NULL,
	[Home] [nvarchar](255) NULL,
 CONSTRAINT [PK_OrderPickupPoint] PRIMARY KEY CLUSTERED 
(
	[OrderPickupPoint] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 04.03.2024 14:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductArticleNumber] [nvarchar](255) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[ProductUnit] [nvarchar](50) NOT NULL,
	[ProductCost] [int] NOT NULL,
	[ProductDiscountAmount] [tinyint] NOT NULL,
	[ProductManufacturer] [nvarchar](max) NOT NULL,
	[ProductProvider] [nvarchar](50) NOT NULL,
	[ProductCategory] [nvarchar](max) NOT NULL,
	[ProductCurrentDiscount] [int] NOT NULL,
	[ProductQuantityInStock] [int] NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[ProductPhoto] [nvarchar](50) NULL,
 CONSTRAINT [PK__Product__2EA7DCD59CC77B7B] PRIMARY KEY CLUSTERED 
(
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrderView]    Script Date: 04.03.2024 14:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrderView]
AS
SELECT dbo.[Order].OrderID AS [Номер заказа], dbo.[Order].OrderDate AS [Дата заказа], dbo.[Order].OrderDeliveryDate AS [Дата доставки], CASE WHEN dbo.[Order].OrderID IS NULL 
                  THEN 'Неавторизованный пользователь' ELSE dbo.[User].UserSurname + ' ' + dbo.[User].UserName + ' ' + dbo.[User].UserPatronymic END AS Клиент, dbo.[Order].OrderStatus AS Статус, 
                  CAST(dbo.OrderPickupPoint.[Index] AS nvarchar(10)) + ' ' + dbo.OrderPickupPoint.City + ' ' + dbo.OrderPickupPoint.Street + ' ' + CAST(dbo.OrderPickupPoint.Home AS nvarchar(3)) AS Адрес, 
                  STRING_AGG(dbo.Product.ProductArticleNumber + ' ' + dbo.Product.ProductName + ' ' + CAST(dbo.OrderProduct.ProductQuanity AS nvarchar) + ' шт', ', ') AS Товары, SUM(dbo.Product.ProductCost * dbo.OrderProduct.ProductQuanity) 
                  AS [Общая цена], SUM(dbo.Product.ProductCost * dbo.OrderProduct.ProductQuanity - dbo.Product.ProductCost * dbo.OrderProduct.ProductQuanity / 100 * dbo.Product.ProductDiscountAmount) AS [Цена со скидкой]
FROM     dbo.[Order] INNER JOIN
                  dbo.OrderPickupPoint ON dbo.[Order].OrderPickupPoint = dbo.OrderPickupPoint.OrderPickupPoint INNER JOIN
                  dbo.OrderProduct ON dbo.[Order].OrderID = dbo.OrderProduct.OrderID INNER JOIN
                  dbo.Product AS prod1 ON dbo.OrderProduct.ProductArticleNumber = prod1.ProductArticleNumber LEFT OUTER JOIN
                  dbo.[User] ON dbo.[Order].UserID = dbo.[User].UserID INNER JOIN
                  dbo.Product ON dbo.OrderProduct.ProductArticleNumber = dbo.Product.ProductArticleNumber
GROUP BY dbo.OrderProduct.OrderID, dbo.[Order].OrderID, dbo.[Order].OrderDate, dbo.[Order].OrderDeliveryDate, dbo.[User].UserSurname, dbo.[User].UserName, dbo.[User].UserPatronymic, dbo.[Order].OrderStatus, 
                  dbo.OrderPickupPoint.[Index], dbo.OrderPickupPoint.City, dbo.OrderPickupPoint.Street, dbo.OrderPickupPoint.Home
GO
/****** Object:  View [dbo].[_Product User]    Script Date: 04.03.2024 14:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[_Product User]
AS
SELECT        dbo.Product.ProductName, dbo.Product.ProductCategory, dbo.OrderProduct.ProductQuanity, dbo.[User].UserSurname, dbo.[User].UserName, dbo.[User].UserPatronymic, dbo.OrderProduct.ProductArticleNumber, 
                         dbo.OrderProduct.OrderID
FROM            dbo.[Order] INNER JOIN
                         dbo.[User] ON dbo.[Order].UserID = dbo.[User].UserID INNER JOIN
                         dbo.OrderProduct ON dbo.[Order].OrderID = dbo.OrderProduct.OrderID INNER JOIN
                         dbo.Product ON dbo.OrderProduct.ProductArticleNumber = dbo.Product.ProductArticleNumber
GO
/****** Object:  Table [dbo].[Role]    Script Date: 04.03.2024 14:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (1, CAST(N'2022-05-16' AS Date), CAST(N'2022-05-23' AS Date), 1, 801, N'Завершен', 52)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (2, CAST(N'2022-05-16' AS Date), CAST(N'2022-05-23' AS Date), 14, 802, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (3, CAST(N'2022-05-17' AS Date), CAST(N'2022-05-18' AS Date), 2, 803, N'завершен', 53)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (4, CAST(N'2022-05-17' AS Date), CAST(N'2022-05-24' AS Date), 22, 804, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (5, CAST(N'2022-05-19' AS Date), CAST(N'2022-05-26' AS Date), 2, 805, N'Новый', 54)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (6, CAST(N'2022-05-20' AS Date), CAST(N'2022-05-27' AS Date), 28, 806, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (7, CAST(N'2022-05-22' AS Date), CAST(N'2022-05-29' AS Date), 3, 807, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (8, CAST(N'2022-05-22' AS Date), CAST(N'2022-05-29' AS Date), 32, 808, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (9, CAST(N'2022-05-24' AS Date), CAST(N'2022-05-31' AS Date), 5, 809, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (10, CAST(N'2022-05-24' AS Date), CAST(N'2022-05-31' AS Date), 36, 810, N'Новый', 55)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (11, CAST(N'2024-03-03' AS Date), CAST(N'2024-03-10' AS Date), 7, 811, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (12, CAST(N'2024-03-03' AS Date), CAST(N'2024-03-10' AS Date), 5, 812, N'Новый', 11)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (17, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 3, 813, N'Новый', 9)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (18, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 5, 814, N'Новый', 9)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (23, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 16, 816, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (24, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 36, 817, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (25, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 1, 818, N'Новый', 9)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (26, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 16, 819, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (27, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 11, 820, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (28, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 3, 821, N'Новый', NULL)
INSERT [dbo].[Order] ([OrderID], [OrderDate], [OrderDeliveryDate], [OrderPickupPoint], [OrderCode], [OrderStatus], [UserID]) VALUES (29, CAST(N'2024-03-04' AS Date), CAST(N'2024-03-11' AS Date), 3, 822, N'Новый', NULL)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (1, 344288, N' г. Талнах', N' ул. Чехова', N'1')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (2, 614164, N' г.Талнах', N'  ул. Степная', N'30')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (3, 394242, N' г. Талнах', N' ул. Коммунистическая', N'43')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (4, 660540, N' г. Талнах', N' ул. Солнечная', N'25')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (5, 125837, N' г. Талнах', N' ул. Шоссейная', N'40')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (6, 125703, N' г. Талнах', N' ул. Партизанская', N'49')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (7, 625283, N' г. Талнах', N' ул. Победы', N'46')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (8, 614611, N' г. Талнах', N' ул. Молодежная', N'50')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (9, 454311, N' г.Талнах', N' ул. Новая', N'19')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (10, 660007, N' г.Талнах', N' ул. Октябрьская', N'19')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (11, 603036, N' г. Талнах', N' ул. Садовая', N'4')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (12, 450983, N' г.Талнах', N' ул. Комсомольская', N'26')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (13, 394782, N' г. Талнах', N' ул. Чехова', N'3')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (14, 603002, N' г. Талнах', N' ул. Дзержинского', N'28')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (15, 450558, N' г. Талнах', N' ул. Набережная', N'30')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (16, 394060, N' г.Талнах', N' ул. Фрунзе', N'43')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (17, 410661, N' г. Талнах', N' ул. Школьная', N'50')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (18, 625590, N' г. Талнах', N' ул. Коммунистическая', N'20')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (19, 625683, N' г. Талнах', N' ул. 8 Марта', N'1')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (20, 400562, N' г. Талнах', N' ул. Зеленая', N'32')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (21, 614510, N' г. Талнах', N' ул. Маяковского', N'47')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (22, 410542, N' г. Талнах', N' ул. Светлая', N'46')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (23, 620839, N' г. Талнах', N' ул. Цветочная', N'8')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (24, 443890, N' г. Талнах', N' ул. Коммунистическая', N'1')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (25, 603379, N' г. Талнах', N' ул. Спортивная', N'46')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (26, 603721, N' г. Талнах', N' ул. Гоголя', N'41')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (27, 410172, N' г. Талнах', N' ул. Северная', N'13')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (28, 420151, N' г. Талнах', N' ул. Вишневая', N'32')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (29, 125061, N' г. Талнах', N' ул. Подгорная', N'8')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (30, 630370, N' г. Талнах', N' ул. Шоссейная', N'24')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (31, 614753, N' г. Талнах', N' ул. Полевая', N'35')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (32, 426030, N' г. Талнах', N' ул. Маяковского', N'44')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (33, 450375, N' г. Талнах ', N'ул. Клубная', N'44')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (34, 625560, N' г. Талнах', N' ул. Некрасова', N'12')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (35, 630201, N' г. Талнах', N' ул. Комсомольская', N'17')
INSERT [dbo].[OrderPickupPoint] ([OrderPickupPoint], [Index], [City], [Street], [Home]) VALUES (36, 190949, N' г. Талнах', N' ул. Мичурина', N'26')
GO
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (1, N'T793T4', 3)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (1, N'А112Т4', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (2, N'F573T5', 10)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (2, N'G387Y6', 16)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (3, N'B736H6', 20)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (3, N'D735T5', 20)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (4, N'H384H3', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (4, N'K437E6', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (5, N'E732R7', 4)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (5, N'R836H6', 3)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (6, N'F839R6', 4)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (6, N'G304H6', 4)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (7, N'C430T4', 10)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (7, N'C946Y6', 3)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (8, N'B963H5', 5)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (8, N'V403G6', 5)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (9, N'V026J4', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (9, N'V727Y6', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (10, N'C635Y6', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (10, N'W405G6', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (11, N'B736H6', 4)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (12, N'B736H6', 4)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (12, N'B963H5', 6)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (12, N'D735T5', 10)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (12, N'E732R7', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (18, N'B736H6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (18, N'D735T5', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (18, N'F573T5', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (18, N'G387Y6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (23, N'V403G6', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (24, N'R836H6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (24, N'T793T4', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (25, N'B736H6', 1900)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (25, N'H495H6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (26, N'B736H6', 6)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (27, N'B736H6', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (27, N'B963H5', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (28, N'B963H5', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (28, N'C430T4', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (28, N'F392G6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (28, N'L593H5', 0)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (28, N'R836H6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (28, N'T793T4', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (29, N'B963H5', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (29, N'C430T4', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (29, N'F392G6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (29, N'L593H5', -1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (29, N'R836H6', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity]) VALUES (29, N'T793T4', 1)
GO
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'B736H6', N'Набор вилок', N'шт.', 220, 5, N'Alaska', N'LeroiMerlin', N'Вилки', 0, 4, N'Вилка столовая 21,2 см «Аляска бэйсик» сталь KunstWerk', N'B736H6.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'B963H5', N'Набор ложек', N'шт.', 800, 5, N'Smart Home', N'LeroiMerlin', N'Ложки', 3, 8, N'Ложка 21 мм металлическая (медная) (Упаковка 10 шт)', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'C430T4', N'Ложка столовая', N'шт.', 1600, 30, N'Attribute', N'LeroiMerlin', N'наборы', 3, 6, N'Набор на одну персону (4 предмета) серия "Bistro", нерж. сталь, Was, Германия.', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'C635Y6', N'Вилки столовые', N'шт.', 1000, 15, N'Apollo', N'Максидом', N'наборы', 4, 25, N'Детский столовый набор Fissman «Зебра» ', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'C730R7', N'Ложка чайная', N'шт.', 300, 5, N'Smart Home', N'LeroiMerlin', N'Ложки', 3, 17, N'Ложка детская столовая', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'C943G5', N'Вилка столовая', N'шт.', 200, 5, N'Attribute', N'Максидом', N'наборы', 4, 12, N'Attribute Набор чайных ложек Baguette 3 предмета серебристый', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'C946Y6', N'Набор столовых приборов', N'шт.', 300, 15, N'Apollo', N'LeroiMerlin', N'Вилки', 2, 16, N'Вилка детская столовая', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'D735T5', N'Набор вилок', N'шт.', 220, 5, N'Alaska', N'LeroiMerlin', N'Ложки', 2, 13, N'Ложка чайная ALASKA Eternum', N'D735T5.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'E732R7', N'Набор столовых приборов', N'шт.', 990, 15, N'Smart Home', N'Максидом', N'наборы', 5, 6, N'Набор столовых приборов Smart Home20 Black в подарочной коробке, 4 шт', N'E732R7.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'F392G6', N'Набор  столовых ножей', N'шт.', 490, 10, N'Apollo', N'LeroiMerlin', N'наборы', 4, 9, N'Apollo Набор столовых приборов Chicago 4 предмета серебристый', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'F573T5', N'Набор столовых приборов', N'шт.', 650, 15, N'Davinci', N'Максидом', N'вилки', 3, 4, N'Вилки столовые на блистере / 6 шт.', N'F573T5.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'F745K4', N'Ложка детская', N'шт.', 2000, 10, N'Mayer & Boch', N'LeroiMerlin', N'наборы', 3, 2, N'Столовые приборы для салата Orskov Lava, 2шт', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'F839R6', N'Ложка чайная', N'шт.', 400, 15, N'Doria', N'Максидом', N'Ложки', 2, 6, N'Ложка чайная DORIA Eternum', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'G304H6', N'Набор ложек', N'шт.', 500, 5, N'Apollo', N'Максидом', N'Ложки', 4, 12, N'Набор ложек столовых APOLLO "Bohemica" 3 пр.', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'G387Y6', N'Набор на одну персону', N'шт.', 441, 5, N'Doria', N'Максидом', N'Ложки', 4, 23, N'Ложка столовая DORIA L=195/60 мм Eternum', N'G387Y6.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'H384H3', N'Вилка столовая', N'шт.', 600, 15, N'Apollo', N'Максидом', N'наборы', 2, 9, N'Набор столовых приборов для торта Palette 7 предметов серебристый', N'H384H3.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'H495H6', N'Набор чайных ложек', N'шт.', 7000, 15, N'Mayer & Boch', N'LeroiMerlin', N'ножи', 2, 15, N'Набор стейковых ножей 4 пр. в деревянной коробке', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'K437E6', N'Набор чайных ложек', N'шт.', 530, 5, N'Apollo', N'Максидом', N'наборы', 3, 16, N'Набор вилок столовых APOLLO "Aurora" 3шт.', N'K437E6.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'L593H5', N'Нож для стейка', N'шт.', 1300, 25, N'Mayer & Boch', N'Максидом', N'наборы', 5, 14, N'Набор ножей Mayer & Boch, 4 шт', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'N493G6', N'Ложка чайная', N'шт.', 2550, 15, N'Smart Home', N'LeroiMerlin', N'наборы', 4, 6, N'Набор для сервировки сыра Select', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'R836H6', N'Ложка', N'шт.', 250, 5, N'Attribute', N'LeroiMerlin', N'ножи', 3, 16, N'Attribute Набор столовых ножей Baguette 2 предмета серебристый', N'R836H6.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'S394J5', N'Набор для серверовки', N'шт.', 170, 5, N'Attribute', N'LeroiMerlin', N'наборы', 3, 4, N'Attribute Набор чайных ложек Chaplet 3 предмета серебристый', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'S395B5', N'набор ножей', N'шт.', 600, 10, N'Apollo', N'LeroiMerlin', N'ножи', 4, 15, N'Нож для стейка 11,5 см серебристый/черный', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'T793T4', N'набор ножей', N'шт.', 250, 10, N'Attribute', N'LeroiMerlin', N'Ложки', 3, 16, N'Набор столовых ложек Baguette 3 предмета серебристый', N'T793T4.jpg')
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'V026J4', N'Набор десертных ложек', N'шт.', 700, 15, N'Apollo', N'Максидом', N'наборы', 3, 9, N'абор ножей для стейка и пиццы Swiss classic 2 шт. желтый', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'V403G6', N'Набор стейковых ножей', N'шт.', 600, 15, N'Doria', N'Максидом', N'Ложки', 5, 24, N'Ложка чайная DORIA Eternum', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'V727Y6', N'Столовые приборы для салата', N'шт.', 3000, 10, N'Mayer & Boch', N'LeroiMerlin', N'Ложки', 4, 8, N'Набор десертных ложек на подставке Размер: 7*7*15 см', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'W295Y5', N'Детский столовый набор', N'шт.', 1100, 15, N'Attribute', N'Максидом', N'наборы', 2, 16, N'Набор сервировочный для торта "Розанна"', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'W405G6', N'Набор столовых приборов', N'шт.', 1300, 25, N'Attribute', N'LeroiMerlin', N'наборы', 3, 4, N'Набор сервировочных столовых вилок Цветы', NULL)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductUnit], [ProductCost], [ProductDiscountAmount], [ProductManufacturer], [ProductProvider], [ProductCategory], [ProductCurrentDiscount], [ProductQuantityInStock], [ProductDescription], [ProductPhoto]) VALUES (N'А112Т4', N'Сервировочный набор для торта', N'шт.', 1600, 30, N'Davinci', N'Максидом', N'Вилки', 2, 6, N'Набор столовых вилок Davinci, 20 см 6 шт.', N'А112Т4.jpg')
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Клиент')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Менеджер')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Администратор')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (1, N'Ефремов ', N'Сергей', N'Пантелеймонович', N'loginDEppn2018', N'6}i+FD', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (2, N'Родионова ', N'Тамара', N'Валентиновна', N'loginDElqb2018', N'RNynil', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (3, N'Миронова ', N'Галина', N'Улебовна', N'loginDEydn2018', N'34I}X9', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (4, N'Сидоров ', N'Роман', N'Иринеевич', N'loginDEijg2018', N'4QlKJW', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (5, N'Ситников ', N'Парфений', N'Всеволодович', N'loginDEdpy2018', N'MJ0W|f', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (6, N'Никонов ', N'Роман', N'Геласьевич', N'loginDEwdm2018', N'&PynqU', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (7, N'Щербаков ', N'Владимир', N'Матвеевич', N'loginDEdup2018', N'JM+2{s', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (8, N'Кулаков ', N'Мартын', N'Михаилович', N'loginDEhbm2018', N'9aObu4', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (9, N'Сазонова ', N'Оксана', N'Лаврентьевна', N'loginDExvq2018', N'hX0wJz', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (10, N'Архипов ', N'Варлам', N'Мэлорович', N'loginDErks2018', N'LQNSjo', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (11, N'Устинова ', N'Ираида', N'Мэлоровна', N'loginDErvb2018', N'ceAf&R', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (12, N'Лукин ', N'Георгий', N'Альбертович', N'loginDEulo2018', N'hFMG23', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (13, N'Кононов ', N'Эдуард', N'Валентинович', N'loginDEgfw2018', N'3c2Ic1', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (14, N'Орехова ', N'Клавдия', N'Альбертовна', N'loginDEmxb2018', N'ZPXcRS', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (15, N'Яковлев ', N'Яков', N'Эдуардович', N'loginDEgeq2018', N'&&Eim0', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (16, N'Воронов ', N'Мэлс', N'Семёнович', N'loginDEkhj2018', N'Pbc0t{', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (17, N'Вишнякова ', N'Ия', N'Данииловна', N'loginDEliu2018', N'32FyTl', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (18, N'Третьяков ', N'Фёдор', N'Вадимович', N'loginDEsmf2018', N'{{O2QG', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (19, N'Макаров ', N'Максим', N'Ильяович', N'loginDEutd2018', N'GbcJvC', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (20, N'Шубина ', N'Маргарита', N'Анатольевна', N'loginDEpgh2018', N'YV2lvh', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (21, N'Блинова ', N'Ангелина', N'Владленовна', N'loginDEvop2018', N'pBP8rO', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (22, N'Воробьёв ', N'Владлен', N'Фролович', N'loginDEwjo2018', N'EQaD|d', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (23, N'Сорокина ', N'Прасковья', N'Фёдоровна', N'loginDEbur2018', N'aZKGeI', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (24, N'Давыдов ', N'Яков', N'Антонович', N'loginDEszw2018', N'EGU{YE', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (25, N'Рыбакова ', N'Евдокия', N'Анатольевна', N'loginDExsu2018', N'*2RMsp', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (26, N'Маслов ', N'Геннадий', N'Фролович', N'loginDEztn2018', N'nJBZpU', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (27, N'Цветкова ', N'Элеонора', N'Аристарховна', N'loginDEtmn2018', N'UObB}N', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (28, N'Евдокимов ', N'Ростислав', N'Александрович', N'loginDEhep2018', N'SwRicr', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (29, N'Никонова ', N'Венера', N'Станиславовна', N'loginDEevr2018', N'zO5l}l', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (30, N'Громов ', N'Егор', N'Антонович', N'loginDEnpa2018', N'M*QLjf', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (31, N'Суворова ', N'Валерия', N'Борисовна', N'loginDEgyt2018', N'Pav+GP', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (32, N'Мишина ', N'Елизавета', N'Романовна', N'loginDEbrr2018', N'Z7L|+i', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (33, N'Зимина ', N'Ольга', N'Аркадьевна', N'loginDEyoo2018', N'UG1BjP', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (34, N'Игнатьев ', N'Игнатий', N'Антонинович', N'loginDEaob2018', N'3fy+3I', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (35, N'Пахомова ', N'Зинаида', N'Витальевна', N'loginDEwtz2018', N'&GxSST', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (36, N'Устинов ', N'Владимир', N'Федосеевич', N'loginDEctf2018', N'sjt*3N', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (37, N'Кулаков ', N'Мэлор', N'Вячеславович', N'loginDEipm2018', N'MAZl6|', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (38, N'Сазонов ', N'Авксентий', N'Брониславович', N'loginDEjoi2018', N'o}C4jv', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (39, N'Бурова ', N'Наина', N'Брониславовна', N'loginDEwap2018', N'4hny7k', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (40, N'Фадеев ', N'Демьян', N'Федосеевич', N'loginDEaxm2018', N'BEc3xq', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (41, N'Бобылёва ', N'Дарья', N'Якуновна', N'loginDEsmq2018', N'ATVmM7', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (42, N'Виноградов ', N'Созон', N'Арсеньевич', N'loginDEeur2018', N'n4V{wP', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (43, N'Гордеев ', N'Владлен', N'Ефимович', N'loginDEvke2018', N'WQLXSl', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (44, N'Иванова ', N'Зинаида', N'Валерьевна', N'loginDEvod2018', N'0EW93v', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (45, N'Гусев ', N'Руслан', N'Дамирович', N'loginDEjaw2018', N'h6z&Ky', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (46, N'Маслов ', N'Дмитрий', N'Иванович', N'loginDEpdp2018', N'8NvRfC', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (47, N'Антонова ', N'Ульяна', N'Семёновна', N'loginDEjpp2018', N'oMOQq3', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (48, N'Орехова ', N'Людмила', N'Владимировна', N'loginDEkiy2018', N'BQzsts', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (49, N'Авдеева ', N'Жанна', N'Куприяновна', N'loginDEhmn2018', N'a|Iz|7', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (50, N'Кузнецов ', N'Фрол', N'Варламович', N'loginDEfmn2018', N'cw3|03', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (52, N'Ситникова', N'Эмилия', N'Степановна', N'login232131rf', N'frgr233', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (53, N'Воронцова', N'Виктория', N'Саввична', N'loginDrf321', N'jfhgbr23', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (54, N'Егоров', N'Артём', N'Евгеньевич', N'loginfgkrg', N'jfhgr23', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (55, N'Софронов ', N'Ярослав', N'Игоревич', N'loginGtfr', N'jgtrg23', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderPickupPoint] FOREIGN KEY([OrderPickupPoint])
REFERENCES [dbo].[OrderPickupPoint] ([OrderPickupPoint])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderPickupPoint]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Order__2C3393D0] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Order__2C3393D0]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Produ__2D27B809] FOREIGN KEY([ProductArticleNumber])
REFERENCES [dbo].[Product] ([ProductArticleNumber])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Produ__2D27B809]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([UserRole])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteProduct]
@Article nvarchar(255)
as
begin
	delete from Product
	where ProductArticleNumber = @Article
end
GO
/****** Object:  StoredProcedure [dbo].[EditProduct]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[EditProduct]

	@ProductOldArticleNumber nvarchar(255),
	@ProductNewArticleNumber nvarchar(255),
	@ProductName nvarchar(max),
	@ProductUnit nvarchar(3),
	@ProductCost int,
	@ProductDiscountAmount tinyint,
	@ProductManufacturer nvarchar(max),
	@ProductProvider nvarchar(50),
	@ProductCategory nvarchar(max),
	@ProductCurrentDiscount int,
	@ProductQuantityInStock int,
	@ProductDescription nvarchar(max),
	@ProductPhoto nvarchar(50)
as
begin
	update Product
	set ProductArticleNumber = @ProductNewArticleNumber,
	ProductName = @ProductName,
    ProductUnit = @ProductUnit,
    ProductCost = @ProductCost,
    ProductDiscountAmount = @ProductDiscountAmount,
    ProductManufacturer = @ProductManufacturer,
    ProductProvider = @ProductProvider,
    ProductCategory = @ProductCategory,
    ProductCurrentDiscount = @ProductCurrentDiscount,
    ProductQuantityInStock = @ProductQuantityInStock,
    ProductDescription = @ProductDescription,
    ProductPhoto = @ProductPhoto

	where ProductArticleNumber = @ProductOldArticleNumber

end
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProduct]

	@ProductArticleNumber nvarchar(255) ,
	@ProductName nvarchar(max),
	@ProductUnit nvarchar(50),
	@ProductCost decimal(19, 4),
	@ProductDiscountAmount tinyint ,
	@ProductManufacturer nvarchar(max),
	@ProductProvider nvarchar(50),
	@ProductCategory nvarchar(max),
	@ProductCurrentDiscount int,
	@ProductQuantityInStock int,
	@ProductDescription nvarchar(max),
	@ProductPhoto nvarchar(50)
AS
BEGIN
	INSERT INTO [Product]
	(ProductArticleNumber, 
	ProductName, 
	ProductUnit, 
	ProductCost, 
	ProductDiscountAmount, 
	ProductManufacturer, 
	ProductProvider, 
	ProductCategory, 
	ProductCurrentDiscount, 
	ProductQuantityInStock, 
	ProductDescription, 
	ProductPhoto)

VALUES (
	@ProductArticleNumber, 
	@ProductName, 
	@ProductUnit, 
	@ProductCost, 
	@ProductDiscountAmount, 
	@ProductManufacturer, 
	@ProductProvider, 
	@ProductCategory, 
	@ProductCurrentDiscount, 
	@ProductQuantityInStock, 
	@ProductDescription, 
	@ProductPhoto)
END
GO
/****** Object:  StoredProcedure [dbo].[MakeOrder]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[MakeOrder]
	@OrderDate date,
	@DeliveryDate date,
	@PickupPoint int,
	@Code int,
	@Status nvarchar(5),
	@UserID int
as
begin

	insert into [Order] (
		[OrderDate], 
		[OrderDeliveryDate],
		[OrderPickupPoint],
		[OrderCode],
		[OrderStatus],
		[UserID]
		)
	values (
		@OrderDate, 
		@DeliveryDate,
		@PickupPoint,
		@Code,
		@Status,
		@UserID)

end
GO
/****** Object:  StoredProcedure [dbo].[MakeOrderProduct]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[MakeOrderProduct]
	@ID int,
	@Article nvarchar(255),
	@Quantity int 
as
begin

	insert into [OrderProduct] ([OrderID], [ProductArticleNumber], [ProductQuanity])
	values (@ID, @Article, @Quantity)

end

GO
/****** Object:  StoredProcedure [dbo].[OrderAdd]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[OrderAdd]
	-- Add the parameters for the stored procedure here
	@OrderID int output,
	@OrderDate datetime,
	@OrderDeliveryDate datetime,
	@OrderPickupPoint int,
	@OrderCode int,
	@OrderStatus nvarchar (max),
	@UserID int,
	@error_str varchar(100) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

    -- Insert statements for procedure here
	if exists (select top 1 1 from OrderID
				where OrderDate=@OrderDate and OrderDeliveryDate=@OrderDeliveryDate and OrderPickupPoint=@OrderPickupPoint and OrderCode=@OrderCode and OrderStatus=@OrderStatus and UserID=@UserID)
begin
set @error_str='Такая запись уже существует.'
return -1
end

	Insert into [Order] (OrderDate, OrderDeliveryDate, OrderPickupPoint, OrderCode, OrderStatus, UserID) 
	Values (@OrderDate, @OrderDeliveryDate, @OrderPickupPoint, @OrderCode, @OrderStatus, @UserID) 
	set @OrderID=@@Identity
set @error_str='Запись успешно добавлена.'
RETURN 0
	 
END
GO
/****** Object:  StoredProcedure [dbo].[OrderDelete]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[OrderDelete]
	-- Add the parameters for the stored procedure here
	@OrderID int,
	@err varchar (200) output
AS
IF EXISTS (select top 1 1 from [OrderProduct] WHERE OrderID=@OrderID)
begin
	set @err = 'Ошибка удаления данных!'
	return -1
end
else
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Delete FROM [Order] WHERE OrderID=@OrderID
	set @err = 'Запись удалена'
	RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[OrderUpdate]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[OrderUpdate] 
	-- Add the parameters for the stored procedure here
	@OrderID int,
	@OrderDate datetime,
	@OrderDeliveryDate datetime,
	@OrderPickupPoint int,
	@OrderCode int,
	@OrderStatus nvarchar (max),
	@UserID int,
	@error_str nvarchar (100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
if exists (select top 1 1 
		from [Order]
		where [OrderID]=@OrderID and
			[OrderDate]=@OrderDate and
			[OrderDeliveryDate]=@OrderDeliveryDate and
			[OrderPickupPoint]=@OrderPickupPoint and
			[OrderCode]=@OrderCode and
			[OrderStatus]=@OrderStatus and
			[UserID]=@UserID )
		begin
	  return 0
	  end

if exists (select top 1 1 
		from [Order]
		where [OrderID]<>@OrderID and
			[OrderDate]=@OrderDate and
			[OrderDeliveryDate]=@OrderDeliveryDate and
			[OrderPickupPoint]=@OrderPickupPoint and
			[OrderCode]=@OrderCode and
			[OrderStatus]=@OrderStatus and
			[UserID]=@UserID )
		begin
		set @error_str ='Такая запись уже существует.'
	  return -1
	  end

UPDATE [Order]
SET OrderDate=@OrderDate,
	OrderDeliveryDate=@OrderDeliveryDate,
    OrderPickupPoint=@OrderPickupPoint,
	OrderCode=@OrderCode,
	OrderStatus=@OrderStatus,
	UserID=@UserID
WHERE OrderID=@OrderID
set @error_str ='Запись успешно изменена.'
RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[SelectCategory]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[SelectCategory]

AS
BEGIN

select distinct ProductCategory 
from [dbo].[Product]

END
GO
/****** Object:  StoredProcedure [dbo].[SelectPickupPointData]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectPickupPointData]
AS
BEGIN
	select *
	from [OrderPickupPoint]
END
GO
/****** Object:  StoredProcedure [dbo].[SelectProducts]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[SelectProducts]
	@discountFrom decimal (5,2),
	@discountTo decimal(5,2),
	@category varchar(30)

AS
BEGIN

select * 
from [dbo].[Product]
where ProductDiscountAmount >= @discountFrom
	and ProductDiscountAmount <= @discountTo
	and ProductCategory like '%' + @category + '%'

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateOrder]
	@ID int,
	@DeliveryDate date,
	@Status nvarchar(50)
as
begin

	update [Order] 
	set
		[OrderDeliveryDate] = @DeliveryDate,
		[OrderStatus] = @Status
	where [OrderID] = @ID

end
GO
/****** Object:  StoredProcedure [dbo].[UserCheck]    Script Date: 04.03.2024 14:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserCheck]

@login varchar(50),
@password varchar(50)
AS
BEGIN
select *
from [User]
where UserLogin = @login
and UserPassword = @password
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 208
               Left = 818
               Bottom = 338
               Right = 992
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Order"
            Begin Extent = 
               Top = 18
               Left = 597
               Bottom = 148
               Right = 782
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "OrderProduct"
            Begin Extent = 
               Top = 214
               Left = 290
               Bottom = 327
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_Product User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_Product User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[3] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Order"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrderPickupPoint"
            Begin Extent = 
               Top = 7
               Left = 315
               Bottom = 170
               Right = 525
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "User"
            Begin Extent = 
               Top = 175
               Left = 48
               Bottom = 338
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "prod1"
            Begin Extent = 
               Top = 154
               Left = 573
               Bottom = 317
               Right = 830
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 7
               Left = 864
               Bottom = 170
               Right = 1121
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrderProduct"
            Begin Extent = 
               Top = 7
               Left = 573
               Bottom = 148
               Right = 816
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 19
         Width = 284
         Width = 72
         Width = 1200
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OrderView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Width = 1788
         Width = 3036
         Width = 1200
         Width = 1860
         Width = 6456
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OrderView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OrderView'
GO
USE [master]
GO
ALTER DATABASE [TradeAnisimov] SET  READ_WRITE 
GO
