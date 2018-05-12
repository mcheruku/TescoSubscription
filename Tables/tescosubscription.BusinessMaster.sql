/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Table Type:		Reference
	Table Size:		Estimate < 100 Records
	Purpose:		Create Lookup Table for Business 
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[BusinessMaster]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[BusinessMaster](
			[BusinessID] [tinyint] NOT NULL,
			[BusinessName] [varchar](30) NOT NULL,
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_BusinessMaster] PRIMARY KEY CLUSTERED 
		(
			[BusinessID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[BusinessMaster] ADD  CONSTRAINT [DF_BusinessMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[BusinessMaster] ADD  CONSTRAINT [DF_BusinessMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[BusinessMaster]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[BusinessMaster] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[BusinessMaster] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[BusinessMaster] already exists.'
	END
GO
