
/*
	Creates custom-report tables for the <%= this.SqlShortName %> web site, using the same
	definitions and relationships as the Hydra web site.

    NB: You can uncomment the code at the bottom for a sample report instance.
*/

USE [DWS No Rep Data]
GO


BEGIN TRANSACTION


	IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_<%= this.SqlShortName %> Report Assignments_<%= this.SqlShortName %> Assignable Reports]') AND parent_object_id = OBJECT_ID(N'[dbo].[<%= this.SqlShortName %> Report Assignments]'))
	ALTER TABLE [dbo].[<%= this.SqlShortName %> Report Assignments] DROP CONSTRAINT [FK_<%= this.SqlShortName %> Report Assignments_<%= this.SqlShortName %> Assignable Reports]
	GO

	/****** Object:  Table [dbo].[<%= this.SqlShortName %> Report Assignments]    Script Date: 04/30/2015 17:19:36 ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[<%= this.SqlShortName %> Report Assignments]') AND type in (N'U'))
	DROP TABLE [dbo].[<%= this.SqlShortName %> Report Assignments]
	GO

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[<%= this.SqlShortName %> Assignable Reports]') AND type in (N'U'))
	DROP TABLE [dbo].[<%= this.SqlShortName %> Assignable Reports]
	GO

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[<%= this.SqlShortName %> Reports]') AND type in (N'U'))
	DROP TABLE [dbo].[<%= this.SqlShortName %> Reports]
	GO


	SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
	SET ANSI_PADDING ON
	GO


	/****** Object:  Table [dbo].[<%= this.SqlShortName %> Reports]    Script Date: 04/30/2015 17:35:00 ******/
	/*

	NB: The [Cops Reports] table on which this is based was part of an aborted attempt to
	    build a dyanmic site map that would populate the user's custom reports as part of
	    the site-level menu tree.

	CREATE TABLE [dbo].[<%= this.SqlShortName %> Reports](
		[Report ID] [int] IDENTITY(1,1) NOT NULL,
		[Title] [varchar](100) NOT NULL,
		[URL] [varchar](200) NOT NULL,
		[Publicly Visible] [bit] NOT NULL,
	 CONSTRAINT [PK_<%= this.SqlShortName %> Reports] PRIMARY KEY CLUSTERED 
	(
		[Report ID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
	) ON [PRIMARY]
	GO
	*/

	/****** Object:  Table [dbo].[<%= this.SqlShortName %> Assignable Reports]    Script Date: 04/30/2015 17:15:51 ******/

	CREATE TABLE [dbo].[<%= this.SqlShortName %> Assignable Reports](
		[Report Id] [int] IDENTITY(1,1) NOT NULL,
		[Title] [varchar](100) NOT NULL,
		[Description] [varchar](250) NOT NULL,
		[URL] [varchar](250) NOT NULL,
	 CONSTRAINT [PK_<%= this.SqlShortName %> Assignable Reports] PRIMARY KEY CLUSTERED 
	(
		[Report Id] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	/****** Object:  Table [dbo].[<%= this.SqlShortName %> Report Assignments]    Script Date: 04/30/2015 17:19:36 ******/

	CREATE TABLE [dbo].[<%= this.SqlShortName %> Report Assignments](
		[Client Id] [int] NOT NULL,
		[Assignable Report Ref] [int] NOT NULL,
	 CONSTRAINT [PK_<%= this.SqlShortName %> Report Assignments] PRIMARY KEY CLUSTERED 
	(
		[Client Id] ASC,
		[Assignable Report Ref] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	ALTER TABLE [dbo].[<%= this.SqlShortName %> Report Assignments]  WITH CHECK ADD  CONSTRAINT [FK_<%= this.SqlShortName %> Report Assignments_<%= this.SqlShortName %> Assignable Reports] FOREIGN KEY([Assignable Report Ref])
	REFERENCES [dbo].[<%= this.SqlShortName %> Assignable Reports] ([Report Id])
	GO

	ALTER TABLE [dbo].[<%= this.SqlShortName %> Report Assignments] CHECK CONSTRAINT [FK_<%= this.SqlShortName %> Report Assignments_<%= this.SqlShortName %> Assignable Reports]
	GO


COMMIT TRANSACTION



/* Sample data for testing with the <%= this.SqlShortName %> web site */
/*
BEGIN TRANSACTION

	INSERT INTO [dbo].[<%= this.SqlShortName %> Assignable Reports]
			( [Title], [Description], [URL] )
	VALUES  ( 'Inventory Report', -- Title - varchar(100)
			  'Something Dan cooked up', -- Description - varchar(250)
			  'Clients/Inventory.aspx'  -- URL - varchar(250)
			  )

	INSERT INTO [dbo].[<%= this.SqlShortName %> Report Assignments]
			( [Client Id] ,
			  [Assignable Report Ref]
			)
	VALUES  ( 2145395472 , -- Client Id - int
			  1  -- Assignable Report Ref - int
			)

COMMIT TRANSACTION
*/
