/*

	Author:			Rajendra Singh
	Date created:	27-Jul-2011
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Holds reference data for channels
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	19 Sep 2011		Saritha K						DataType for ChannelName is changed to varchar(20)

*/
IF OBJECT_ID(N'[tescosubscription].[ChannelMaster]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[ChannelMaster](
			[ChannelID] [tinyint] NOT NULL,
			[ChannelName] [varchar](20) NOT NULL,
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_ChannelMaster] PRIMARY KEY CLUSTERED 
		(
			[ChannelID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[ChannelMaster] ADD  CONSTRAINT [DF_ChannelMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[ChannelMaster] ADD  CONSTRAINT [DF_ChannelMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[ChannelMaster]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[ChannelMaster] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[ChannelMaster] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[ChannelMaster] already exists.'
	END
GO
