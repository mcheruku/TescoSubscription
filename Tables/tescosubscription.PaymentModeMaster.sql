/*

	Author:			Rajendra Singh
	Date created:	27-Jul-2011
	Table Type:		Reference
	Purpose:		Holds different modes of payments
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PaymentModeMaster]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[PaymentModeMaster](
			[PaymentModeID] [tinyint] NOT NULL,
			[PaymentModeName] [varchar](50) NOT NULL,
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_PaymentModeMaster] PRIMARY KEY CLUSTERED 
		(
			[PaymentModeID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[PaymentModeMaster] ADD  CONSTRAINT [DF_PaymentModeMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[PaymentModeMaster] ADD  CONSTRAINT [DF_PaymentModeMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[PaymentModeMaster]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PaymentModeMaster] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PaymentModeMaster] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[PaymentModeMaster] already exists.'
	END
GO
