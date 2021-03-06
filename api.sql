USE [BikeBase]
GO
/****** Object:  Table [dbo].[Bike]    Script Date: 19.02.2022 12:34:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bike](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Owner] [nvarchar](50) NOT NULL,
	[IDStatus] [int] NOT NULL,
	[IDType] [int] NOT NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_Bike] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 19.02.2022 12:34:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 19.02.2022 12:34:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bike] ON 

INSERT [dbo].[Bike] ([ID], [Title], [Owner], [IDStatus], [IDType], [Date]) VALUES (1, N'иааа', N'Шамильчик', 1, 1, CAST(N'2001-11-12' AS Date))
INSERT [dbo].[Bike] ([ID], [Title], [Owner], [IDStatus], [IDType], [Date]) VALUES (3, N'апдвап', N'ваыпыв', 1, 2, CAST(N'2008-01-01' AS Date))
INSERT [dbo].[Bike] ([ID], [Title], [Owner], [IDStatus], [IDType], [Date]) VALUES (4, N'ваываыв', N'ываыва', 2, 1, CAST(N'2002-04-02' AS Date))
INSERT [dbo].[Bike] ([ID], [Title], [Owner], [IDStatus], [IDType], [Date]) VALUES (1002, N'riotrw', N'Шамичик', 1, 1, CAST(N'2001-11-12' AS Date))
SET IDENTITY_INSERT [dbo].[Bike] OFF
GO
INSERT [dbo].[Status] ([ID], [Title]) VALUES (1, N'списан')
INSERT [dbo].[Status] ([ID], [Title]) VALUES (2, N'на парковке')
GO
INSERT [dbo].[Type] ([ID], [Title]) VALUES (1, N'спортивный')
INSERT [dbo].[Type] ([ID], [Title]) VALUES (2, N'обычный')
GO
ALTER TABLE [dbo].[Bike]  WITH CHECK ADD  CONSTRAINT [FK_Bike_Status] FOREIGN KEY([IDStatus])
REFERENCES [dbo].[Status] ([ID])
GO
ALTER TABLE [dbo].[Bike] CHECK CONSTRAINT [FK_Bike_Status]
GO
ALTER TABLE [dbo].[Bike]  WITH CHECK ADD  CONSTRAINT [FK_Bike_Type] FOREIGN KEY([IDType])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[Bike] CHECK CONSTRAINT [FK_Bike_Type]
GO
