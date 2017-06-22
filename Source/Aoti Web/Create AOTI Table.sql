
USE [DWS No Rep Data]
GO 

/****** Object:  Table [dbo].[AOTI]    Script Date: 10/15/2008 16:11:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AOTI]') AND type in (N'U'))
DROP TABLE [dbo].[AOTI]

/****** Object:  Table [dbo].[AOTI]    Script Date: 10/15/2008 16:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AOTI](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Location] [varchar](100) NOT NULL,
	[Coil] [varchar](100) NOT NULL,
 CONSTRAINT [PK_AOTI] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
