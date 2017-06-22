
/*
	Creates the user details table for the <%= this.SqlShortName %> web site.
*/

USE [DWS No Rep Data]
GO

BEGIN TRANSACTION

	/****** Object:  Table [dbo].[<%= this.SqlShortName %> User Details]    Script Date: 05/31/2015 11:31:06 ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[<%= this.SqlShortName %> User Details]') AND type in (N'U'))
	DROP TABLE [dbo].[<%= this.SqlShortName %> User Details]
	GO

	SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
	SET ANSI_PADDING ON
	GO

	CREATE TABLE [dbo].[<%= this.SqlShortName %> User Details](
		[User Id] [varchar](50) NOT NULL,
		[Client Filter Destination Ref] [int] NOT NULL,
	 CONSTRAINT [PK_<%= this.SqlShortName %> User Details] PRIMARY KEY CLUSTERED 
	(
		[User Id] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
	) ON [PRIMARY]

	GO

COMMIT TRANSACTION

