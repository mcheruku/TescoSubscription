/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Create Lookup Table for subscriptionMaster 
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionMaster]',N'U') IS NULL
	BEGIN

		CREATE TABLE [tescosubscription].[SubscriptionMaster](
			[SubscriptionID] [tinyint] NOT NULL,
			[SubscriptionName] [varchar](30) NOT NULL,
			[UTCCreatedDateTime] [datetime] NOT NULL,
			[UTCUpdatedDateTime] [datetime] NOT NULL,
		 CONSTRAINT [PK_subscription.SubscriptionMaster] PRIMARY KEY CLUSTERED 
		(
			[SubscriptionID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [tescosubscription].[SubscriptionMaster] ADD  CONSTRAINT [DF_SubscriptionMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [tescosubscription].[SubscriptionMaster] ADD  CONSTRAINT [DF_SubscriptionMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionMaster]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[SubscriptionMaster] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[SubscriptionMaster] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[SubscriptionMaster] already exists.'
	END
GO
