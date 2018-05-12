/*

	Author:			Rajendra Singh
	Date created:	27-Jul-2011
	Table Type:		Reference
	Purpose:		Holds reference data for different status
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[StatusMaster](
			[StatusId] [tinyint] NOT NULL,
			[StatusCode] [tinyint] NOT NULL,
			[StatusName] [varchar](20) NOT NULL,
			[StatusType] [varchar](50) NOT NULL,
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_StatusMaster] PRIMARY KEY CLUSTERED 
		(
			[StatusId] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[StatusMaster] ADD  CONSTRAINT [DF_StatusMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[StatusMaster] ADD  CONSTRAINT [DF_StatusMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[StatusMaster] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[StatusMaster] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[StatusMaster] already exists.'
	END
GO
