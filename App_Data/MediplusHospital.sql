USE [master]
GO
/****** Object:  Database [MediPlusHospital]    Script Date: 05-05-2025 03:00:54 ******/
CREATE DATABASE [MediPlusHospital]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MediPlusHospital', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\MediPlusHospital.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MediPlusHospital_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\MediPlusHospital_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MediPlusHospital] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MediPlusHospital].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MediPlusHospital] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MediPlusHospital] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MediPlusHospital] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MediPlusHospital] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MediPlusHospital] SET ARITHABORT OFF 
GO
ALTER DATABASE [MediPlusHospital] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MediPlusHospital] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MediPlusHospital] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MediPlusHospital] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MediPlusHospital] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MediPlusHospital] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MediPlusHospital] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MediPlusHospital] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MediPlusHospital] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MediPlusHospital] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MediPlusHospital] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MediPlusHospital] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MediPlusHospital] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MediPlusHospital] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MediPlusHospital] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MediPlusHospital] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MediPlusHospital] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MediPlusHospital] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MediPlusHospital] SET  MULTI_USER 
GO
ALTER DATABASE [MediPlusHospital] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MediPlusHospital] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MediPlusHospital] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MediPlusHospital] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MediPlusHospital] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MediPlusHospital] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MediPlusHospital] SET QUERY_STORE = ON
GO
ALTER DATABASE [MediPlusHospital] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MediPlusHospital]
GO
/****** Object:  Table [dbo].[Contactus]    Script Date: 05-05-2025 03:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contactus](
	[Sr] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[Phone] [varchar](13) NOT NULL,
	[EmailId] [varchar](40) NULL,
	[Subject] [varchar](100) NULL,
	[Message] [text] NULL,
	[SubmiteedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Sr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 05-05-2025 03:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Sr] [int] IDENTITY(1,1) NOT NULL,
	[DepName] [varchar](100) NULL,
	[AddedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Sr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dr_Appointment]    Script Date: 05-05-2025 03:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dr_Appointment](
	[Ap_Id] [int] IDENTITY(1,1) NOT NULL,
	[Pt_Id] [int] NULL,
	[Dr_Id] [int] NULL,
	[Department] [int] NULL,
	[App_Date] [varchar](12) NULL,
	[App_Time] [varchar](10) NULL,
	[Status] [varchar](15) NULL,
	[Reason] [text] NULL,
	[Submitted_At] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Ap_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dr_Registration]    Script Date: 05-05-2025 03:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dr_Registration](
	[Dr_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Adhar] [varchar](12) NOT NULL,
	[Gender] [varchar](10) NULL,
	[DOB] [varchar](11) NULL,
	[Address] [text] NULL,
	[User_Image] [varchar](120) NULL,
	[Qualification] [varchar](80) NULL,
	[Experience] [int] NULL,
	[Assigned_Department] [int] NULL,
	[Password] [varchar](15) NOT NULL,
	[Submitted_At] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Dr_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 05-05-2025 03:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[Sr] [int] IDENTITY(1,1) NOT NULL,
	[Pt_Id] [int] NOT NULL,
	[Message] [text] NULL,
	[Submitted_At] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Sr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LAB_Appointment]    Script Date: 05-05-2025 03:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LAB_Appointment](
	[T_Id] [int] IDENTITY(1,1) NOT NULL,
	[Pt_Id] [int] NULL,
	[TName] [varchar](50) NULL,
	[T_Date] [varchar](12) NULL,
	[T_Time] [varchar](10) NULL,
	[Status] [varchar](15) NULL,
	[Submitted_At] [datetime] NULL,
	[Test_Report] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[T_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pt_Registration]    Script Date: 05-05-2025 03:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pt_Registration](
	[Pt_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[FName] [varchar](60) NOT NULL,
	[DOB] [date] NULL,
	[Phone] [varchar](13) NOT NULL,
	[Email_Id] [varchar](50) NULL,
	[Gender] [varchar](10) NULL,
	[Adhar] [varchar](12) NULL,
	[Address] [varchar](150) NOT NULL,
	[MaritalStatus] [varchar](9) NULL,
	[Password] [varchar](15) NOT NULL,
	[Submitted_at] [datetime] NOT NULL,
	[Pt_Profile] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Pt_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 05-05-2025 03:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[Sr] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [varchar](100) NULL,
	[DepSr] [int] NULL,
	[AddedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Sr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Contactus] ON 

INSERT [dbo].[Contactus] ([Sr], [Name], [Phone], [EmailId], [Subject], [Message], [SubmiteedAt]) VALUES (1, N'Manish Sharma', N'8489383939', N'manish@gmail.com', N'Report Generation', N'i did not get report.', CAST(N'2025-05-02T23:27:43.000' AS DateTime))
INSERT [dbo].[Contactus] ([Sr], [Name], [Phone], [EmailId], [Subject], [Message], [SubmiteedAt]) VALUES (2, N'Shreyash Shrivastava', N'1234321244', N'srivastshreyash@gmail.com', N'Visiting info', N'are children allowed during visits patients and what are the visting hour?', CAST(N'2025-05-03T10:19:34.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Contactus] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (1, N'General Treatement', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (2, N'Emergency', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (3, N'Laboratory', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (4, N'Cardiology', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (5, N'Pediatrics', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (6, N'Orthopedics', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (7, N'ENT(Ear, Nose, & Throat)', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (8, N'Gynecology and Obstertics', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (9, N'Oncology', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Sr], [DepName], [AddedOn]) VALUES (10, N'Dermatology', CAST(N'2025-04-27T12:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[Dr_Appointment] ON 

INSERT [dbo].[Dr_Appointment] ([Ap_Id], [Pt_Id], [Dr_Id], [Department], [App_Date], [App_Time], [Status], [Reason], [Submitted_At]) VALUES (3, 1, 2, 9, N'2025-05-04', N'14:40', N'Completed', N'Painless, hard lump in the breast', CAST(N'2025-05-02T22:52:46.000' AS DateTime))
INSERT [dbo].[Dr_Appointment] ([Ap_Id], [Pt_Id], [Dr_Id], [Department], [App_Date], [App_Time], [Status], [Reason], [Submitted_At]) VALUES (4, 4, 4, 2, N'2025-05-04', N'10:10', N'Completed', N'Serere chest pain, tightness', CAST(N'2025-05-03T01:07:17.000' AS DateTime))
INSERT [dbo].[Dr_Appointment] ([Ap_Id], [Pt_Id], [Dr_Id], [Department], [App_Date], [App_Time], [Status], [Reason], [Submitted_At]) VALUES (5, 1, 5, 7, N'2025-05-03', N'06:00', N'Completed', N'Nose Bleeding', CAST(N'2025-05-03T06:12:12.000' AS DateTime))
INSERT [dbo].[Dr_Appointment] ([Ap_Id], [Pt_Id], [Dr_Id], [Department], [App_Date], [App_Time], [Status], [Reason], [Submitted_At]) VALUES (6, 4, 2, 9, N'2025-05-03', N'16:00', N'Approved', N',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,', CAST(N'2025-05-03T13:00:29.000' AS DateTime))
INSERT [dbo].[Dr_Appointment] ([Ap_Id], [Pt_Id], [Dr_Id], [Department], [App_Date], [App_Time], [Status], [Reason], [Submitted_At]) VALUES (7, 4, 6, 4, N'2025-05-10', N'16:30', N'Approved', N'Chest pain during physical activity, for the last 3 days.', CAST(N'2025-05-05T01:28:23.000' AS DateTime))
INSERT [dbo].[Dr_Appointment] ([Ap_Id], [Pt_Id], [Dr_Id], [Department], [App_Date], [App_Time], [Status], [Reason], [Submitted_At]) VALUES (8, 1, NULL, 7, N'2025-05-20', N'15:40', N'Pending', N'Ear Infection', CAST(N'2025-05-05T01:33:34.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Dr_Appointment] OFF
GO
SET IDENTITY_INSERT [dbo].[Dr_Registration] ON 

INSERT [dbo].[Dr_Registration] ([Dr_Id], [Name], [Phone], [Email], [Adhar], [Gender], [DOB], [Address], [User_Image], [Qualification], [Experience], [Assigned_Department], [Password], [Submitted_At]) VALUES (2, N'Brijesh Rai', N'1234321244', N'brijesh@gmail.com', N'123456789076', N'male', N'02/05/1980', N'P382+35R Ayodhya', N'user3.jpeg', N'MD', 10, 9, N'br@12', CAST(N'2025-05-02T22:34:13.000' AS DateTime))
INSERT [dbo].[Dr_Registration] ([Dr_Id], [Name], [Phone], [Email], [Adhar], [Gender], [DOB], [Address], [User_Image], [Qualification], [Experience], [Assigned_Department], [Password], [Submitted_At]) VALUES (4, N'Suman Chaubey', N'7652342536', N'suman@gmail.com', N'674365467347', N'female', N'20/04/2000', N'Ragadganj Gonda', N'user8.jpeg', N'MD (Emergency Medicine)', 1, 2, N'suman!123', CAST(N'2025-05-03T00:40:04.000' AS DateTime))
INSERT [dbo].[Dr_Registration] ([Dr_Id], [Name], [Phone], [Email], [Adhar], [Gender], [DOB], [Address], [User_Image], [Qualification], [Experience], [Assigned_Department], [Password], [Submitted_At]) VALUES (5, N'Ankush Yadav', N'8342889747', N'ankush@gmail.com', N'763476467348', N'male', N'14/05/1998', N'456 Market Road Melbourne', N'user12.jpeg', N'MS (ENT)', 3, 7, N'ankush!123', CAST(N'2025-05-03T00:42:56.000' AS DateTime))
INSERT [dbo].[Dr_Registration] ([Dr_Id], [Name], [Phone], [Email], [Adhar], [Gender], [DOB], [Address], [User_Image], [Qualification], [Experience], [Assigned_Department], [Password], [Submitted_At]) VALUES (6, N'Supriya Rai', N'6742743243', N'supriya@gmail.com', N'672663454545', N'female', N'12/09/1995', N'Ghandi Nagar Lucknow', N'user14.jpeg', N'DM (Cardiology)', 4, 4, N'supriya!123', CAST(N'2025-05-03T00:51:57.000' AS DateTime))
INSERT [dbo].[Dr_Registration] ([Dr_Id], [Name], [Phone], [Email], [Adhar], [Gender], [DOB], [Address], [User_Image], [Qualification], [Experience], [Assigned_Department], [Password], [Submitted_At]) VALUES (7, N'Nagesh Shrivastava', N'6723423442', N'nagesh@gmail.com', N'672346734453', N'male', N'04/08/1990', N'Arya Nagar Kanpur', N'user7.jpeg', N'MD (Pediatrics)', 8, 5, N'nagesh!123', CAST(N'2025-05-03T00:54:11.000' AS DateTime))
INSERT [dbo].[Dr_Registration] ([Dr_Id], [Name], [Phone], [Email], [Adhar], [Gender], [DOB], [Address], [User_Image], [Qualification], [Experience], [Assigned_Department], [Password], [Submitted_At]) VALUES (8, N'Anamika Sulka', N'1234321244', N'anamika@gmail.com', N'123456789076', N'female', N'25/05/1999', N'Ambedkar Nagar Gonda', N'user16.jpeg', N'DNB (Dermatology)', 3, 10, N'Anamika!123', CAST(N'2025-05-05T01:37:59.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Dr_Registration] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([Sr], [Pt_Id], [Message], [Submitted_At]) VALUES (1, 1, N'This hospital maintains excellent hygiene and the staff is courteous. Waiting times could be improved.', CAST(N'2025-05-02T23:03:04.000' AS DateTime))
INSERT [dbo].[Feedback] ([Sr], [Pt_Id], [Message], [Submitted_At]) VALUES (2, 2, N'The doctors explained everything clearly and made me feel at ease.', CAST(N'2025-05-03T10:23:58.000' AS DateTime))
INSERT [dbo].[Feedback] ([Sr], [Pt_Id], [Message], [Submitted_At]) VALUES (4, 4, N'Exellent service from admission to discharge.', CAST(N'2025-05-03T10:25:41.000' AS DateTime))
INSERT [dbo].[Feedback] ([Sr], [Pt_Id], [Message], [Submitted_At]) VALUES (5, 1, N'Some patients might appreciate more proactive communication about treatment plans and potential outcomes. ', CAST(N'2025-05-05T01:48:02.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[LAB_Appointment] ON 

INSERT [dbo].[LAB_Appointment] ([T_Id], [Pt_Id], [TName], [T_Date], [T_Time], [Status], [Submitted_At], [Test_Report]) VALUES (1, 1, N'25', N'2025-05-03', N'15:00', N'Completed', CAST(N'2025-05-02T23:00:51.000' AS DateTime), N'Bill Gates.jpg')
INSERT [dbo].[LAB_Appointment] ([T_Id], [Pt_Id], [TName], [T_Date], [T_Time], [Status], [Submitted_At], [Test_Report]) VALUES (2, 1, N'26', N'2025-05-03', N'06:30', N'Approved', CAST(N'2025-05-03T06:43:48.000' AS DateTime), NULL)
INSERT [dbo].[LAB_Appointment] ([T_Id], [Pt_Id], [TName], [T_Date], [T_Time], [Status], [Submitted_At], [Test_Report]) VALUES (5, 4, N'26', N'2025-05-14', N'10:30', N'Approved', CAST(N'2025-05-05T01:31:12.000' AS DateTime), NULL)
INSERT [dbo].[LAB_Appointment] ([T_Id], [Pt_Id], [TName], [T_Date], [T_Time], [Status], [Submitted_At], [Test_Report]) VALUES (6, 1, N'28', N'2025-05-17', N'19:00', N'Pending', CAST(N'2025-05-05T01:34:04.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LAB_Appointment] OFF
GO
SET IDENTITY_INSERT [dbo].[Pt_Registration] ON 

INSERT [dbo].[Pt_Registration] ([Pt_Id], [Name], [FName], [DOB], [Phone], [Email_Id], [Gender], [Adhar], [Address], [MaritalStatus], [Password], [Submitted_at], [Pt_Profile]) VALUES (1, N'Madhu Mishra', N'Ajay Mishra', CAST(N'2001-05-02' AS Date), N'8489383939', N'madhu@gmail.com', N'Female', N'344565657767', N'AAdamapur Gonda UP', N'female', N'madhu@12', CAST(N'2025-05-02T22:42:38.000' AS DateTime), N'user4.jpeg')
INSERT [dbo].[Pt_Registration] ([Pt_Id], [Name], [FName], [DOB], [Phone], [Email_Id], [Gender], [Adhar], [Address], [MaritalStatus], [Password], [Submitted_at], [Pt_Profile]) VALUES (2, N'Ravi', N'Anup Rai', CAST(N'1990-08-15' AS Date), N'8282882882', N'ravi@gmail.com', N'Male', N'344565657767', N'Gonda', N'male', N'Ravi#123', CAST(N'2025-05-03T00:06:30.000' AS DateTime), N'user1.jpeg')
INSERT [dbo].[Pt_Registration] ([Pt_Id], [Name], [FName], [DOB], [Phone], [Email_Id], [Gender], [Adhar], [Address], [MaritalStatus], [Password], [Submitted_at], [Pt_Profile]) VALUES (4, N'Aarvi Maurya', N'ragneesh Maurya', CAST(N'2019-11-15' AS Date), N'7652342536', N'aarvi@gmail.com', N'Female', N'457865434567', N'Dhyal Bagh Colony GD', N'female', N'aarvi!123', CAST(N'2025-05-03T01:04:05.000' AS DateTime), N'user10.jpeg')
SET IDENTITY_INSERT [dbo].[Pt_Registration] OFF
GO
SET IDENTITY_INSERT [dbo].[Services] ON 

INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (1, N'Fever & Infection Treatment', 1, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (2, N'Diabetes & Hypertension', 1, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (3, N'Preventive health checkups', 1, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (4, N'Emergency Triage & Treatment', 2, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (5, N'Trauma care', 2, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (6, N'Echocardiography', 4, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (7, N'Stress test', 4, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (8, N'Cardiac catheterization', 4, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (9, N'Bone fracture treatment', 6, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (10, N'Joint replacement surgeries', 6, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (11, N'Physiotherapy', 6, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (12, N'Orthopedic outpatient consultations', 6, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (13, N'Child vaccination', 5, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (14, N'Pediatric inpatient care', 5, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (15, N'Neonatal care', 5, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (16, N'Pediatric outpatient visits', 5, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (17, N'Antenatal check-ups', 8, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (18, N'Ultrasound for pregnancy', 8, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (19, N'Normal and C-section deliveries', 8, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (20, N'Family planning services', 8, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (21, N'Chemotherapy', 9, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (22, N'Radiation therapy', 9, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (23, N'Cancer screening', 9, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (24, N'Tumor biopsy', 9, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (25, N'Blood tests', 3, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (26, N'Urine analysis', 3, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (27, N'Pathology and histology', 3, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (28, N'COVID-19 testing', 3, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (29, N'Hearing tests (audiometry)', 7, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (30, N'Sinus treatment', 7, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (31, N'Tonsillectomy', 7, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (32, N'Endoscopy for ENT', 7, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (33, N'Skin allergy testing', 10, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (34, N'Acne and eczema treatment', 10, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (35, N'Laser therapy', 10, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
INSERT [dbo].[Services] ([Sr], [ServiceName], [DepSr], [AddedOn]) VALUES (36, N'Skin biopsy', 10, CAST(N'2025-04-29T10:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Services] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Departme__CFE04C2413D2A0AC]    Script Date: 05-05-2025 03:00:54 ******/
ALTER TABLE [dbo].[Department] ADD UNIQUE NONCLUSTERED 
(
	[DepName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dr_Appointment] ADD  CONSTRAINT [DF_Dr_Appointment_Status]  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[LAB_Appointment] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Dr_Appointment]  WITH CHECK ADD FOREIGN KEY([Dr_Id])
REFERENCES [dbo].[Dr_Registration] ([Dr_Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Dr_Appointment]  WITH CHECK ADD FOREIGN KEY([Pt_Id])
REFERENCES [dbo].[Pt_Registration] ([Pt_Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Dr_Appointment]  WITH CHECK ADD  CONSTRAINT [fk_Department] FOREIGN KEY([Department])
REFERENCES [dbo].[Department] ([Sr])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Dr_Appointment] CHECK CONSTRAINT [fk_Department]
GO
ALTER TABLE [dbo].[Dr_Registration]  WITH CHECK ADD FOREIGN KEY([Assigned_Department])
REFERENCES [dbo].[Department] ([Sr])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([Pt_Id])
REFERENCES [dbo].[Pt_Registration] ([Pt_Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LAB_Appointment]  WITH CHECK ADD FOREIGN KEY([Pt_Id])
REFERENCES [dbo].[Pt_Registration] ([Pt_Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Services]  WITH CHECK ADD FOREIGN KEY([DepSr])
REFERENCES [dbo].[Department] ([Sr])
ON DELETE CASCADE
GO
USE [master]
GO
ALTER DATABASE [MediPlusHospital] SET  READ_WRITE 
GO
