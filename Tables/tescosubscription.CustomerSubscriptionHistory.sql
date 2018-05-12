/*

	Author:			Saminathan
	Date created:	27-Jul-2011
	Table Type:		Transactional
	Table Size:		
	Purpose:		Create Lookup Table for subscriptionMaster 
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]',N'U') IS NULL
	BEGIN

CREATE TABLE [tescosubscription].[CustomerSubscriptionHistory](
      [SubscriptionHistoryID]	[bigint] IDENTITY(1,1) NOT NULL,
      [CustomerSubscriptionID]  [bigint] NOT NULL,
      [SubscriptionStatus]      [tinyint] NOT NULL,
      [UTCCreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_CustomerSubscriptionHistory_UTCCreatedDateTime]  DEFAULT (getutcdate()),
      [Remarks]                 [varchar](400)  NULL,
 CONSTRAINT [PK_SubscriptionHistoryID] PRIMARY KEY CLUSTERED 
(
      [SubscriptionHistoryID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerSubscriptionHistory] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerSubscriptionHistory] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[CustomerSubscriptionHistory] already exists.'
	END
GO
